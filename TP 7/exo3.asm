org 100h

mov     ax, 0b800h
mov     ds, ax


mov [02h], 'J'

mov [04h], 'u'

mov [06h], 'l'

mov [08h], 'e'

mov [0ah], 's'

mov [0ch], '!'

mov [0eh], '!'



mov ah, 0
int 16h

ret




