[BITS 16]               //Show that our system is running on 16bit 
[ORG 0x7c00]            //address of mbr

start:                  //label start, the segment below to init the segment register and stack pointer
    xor ax,ax           //Clear value of ax
    mov ds,ax           //Copy ax value to segment register
    mov es,ax  
    mov ss,ax
    mov sp,0x7c00       //the stack segment is 0 - 7c00

PrintMessage:           //This service is called by BIOS, cannot be call by OS
    mov ah,0x13         //reg ah hold function code 0x13 (print string)
    mov al,1            //Enable write mode, meaning the cursor will place at the end of string
    mov bx,0xa          //hold the color of character
    xor dx,dx           //set the position of cursor to Zero
    mov bp,Message
    mov cx,MessageLen 
    int 0x10            //Interrupt number to call the specific BIOS service

End:
    hlt    
    jmp End
     
Message:    db "Thang Nguyen BIOSv0.0.1 start      "
MessageLen: equ $-Message

times (0x1be-($-$$)) db 0       //number of loop

    db 80h
    db 0,2,0
    db 0f0h
    db 0ffh,0ffh,0ffh
    dd 1
    dd (20*16*63-1)
	
    times (16*3) db 0

    db 0x55
    db 0xaa

