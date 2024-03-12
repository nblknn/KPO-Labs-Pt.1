        org 100h

EntryPoint:
        mov     ah, 09h
        mov     dx, ProgramInfo
        int     21h


OutputInitialArray:
        mov     cx, 10
        mov     bx, 0
        mov     si, 0
.ArrayToStr:
        mov     dh, [Array + bx]
        cmp     dh, 0
        jnl     @F
        mov     [ArrayStr + si], '-'
        neg     dh
        inc     si
@@:
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


        mov     cx, 9
        mov     di, 1
        mov     bx, 0 ; min element index
FindMin:
        mov     ah, [Array + bx]
        mov     al, [Array + di]
        cmp     al, ah
        jnl     @F
        mov     bx, di
@@:
        inc     di
        loop    FindMin

        mov     cx, 9
        mov     di, 1
        mov     si, 0 ; max element index
FindMax:
        mov     ah, [Array + si]
        mov     al, [Array + di]
        cmp     al, ah
        jng     @F
        mov     si, di
@@:
        inc     di
        loop    FindMax


        cmp     si, bx
        ja      @F
        mov     ax, si
        mov     si, bx ; в si больший индекс
        mov     bx, ax ; в bx меньший

@@:
        mov     cx, si
        sub     cx, bx

Reverse:
        cmp     si, bx
        jb      OutputResult
        mov     ah, [Array + si]
        mov     al, [Array + bx]
        mov     [Array + bx], ah
        mov     [Array + si], al
        inc     bx
        dec     si
        loop    Reverse


OutputResult:
        mov     ah, 09h
        mov     dx, ResultMessage
        int     21h

        mov     cx, 10
        mov     bx, 0
        mov     si, 0
.ArrayToStr:
        mov     dh, [Array + bx]
        cmp     dh, 0
        jnl     @F
        mov     [ArrayStr + si], '-'
        neg     dh
        inc     si
@@:
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

Array           db      4, 1, 0, 6, 1, 2, 4, 9, 2, 5
ResultMessage    db      13, 10, "The result:", 13, 10, 36
ProgramInfo      db      "This program rearranges part of array between its min and max elements in reverse order.", 13, 10,"Initial array:", 13, 10, 36
ArrayStr        db      30 dup (?)