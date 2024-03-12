        org 100h

        mov     ah, 09h
        mov     dx, ProgramInfo
        int     21h

OutputInitialArray:
        mov     cx, 10
        mov     bx, 0
        mov     si, 0
.ArrayToStr:
        mov     dh, [Array + bx]
        add     dh, '0'
        mov     [ArrayStr + si], dh
        mov     [ArrayStr + si + 1], ' '
        add     si, 2
        inc     bx
        loop    .ArrayToStr
        mov     [ArrayStr + si], '$'

        mov     ah, 09h
        mov     dx, ArrayStr
        int     21h


        mov     cx, 5
        mov     bx, 0
        mov     si, 0
        mov     dl, 2

DoubleEvenFst:
        xor     ah, ah
        mov     al, [Array + bx]
        mov     [ResultArray + si], al
        div     dl
        test    ah, ah
        jnz     @F
        inc     si
        mov     al, [Array + bx]
        mov     [ResultArray + si], al

@@:
        inc     si
        inc     bx
        loop    DoubleEvenFst


        mov     cx, 5

DoubleEvenSec:
        xor     ah, ah
        mov     al, [Array + bx]
        mov     [ResultArray + si], al
        shr     al, 1
        jc      @F
        inc     si
        mov     al, [Array + bx]
        mov     [ResultArray + si], al

@@:
        inc     si
        inc     bx
        loop    DoubleEvenSec


OutputResultArray:
        mov     ah, 09h
        mov     dx, ResultMessage
        int     21h

        mov     cx, si
        mov     bx, 0
        mov     si, 0
.ArrayToStr:
        mov     dh, [ResultArray + bx]
        add     dh, '0'
        mov     [ArrayStr + si], dh
        mov     [ArrayStr + si + 1], ' '
        add     si, 2
        inc     bx
        loop    .ArrayToStr
        mov     [ArrayStr + si], '$'

        mov     ah, 09h
        mov     dx, ArrayStr
        int     21h

        mov     ax, 0C08h
        int     21h
        test    al, al
        jne     @F
        mov     ah, 08h
        int     21h

@@:
        ret

ProgramInfo     db      'This program doubles even numbers in array.', 13, 10, 'Initial array:', 13, 10, 36
ResultMessage   db      13, 10, 'The result:', 13, 10, 36
Array           db      4, 1, 3, 6, 1, 2, 1, 0, 2, 5
ResultArray     db      20 dup (?)
ArrayStr        db      40 dup (?)