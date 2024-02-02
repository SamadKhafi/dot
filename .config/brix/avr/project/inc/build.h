/**
 * @file build.h
 * @brief Project related build time information.
 *
 * @details This file provides build information about the project itself and
 * other useful information. This information is filled at the build time by
 * build system. This information can be used for debugging in the runtime
 * environment.
 */
#ifndef BUILD_H
#define BUILD_H

/// Project name.
extern const char *PROJECT_NAME;
/// Project version. i.e. 1.0.0 or 1.0.0-dev
extern const char *PROJECT_VERSION;
/// Build timestamp. i.e. 2023-11-25 09:04:51 UTC
extern const char *BUILD_TIMESTAMP;
/// Project build ID (git commit hash).
extern const char *PROJECT_BUILD_ID;

#endif
