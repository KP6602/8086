;Write a mixed language program to perform addition ,subtraction and division of two decimal numbers.
;Run This Code In Turbo c.

#include <stdio.h>
#include <conio.h>

void main()
{
    int i, a, b, c, r, ch = 0;
    clrscr();
    while (ch != 5)
    {
        printf("\n\n********Calculator********\n");
        printf("Select Operation\n");
        printf("\n1.ADD\n2.SUB\n3.MUL\n4.DIV\n5.EXIT\n");
        scanf("%d", &ch);
        if (ch > 0 && ch < 5)
        {
            printf("\nEnter two numbers\n");
            scanf("%d%d", &a, &b);
        }
        else if (ch != 5)
        {
            printf("Select valid opeartion");
        }
        switch (ch)
        {
        case 1:
            asm mov ax, a;
            asm mov bx, b;
            asm add ax, bx;
            asm mov c, ax;
            printf("\nSum = % d ", c);
            break;
        case 2:
            asm mov ax, a;
            asm mov bx, b;
            asm sub ax, bx;
            asm mov c, ax;
            printf("\nDifference= %d", c);
            break;
        case 3:
            asm mov ax, a;
            asm mov bx, b;
            for (i = 1; i < b; i++)
            {
                asm add ax, a;
            }
            asm mov c, ax;
            printf("\nProduct = %d", c);
            break;
        case 4:
            asm mov ax, a;
            asm mov bx, b;
            asm mov cx, 0h;
            while (a >= b)
            {
                asm sub ax, bx;
                asm mov a, ax;
                asm inc cx;
            }
            asm mov c, cx;
            asm mov r, ax;
            printf("\nQuotient =%d ", c);
            printf("Remainder = %d", r);
            break;
        }
    }
}