cmake_minimum_required(VERSION 3.10)

enable_language(C ASM)

set(CMAKE_C_STANDARD              99)
set(CMAKE_C_STANDARD_REQUIRED     ON)
set(CMAKE_C_EXTENSIONS            OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

project("ProjectName" VERSION "1.0.0" LANGUAGES C ASM)

set(OUTPUT_NAME     "firmware")
set(TARGET_NAME     "${OUTPUT_NAME}.elf")

string(TIMESTAMP    BUILD_TIMESTAMP "%Y-%m-%d %H:%M:%S UTC" UTC)

set(SOURCES_DIR     "${CMAKE_SOURCE_DIR}/Core/Src")
set(DRIVERS_DIR     "${CMAKE_SOURCE_DIR}/Drivers")
set(CMSIS_DIR       "${DRIVERS_DIR}/CMSIS")
set(DEVICE_DIR      "${DRIVERS_DIR}/CMSIS/Device/ST/STM32G0xx")
set(HAL_DIR         "${DRIVERS_DIR}/STM32G0xx_HAL_Driver")
set(FREERTOS_DIR    "${CMAKE_SOURCE_DIR}/Middlewares/Third_Party/FreeRTOS")

file(GLOB_RECURSE SRC_FILES         LIST_DIRECTORIES false "${SOURCES_DIR}/*.c")
file(GLOB_RECURSE HAL_FILES         LIST_DIRECTORIES false "${HAL_DIR}/Src/*.c")
file(GLOB_RECURSE FREERTOS_FILES    LIST_DIRECTORIES false "${FREERTOS_DIR}/*.c")

file(GLOB_RECURSE STARTUP_FILE      LIST_DIRECTORIES false "${CMAKE_SOURCE_DIR}/startup_*.s")
# set(STARTUP_FILE    "${CMAKE_SOURCE_DIR}/Core/Startup/startup_stm32g030f6px.s")

if(CMAKE_BUILD_TYPE MATCHES Debug)
    set(PROJECT_DEBUG "-dev")
endif()

execute_process(
    COMMAND             git log -n1 --format="%H"
    WORKING_DIRECTORY   ${CMAKE_CURRENT_SOURCE_DIR}
    OUTPUT_VARIABLE     PROJECT_BUILD_ID
)

string(REPLACE "\"" ""  PROJECT_BUILD_ID ${PROJECT_BUILD_ID})
string(REPLACE "\r" ""  PROJECT_BUILD_ID ${PROJECT_BUILD_ID})
string(REPLACE "\n" ""  PROJECT_BUILD_ID ${PROJECT_BUILD_ID})

configure_file("${SOURCES_DIR}/conf.c.i" "${CMAKE_CURRENT_BINARY_DIR}/conf.c" @ONLY)

add_executable(${TARGET_NAME}
    ${STARTUP_FILE}
    ${SRC_FILES}
    ${HAL_FILES}
    ${FREERTOS_FILES}

    "${CMAKE_CURRENT_BINARY_DIR}/conf.c"
)

target_compile_definitions(${TARGET_NAME} PRIVATE
    "-DUSE_HAL_DRIVER"
    "-DSTM32G0xx"
    "-DSTM32G030xx"
    "-DSTM32G030x6"
)

target_include_directories(${TARGET_NAME} PRIVATE
    "${CMAKE_SOURCE_DIR}/Core/Inc"
    "${CMSIS_DIR}/Include"
    "${DEVICE_DIR}/Include"
    "${HAL_DIR}/Inc"
    "${HAL_DIR}/Inc/Legacy"

    "${FREERTOS_DIR}/Source/include"
    "${FREERTOS_DIR}/Source/CMSIS_RTOS"
    "${FREERTOS_DIR}/Source/portable/GCC/ARM_CM0"

    "${PROJECT_BINARY_DIR}"
)

target_compile_options(${TARGET_NAME} PRIVATE
    "-mcpu=cortex-m0plus"
    "-mthumb"
    "-mfloat-abi=soft"

    "-fdata-sections"
    "-ffunction-sections"
    "-fno-common"
    "-fdump-rtl-expand" # generate function call tree
    "-fdump-tree-optimized" # generate function call tree
    "-fstack-usage" # generates stack usage (.su) files
    # "-flto" # link time optimizations

    "-Wall"
    "-Wshadow"
    "-Wformat-overflow"
    "-Wformat-truncation"
    "-Wstack-usage=128" # warns about stack usage more than 128 bytes

    $<$<CONFIG:Debug>:-O0>
    $<$<CONFIG:Release>:-Os>
)

target_link_options(${TARGET_NAME} PRIVATE
    "-T${CMAKE_SOURCE_DIR}/STM32G030F6PX_FLASH.ld"

    "-mcpu=cortex-m0plus"
    "-mthumb"
    "-mfloat-abi=soft"

    "-specs=nano.specs"

    "-lc"
    "-lm"

    # "-flto" # link time optimizations
    
    "-Wl,-Map=${OUTPUT_NAME}.map,--cref" # generates memory-map file
    "-Wl,--gc-sections"
    "-Wl,--print-memory-usage"
    # "-Wl,--print-gc-sections" # prints garbage collected sections
    "-Wl,--no-warn-rwx-segments"
)

add_custom_command(TARGET ${TARGET_NAME}
    POST_BUILD
    COMMAND echo "------------------------------------------------------------"
    COMMAND arm-none-eabi-size ${TARGET_NAME}
    COMMAND echo "------------------------------------------------------------"
    COMMAND arm-none-eabi-objcopy -O ihex ${TARGET_NAME} "${OUTPUT_NAME}.hex"
    COMMAND echo "[100%] Built target ${OUTPUT_NAME}.hex"
    COMMAND arm-none-eabi-objcopy -O binary -S ${TARGET_NAME} "${OUTPUT_NAME}.bin"
    COMMAND echo "[100%] Built target ${OUTPUT_NAME}.bin"
)
