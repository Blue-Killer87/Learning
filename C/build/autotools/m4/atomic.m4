# Use AC_ATOMIC in the configure.ac file, if you want to detect __atomic functions determined by the existence of the HAVE_ATOMIC_GNUC macro.
AC_DEFUN([AC_ATOMIC],[
	AC_REQUIRE([AC_PROG_CC])
	AC_LANG([C])
	AC_CACHE_CHECK([for compiler __atomic functions],[ac_cv_cc_atomic],[
		AC_LINK_IFELSE(
			[AC_LANG_PROGRAM(
				[[int x = 0;]],
				[[__atomic_add_fetch((&x),1,__ATOMIC_SEQ_CST);
				  __atomic_sub_fetch((&x),1,__ATOMIC_SEQ_CST);]]
			)],
			[ac_cv_cc_atomic=yes],
			[ac_cv_cc_atomic=no])
	])
	if test "$ac_cv_cc_atomic" = "yes"; then
		AC_DEFINE([HAVE_ATOMIC_GNUC],[1],[Define if you have __atomic builtins within GCC])
	fi
])
