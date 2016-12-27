data segment
    
    startstr db 'Chess Clock $'
    MSG1 db "Enter the value of counter:$"
    newline db 10,13,'$'
    count db 10 DUP('$')
    currp db 1
    min db ?
    sec db ?
    msg2 db "player1:       player2:$"
    secon db 09,?,?,':',6,0,09,09,09,?,?,':',6,0,13,'$'
data ends

printmacro macro p1
mov ah,09H
lea dx,p1
INT 21H 
endm
scanmacro macro p1
mov ah,0AH
lea dx,p1
INT 21H 
endm    



code segment
start: assume ds:data, cs:code

    mov ax,data
    mov ds,ax
    
    
    printmacro startstr
    printmacro newline
    printmacro MSG1
    printmacro newline
    scanmacro count
    printmacro newline
    
    
    mov al,count+2
    sub al,30H
    mov bl,count+3
    cmp bl,13
    jz ouz
    mov cl,10
    mov ah,00
    sub bl,30H
    mul cl
    add bl,al
    mov min,bl
    mov ah,0
    mov al,bl
    dec al
    mov cl,10
    div cl
    jmp cnt
    ouz:
    mov min,al
    mov bl,al
    mov ah,al
    mov al,00
    dec ah
    cnt:
        add al,30H
        add ah,30H
        mov secon+9,al
        mov secon+10,ah
        mov secon+1,al
        mov secon+2,ah
        mov secon+12,36H
        mov secon+13,30H
        mov sec,60
    
    printmacro newline
    printmacro msg2
    printmacro newline
    mov currp,1
    hello:
        mov ah,0
        mov al,bl
        dec al
        mov cl,10
        div cl
        add al,30H
        add ah,30H
        mov bh,60
        cmp currp,1
        jz p1
        mov secon+9,al
        mov secon+10,ah
        jmp hell
        p1:
        mov secon+1,al
        mov secon+2,ah
        jmp hell
        hella:
        jmp hello
        hell:
            mov ah,0
            mov al,bh
            mov cl,10
            div cl
            add al,30H
            add ah,30H
            cmp currp,2
            jz p2
            mov secon+4,al
            mov secon+5,ah
            jmp ddd
            helld:
             jmp hell
            p2:
            mov secon+12,al
            mov secon+13,ah
            ddd:
            printmacro secon
            MOV CX, 0Fh
            MOV DX, 4240h
            MOV AH, 86h
            INT 15h
            dec bh
            mov ah,1
            int 16h  ;Dipshil ur job is to find alternative of interrup
            jz kainai
            mov ah,0
            int 16h
            cmp ah,4Bh
            je left
            cmp ah,4Dh
            je right
            jmp kainai
            left:
                cmp currp,2
                je kainai
                mov currp,2
                jmp tmp
                hellb:
                    jmp hella
            right:
                cmp currp,1
                je kainai
                mov currp,1
            tmp:
                mov al,min
                mov ah,sec
                mov min,bl
                mov sec,bh
                mov bl,al
                mov bh,ah            
            kainai:
            inc bh
            dec bh
            jnz helld
        dec bl
        jnz hellb


    mov ah,4cH
    INT 21H
    
code ends
end start