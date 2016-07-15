#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <sys/types.h>
#include <inttypes.h>

int main(int argc, char **argv){
	u_int64_t size;
	int length=0;

	if (argc != 2){
		fprintf(stderr, "Usage: %s <size in bytes>\n", argv[0]);
		return(1);
	}

	size=(int)atoi(argv[1])*8;

	size=((u_int64_t)pow(2, size)) - 1;

	printf("size = %"PRIu64"\n", size);

	while (size>0){
		size /= 10;
		length++;
	}

	printf("Length = %d\n", length);

	return(0);
}

