#include <stdio.h>
int BinaryCode(int n);

int main()
{

//printf("library ieee;\n"   "use ieee.std_logic_1164.all;\n\n");

for (int i=0; i<=255; i++) 
{

 int x = i;
 
    while ( x > 0)
    {   
        int digit  = x % 10;
        x = x/10;
        printf("%d",  BinaryCode(digit)); 
} 


if (i == 0)
{
  printf(" \"110000001111111111111111");  
}


if (i > 0 )
  if (i <10 )
  {
{
  printf("1111111111111111");  
}}


if (i > 9)
{
if (i < 100 )
{
  printf("11111111");  
}
}
printf("\" ,  "); 
printf(" --%d ",i);
printf("\n \""); 

    
}
 return 0;
}


//function for binary value replacement

int BinaryCode(int n)
{
//int n;
int m = 0;

  if (n == 0)
{
    m = 11000000; //dp,g,f,e,d,c,b,a    0
} 
else if (n == 1)
{
    m = 11111001;  //dp,g,f,e,d,c,b,a   1
}
else if (n == 2)
{
    m = 10100100;  //dp,g,f,e,d,c,b,a   2
}
else if (n == 3)
{
    m = 10110000;  //dp,g,f,e,d,c,b,a   3     
}
else if (n == 4)
{
    m = 10011001;  //dp,g,f,e,d,c,b,a   4   
}
else if (n == 5)   
{
    m = 10010010;  //dp,g,f,e,d,c,b,a    5
}
else if (n == 6)
{
    m = 10000010;  //dp,g,f,e,d,c,b,a    6
}
else if (n == 7)
{
    m = 11111000;  //dp,g,f,e,d,c,b,a    7
}
else if (n == 8)
{
    m = 10000000;  //dp,g,f,e,d,c,b,a    8
}
else if (n == 9)
{
    m = 10010000;  //dp,g,f,e,d,c,b,a    9
}
   return m;
   
}