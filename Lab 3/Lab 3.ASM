        org 100h

EntryPoint:
        mov     ah, 09h
        mov     dx, ProgramInfo
        int     21h

        mov     bx, 0
        mov     cx, 10
.InputArray:
        mov     ah, 0Ah
        mov     dx, Num
        int     21h

        mov     ah, 09h
        mov     dx, NewLine
        int     21h

        mov     al, [Num + 2]
        cmp     al, "0"
        jb      .IncorrectInput
        cmp     al, "9"
        ja      .IncorrectInput

        sub     al, "0"
        mov     [Array + bx], al
        inc     bx
        loop    .InputArray
        jmp     @F

.IncorrectInput:
        mov     ah, 09h
        mov     dx, IncorrectMessage
        int     21h
        jmp     .InputArray


@@:
        xor     ax, ax  ; в al будет храниться значение суммы
        mov     bx, 0
        mov     cx, 10
.FindSum:
        add     al, [Array + bx]
        add     bx, 2
        dec     cx
        loop    .FindSum

        mov     [Sum], al
        mov     cl, 10
        mov     bx, 0

.IntToStrSum:
        div     cl
        cmp     al, 0
        je      @F
        add     al, '0'
        mov     [SumStr], al

        add     ah, '0'
        mov     [SumStr + 1], ah
        mov     [SumStr + 2], "$"
        jmp     .OutputResult
@@:
        add     ah, '0'
        mov     [SumStr], ah
        mov     [SumStr + 1], "$"


.OutputResult:
        mov     ah, 09h
        mov     dx, ResultMessage
        int     21h

        mov     ah, 09h
        mov     dx, SumStr
        int     21h

        mov     ax, 0C08h
        int     21h
        test    al, al
        jne     @F
        mov     ah, 08h
        int     21h

@@:
        ret


Sum     db      0
SumStr  db      3 dup(?)
Num     db      2, 0, 2 dup (?)
NewLine db      13, 10, "$"
ResultMessage  db      "Sum equals $"
ProgramInfo     db      "This program counts the sum of elements of array that have odd numbers.", 13, 10, "Enter 10 elements of array (0..9):", 13, 10, 36
IncorrectMessage        db    "You entered incorrect value! Try again: $"
Array   db      10 dup (?)