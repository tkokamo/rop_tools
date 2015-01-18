#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int func(char *a)
{
  char buf[300] = {};
  printf("buf = %p\n", buf);
  printf("puts = %p\n", puts);
  printf("system = %p\n", system);
  strcpy(buf, a);
  puts(buf);
}

int main(int argc, char **argv)
{
  func(argv[1]);
  return 0;
}
