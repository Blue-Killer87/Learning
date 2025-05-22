#ifndef __XREF_H__
#define __XREF_H__

#include <string.h>

#ifndef __GCC__
#define always_inline inline
#define __volatile__ volatile
#define __inline__ inline
#endif

#ifdef HAVE_ATOMIC_GNUC
#define xref_read(XREF) __atomic_add_fetch(&(XREF)->Ref, 0, __ATOMIC_SEQ_CST)
#define xref_get(XREF) __atomic_add_fetch(&(XREF)->Ref, 1, __ATOMIC_SEQ_CST)
#endif /* HAVE_ATOMIC_GNUC */

struct xref_s {
	int __volatile__ Ref;
};

static inline __attribute__((__always_inline__)) void
xref_init (struct xref_s *XRef)
{
	memset (XRef, 0, sizeof *XRef);
	xref_get(XRef);
}

#ifdef HAVE_ATOMIC_GNUC
static inline __attribute__((__always_inline__)) int
xref_put (struct xref_s *XRef, void (*release)(struct xref_s *XRef))
{
	if (__atomic_sub_fetch (&XRef->Ref, 1, __ATOMIC_SEQ_CST) == 0) {
		release (XRef);
		return 1;
	}
	return 0;
}
#endif /* HAVE_ATOMIC_GNUC */

#endif

