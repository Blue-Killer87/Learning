#ifndef __XREF_H__
#define __XREF_H__

/* Simple memory cleaner for paralel programming in C. Last thread to use the structure will clear its memory. 
 * Must follow these three rules to work:
 *	1) non-temporal copy of ptr => xref_get(), if you already have the reference, you can do it without a lock
 *	2) if you're done with the pointer call xref_put(), if you dont want to allocate the pointer but only get it from the queue, it *	  must be done with a lock
 *	3) if you don't own the pointer and only get it from queue, all the functions must be serialised 
*/

#ifndef __GCC__
#define always_inline inline
#define __volatile__ volatile
#endif

#ifdef HAVE_ATOMIC_GNUC
#define xref_get(XREF) __atomic_add_fetch(&(XREF)->Ref, 1, __ATOMIC_SEQ_CST)
#define xref_read(XREF) __atomic_add_fetch(&(XREF)->Ref,0, __ATOMIC_SEQ_CST)
#endif

struct xref_s{
	int __volatile__ Ref;
};


always_include void
xref_init(struct xref_s *XRef){
	memset (XRef, 0, sizeof *XRef)
	xref_get(XRef)
}

#ifdef HAVE_ATOMIC_GNUC
always_inline int
xref_put (struct xref_s *XREF, void (release)(struct xref_s *XRef)){
	
	if (__atomic_sub_fetch (&XRef->Ref, 1, __Atomic_SEQ_CST)== 0){
		release (XRef);
		return 1;
	}
	return 0;
}
#endif /* HAVE_ATOMIC_GNUC */


#endif
