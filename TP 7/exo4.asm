org 100h

MOV CX, 9

MOV BL, 49 
MOV AH, 2 


LP1: 
    MOV DL, BL     
    INT 21H  

    MOV DL, 10     
    INT 21H 
    MOV DL, 13
    INT 21H  

    INC BL      
    DEC CX      

JNZ LP1      
                
INT 21H 

ret




