/**
 * @file utils.h
 * @brief This is comman utilites file.
 *
 * @details This is file contains comman utility macros and functions.
 */

#ifndef UTILS_H
#define UTILS_H

// Conversions

/// Ticks per microsecond. Uses F_CPU to calculate the ticks. Where F_CPU is CPU
/// frequency.
#define TICKS_PER_MICROSECOND (F_CPU / 1000000)

// Useful macros
#define max(a, b)             (((a) > (b)) ? (a) : (b)) ///< Maximum out of `a` and `b`.
#define min(a, b)             (((a) < (b)) ? (a) : (b)) ///< Minimum out of `a` and `b`.

// Bit field and masking macros

/// Set `n`th bit.
#define bit(n)                (1 << n)
/// Sets bits of `x` variable high using `mask`.
#define bit_true(x, mask)     (x) |= (mask)
/// Sets bits of `x` variable low using `mask`.
#define bit_false(x, mask)    (x) &= ~(mask)
/// Checks if bits contained in `mask` is set high in `x`.
#define bit_istrue(x, mask)   ((x & mask) != 0)
/// Checks if bits contained in `mask` is set low in `x`.
#define bit_isfalse(x, mask)  ((x & mask) == 0)

#endif
