void sort_insertion(void *base, size_t n, size_t size, int(*cmp)(const void *, const void *))
{
	unsigned char *p, *p1, *p2;
	unsigned char *pbase = (unsigned char *) base;

	p = (unsigned char *) malloc(size);
	if (p == NULL) {
		return;
	}

	for (p1 = pbase + size;
		 p1 < pbase + n * size;
		 p1 += size)
	{
		memcpy(p, p1, size);
		
		for (p2 = p1;
		   	 p2 > pbase && cmp(p2 - size, p) > 0;
			 p2 -= size)
		{
			memcpy(p2, p2 - size, size);
		}

		if (p1 != p2) {
			memcpy(p2, p, size);
		}
	}
    free(p);
}