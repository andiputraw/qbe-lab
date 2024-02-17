#include <stdio.h>
#include <stdlib.h>
int main()
{
    char *buf = calloc(320, 4);
    fgets(buf, 2, stdin);
    printf(buf);
    return 0;
}