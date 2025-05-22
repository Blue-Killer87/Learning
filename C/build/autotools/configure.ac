AC_PREREQ([2.63])
AC_INIT([Linked List Library], [0.2], [martin.drab@fjfi.cvut.cz], [liblist])
AC_CONFIG_AUX_DIR([build-aux])
AM_INIT_AUTOMAKE([gnu])
AC_CONFIG_SRCDIR([include/list.h])
AC_CONFIG_HEADERS([config.h])
AC_USE_SYSTEM_EXTENSIONS
AC_SYS_LARGEFILE
AC_LANG([C])

LT_PREREQ([2.2.6])
LT_INIT([win32-dll])

# Checks for programs.
AC_PROG_CC
AC_PROG_INSTALL

# Checks for libraries.

# Checks for header files.
AC_CHECK_HEADERS([stdint.h])

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.
AC_ATOMIC

AC_CONFIG_FILES([Makefile
                 include/Makefile
                 src/Makefile
                 tests/Makefile])
AC_OUTPUT
