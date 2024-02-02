set(TRIPLE "avr")

if(UNIX)
  set(OS_SUFFIX "")

  find_path(TOOLCHAIN_ROOT
    NAMES
      "${TRIPLE}-gcc${OS_SUFFIX}"
    PATHS
      "/usr/bin"
      "/usr/local/bin"
      "/bin"

      "$ENV{AVR_ROOT}"
      "$ENV{HOME}/.local/bin"
      "$ENV{HOME}/bin"
)
elseif(WIN32)
  set(OS_SUFFIX ".exe")

  find_path(TOOLCHAIN_ROOT
    NAMES
      "${TRIPLE}-gcc${OS_SUFFIX}"
    PATHS
      "C:\\WinAVR\\bin"
      "$ENV{AVR_ROOT}"
  )
else()
  message(FATAL_ERROR "\"${TRIPLE}-gcc\" toolchain not supported on this OS!")
endif()

# check if toolchain found
if(NOT TOOLCHAIN_ROOT)
  message(FATAL_ERROR "Cannot find \"${TRIPLE}-gcc\" toolchain!")
endif()

set(CMAKE_SYSTEM_NAME      "Generic")
set(CMAKE_SYSTEM_PROCESSOR "avr")
set(CMAKE_CROSSCOMPILING   1)

set(CMAKE_C_COMPILER   "${TOOLCHAIN_ROOT}/${TRIPLE}-gcc${OS_SUFFIX}"
      CACHE PATH "gcc"     FORCE)
set(CMAKE_CXX_COMPILER "${TOOLCHAIN_ROOT}/${TRIPLE}-g++${OS_SUFFIX}"
      CACHE PATH "g++"     FORCE)
set(CMAKE_AR           "${TOOLCHAIN_ROOT}/${TRIPLE}-ar${OS_SUFFIX}"
      CACHE PATH "ar"      FORCE)
set(CMAKE_LINKER       "${TOOLCHAIN_ROOT}/${TRIPLE}-ld${OS_SUFFIX}"
      CACHE PATH "linker"  FORCE)
set(CMAKE_NM           "${TOOLCHAIN_ROOT}/${TRIPLE}-nm${OS_SUFFIX}"
      CACHE PATH "nm"      FORCE)
set(CMAKE_OBJCOPY      "${TOOLCHAIN_ROOT}/${TRIPLE}-objcopy${OS_SUFFIX}"
      CACHE PATH "objcopy" FORCE)
set(CMAKE_OBJDUMP      "${TOOLCHAIN_ROOT}/${TRIPLE}-objdump${OS_SUFFIX}"
      CACHE PATH "objdump" FORCE)
set(CMAKE_STRIP        "${TOOLCHAIN_ROOT}/${TRIPLE}-strip${OS_SUFFIX}"
      CACHE PATH "strip"   FORCE)
set(CMAKE_RANLIB       "${TOOLCHAIN_ROOT}/${TRIPLE}-ranlib${OS_SUFFIX}"
      CACHE PATH "ranlib"  FORCE)
set(AVR_SIZE           "${TOOLCHAIN_ROOT}/${TRIPLE}-size${OS_SUFFIX}"
      CACHE PATH "size"    FORCE)

set(CMAKE_EXE_LINKER_FLAGS "-L /usr/lib/gcc/avr/4.8.2")

set(AVR_LINKER_LIBS "-lc -lm -lgcc -Wl,-lprintf_flt -Wl,-u,vfprintf")

macro(add_avr_executable target_name avr_mcu)
  # define file names we will be using
  set(elf_file ${target_name}-${avr_mcu}.elf)
  set(map_file ${target_name}-${avr_mcu}.map)
  set(hex_file ${target_name}-${avr_mcu}.hex)
  set(lst_file ${target_name}-${avr_mcu}.lst)

  # add elf target
  add_executable(${elf_file}
    ${ARGN}
  )

  # set compile and link flags for elf target
  set_target_properties(${elf_file}
    PROPERTIES
      COMPILE_FLAGS "-mmcu=${avr_mcu} -g -Os -w -fno-exceptions -ffunction-sections -fdata-sections -flto -fno-threadsafe-statics -MMD -MP"
      LINK_FLAGS    "-mmcu=${avr_mcu} -flto -Wl,-Map,${map_file} ${AVR_LINKER_LIBS}"
  )

  # generate the lst file
  add_custom_command(
    OUTPUT  ${lst_file}
    COMMAND ${CMAKE_OBJDUMP} -h -S ${elf_file} > ${lst_file}
    DEPENDS ${elf_file}
  )

  # create hex file
  add_custom_command(
    OUTPUT  ${hex_file}
    COMMAND ${CMAKE_OBJCOPY} -R .eeprom -O ihex ${elf_file} ${hex_file}
    DEPENDS ${elf_file}
  )

  # print elf size
  add_custom_command(
    OUTPUT  "print-size-${elf_file}"
    COMMAND ${AVR_SIZE} ${elf_file}
    DEPENDS ${elf_file}
  )

  # build the intel hex file for the device
  add_custom_target(${target_name}
    ALL
    DEPENDS ${hex_file} ${lst_file} "print-size-${elf_file}"
  )

  set_target_properties(${target_name}
    PROPERTIES
      OUTPUT_NAME ${elf_file}
  )
endmacro()
