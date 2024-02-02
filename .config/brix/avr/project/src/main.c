/**
 * @file main.h
 * @brief This is the main file.
 *
 * @details This file contains main function and code for bootstaping
 * the system.
 */

#include "main.h"

#include <stdlib.h>

#include "avr/interrupt.h"
#include "avr/io.h"
#include "avr/pgmspace.h"
#include "avr/wdt.h"
#include "util/delay.h"

/**
 * @brief Main entry point of program.
 *
 * @return Process status code.
 * @note As this firmware is made for microcontrollers. This method will never
 * return. The `int` return is used because `C` requires it.
 */
int main(void)
{
    /* SETUP */

    /* LOOP */
    while (true)
    {
    }

    return EXIT_SUCCESS;
}
