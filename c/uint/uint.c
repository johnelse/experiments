#include <stdint.h>
#include <stdio.h>

void* main(int argc, char** argv) {
	uint32_t x;
	int gt0;

	x = -1;
	gt0 = (x >= 0);
	printf("%d", gt0);
}
