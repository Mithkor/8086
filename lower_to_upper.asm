MODEL SMALL
.STACK 200H
.DATA

MESSAGE_IN          DB 0DH,0AH,'Enter a String Pl0x: $'
MESSAGE_OUT         DB 0DH,0AH,'JUST PRESS CAPS NEXT TIME: $'
MSG                 DB 255 DUP('$')
NEWLINE             DB 0DH,0AH,'$'

.CODE
.STARTUP

          PUSH AX
          MOV AH,AL
          MOV AL,AH
          XOR AX,AX

          LEA DX,MESSAGE_IN
          MOV AH,09H     
          INT 21H

          LEA SI,MSG
          MOV AH,01H     
            
READ:
          INT 21H
          MOV BL,AL

          CMP AL,0DH
          JE  OUTPUT
            
          CMP AL,'a'
          JL LOWER
          
          CMP AL,'Z'
          JG UPPER

LOWER:
          MOV [SI],AL
          INC SI
            
          CMP BL,0DH
          JMP READ

UPPER: 
          MOV [SI],AL
          INC SI
            
          CMP BL,0DH
          JMP READ
  
OUTPUT:
          MOV AL,'$'
          MOV [SI],AL

          LEA DX,MESSAGE_OUT
          MOV AH,09H
          INT 21H


          LEA DX,MSG
          MOV AH,09H
          INT 21H

          MOV AH,4CH
          INT 21H
          
.EXIT
END
