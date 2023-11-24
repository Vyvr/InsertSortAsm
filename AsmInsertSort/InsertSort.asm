INCLUDE Irvine32.inc

.data
    arraySize DWORD 10
    array DWORD 10 dup (?)

    promptPassValues db "Pass 10 values to array:", 0
    promptOriginal db "Original array:", 0
    promptSorted db "Sorted array:", 0

.code
main PROC
    ; Read numbers into the array
    mov edx, OFFSET promptPassValues
    call WriteString
    call Crlf
    call ReadArray

    ; Display the original array
    mov edx, OFFSET promptOriginal
    call WriteString
    call Crlf
    call DisplayArray

    ; Sort the array using Insertion Sort
    call InsertionSort

    ; Display the sorted array
    mov edx, OFFSET promptSorted
    call WriteString
    call Crlf
    call DisplayArray

    exit
main ENDP

; Insertion Sort procedure
InsertionSort PROC
    mov ecx, 1

insertion_sort_loop:
    cmp ecx, arraySize
    jae end_sort

    mov edx, ecx                ; edx -> idzie po posortowanej czesci
    lea esi, [array + ecx * 4]  ; esi -> pointer na element do wstawienia
    mov eax, [esi]

inner_loop:
    lea esi, [array + edx * 4 - 4] ; Poprzedni element
    cmp edx, 0
    jle insert_here

    cmp eax, [esi]
    jge insert_here

    ; Przesuwanie poprzedniego elementu w prawo
    mov ebx, [esi]
    lea edi, [esi + 4]
    mov [edi], ebx
    dec edx
    jmp inner_loop

insert_here:
    lea edi, [array + edx * 4]
    mov [edi], eax
    inc ecx
    jmp insertion_sort_loop

end_sort:
    ret
InsertionSort ENDP


; Procedure to display the array
DisplayArray PROC
    mov ecx, arraySize
    lea esi, array
display_loop:
    mov eax, [esi]
    call WriteInt
    call Crlf
    add esi, 4
    loop display_loop
    ret
DisplayArray ENDP

; Procedure to read the array
ReadArray PROC
    mov ecx, arraySize
    lea esi, array
read_loop:
    call ReadInt
    mov [esi], eax
    add esi, 4
    loop read_loop
    ret
ReadArray ENDP

END main