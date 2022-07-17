            #start=led_display.exe#

name "led"
             org 100h 
                      
.data
a db "Enter the money:$"
b db "$"
.code
                mov ax,@data
                mov ds,ax
                    
                lea dx,a
                mov ah,09h
                int 21h
                
                mov ah,01h
                int 21h 
                sub al,30h 
                mov bh,0ah 
                mul bh
                
                mov bx,ax
                
                mov ax,@data
                mov ds,ax
                    
                lea dx,b
                mov ah,09h
                int 21h
                
                mov ah,01h
                int 21h
                sub al,30h 
                mov ah,00h
                add bx,ax 
                
                
                CMP     BL, 01H
               
                JNZ     NEXT
    
                MOV     CX, 004CH 
    
                MOV     DX, 4B40H  
    
                MOV     AH, 86H  
    
                INT     15H 
                JMP     OUT_1


NEXT:           CMP     BL, 05H
               
                JNZ     NEXT_1
    
                MOV     CX, 01C9H 
    
                MOV     DX, 0C380H  
    
                MOV     AH, 86H  
    
                INT     15H
                JMP     OUT_1

NEXT_1:         CMP     BL, 0AH
               
                JNZ     OUT_1
    
                MOV     CX, 0393H 
    
                MOV     DX, 8700H  
    
                MOV     AH, 86H  
    
                INT     15H  
                

OUT_1:          MOV AX, 0000H
                OUT 199, AX
                MOV AX, 3     ; text mode 80x25, 16 colors, 8 pages (ah=0, al=3)
                INT 10H       ; do it!

                 ; cancel blinking and enable all 16 colors:
                 MOV AX, 1003H
                 MOV BX, 0
                 INT 10H


                 ; set segment register:
                 MOV     AX, 0B800H
                 MOV     DS, AX

                 ; print "Time is over"
                 ; first byte is ascii code, second byte is color code.

                 MOV [02H], 'T'

                 MOV [04H], 'i'

                 MOV [06H], 'm'

                 MOV [08H], 'e'

                 MOV [0AH], ' '

                 MOV [0CH], 'i'

                 MOV [0EH], 's'
 
                 MOV [10H], ' '

                 MOV [12H], 'o'

                 MOV [14H], 'v'

                 MOV [16H], 'e'

                 MOV [18H], 'r'




                 ; color all characters:
                 MOV CX, 12  ; number of characters.
                 MOV DI, 03h ; start from byte after 'h'
C:               MOV [DI], 11101100b   ; light red(1100) on yellow(1110)
                 ADD DI, 2 ; skip over next ascii code in vga memory.
                 LOOP C

                      ; wait for any key press:
                 MOV AH, 0
                 INT 16h

                 RET   
                
                 END
                 
               
                
                
                
                
                          
                
                    
                
                
                


