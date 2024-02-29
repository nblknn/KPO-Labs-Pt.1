        org 100h

Start:
        mov     ah, 09h
        mov     dx, condition
        int     21h

        mov     ah, 0Ah
        mov     dx, strInput
        int     21h

        xor     bx, bx
        mov     bl, [strInput + 1]
        cmp     bl, 4
        jb      IncorrectInput

        mov     dl, [strInput + 2]
        mov     cl, [strInput + 5]
        cmp     dl, cl
        jne     IncorrectInput

        mov     dl, [strInput + 3]
        cmp     dl, '0'
        jb      IncorrectInput
        cmp     dl, '9'
        ja      IncorrectInput

        mov     cl, [strInput + bx]
        cmp     cl, '0'
        jb      IncorrectInput
        cmp     cl, '9'
        ja      IncorrectInput

        mov     ah, 09h
        mov     dx, correctMessage
        int     21h
        jmp     ReadChar

IncorrectInput:
        mov     ah, 09h
        mov     dx, incorrectMessage
        int     21h

ReadChar:
        mov     ax, 0C08h
        int     21h
        test    al, al
        jnz     @F
        mov     ah, 08h
        int     21h
@@:
        ret

condition       db      "This program checks if entered string is correct.", 13, 10, "Requirements for correct string: 4<=Length<=10; S[1] = S[4]; S[2] and S[Length-1] are numbers", 13, 10, "Enter your string: $"
correctMessage         db      13, 10, "Yes$"
incorrectMessage       db      13, 10, "No$"
strInput        db      11, 0, 11 dup (?)