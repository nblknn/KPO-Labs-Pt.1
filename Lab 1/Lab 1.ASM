        org 100h

Start:

        mov     ah, 09h
        mov     dx, condition
        int     21h

        mov     ah, 0Ah
        mov     dx, bufInput
        int     21h

        mov     ah, 09h
        mov     dx, newLine
        int     21h

        mov     cl, [bufInput + 2]
        mov     al, [bufInput + 3]
        mov     [bufInput + 2], al
        mov     [bufInput + 3], cl

        mov     cl, [bufInput + 7]
        sub     cl, [bufInput + 10]
        add     cl, [bufInput + 6]
        mov     [bufInput + 8], cl

        xor     bx, bx
        mov     bl, [bufInput + 1]
        mov     di, bufInput
        mov     byte [bx + di + 2], '$' ;добавление в конец буфера $

        mov     ah, 09h
        mov     dx, bufInput + 2
        int     21h

        mov     ah, 08h
        int     21h

        ret

condition       db      "This program converts entered string.", 13, 10, "Enter a string with at least 9 symbols: $"
newLine         db      13, 10, "$"
bufInput        db      30, 0, 30 dup (?)