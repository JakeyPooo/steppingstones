#Author: Jacob Anderson
#RedID: 827419418
#Description: Navigate the correct path based on the given key. Score points based on how fast you traverse!
#

.data
iBoard: 	.word 0 1 0
		.word 1 1 0
		.word 1 0 0
		.word 1 1 1
		.word 0 0 1
		.word 0 1 1
		.word 1 1 0
		.word 1 0 0 
		.word 1 1 0
		.word 0 1 0
iBoard2:	.word 1 0 0
		.word 1 1 1
		.word 0 0 1
		.word 0 0 1
	 	.word 0 1 1
		.word 0 1 0
		.word 1 1 0
		.word 1 0 0 
	 	.word 1 1 0
	 	.word 0 1 1
iBoard3:	.word 0 1 1
	 	.word 0 1 0
	 	.word 1 1 0
	 	.word 1 0 0
	 	.word 1 0 0
	 	.word 1 1 1
	 	.word 0 0 1
	 	.word 0 1 1 
	 	.word 1 1 0
	 	.word 1 0 0
header:		.asciiz "\nLevel: "
header2: 	.asciiz " - Evenly divide by "
header3: 	.asciiz " - Timer: "	
row: 		.word 10
col: 		.word 3
newLine: 	.asciiz "\n"
space: 		.asciiz " "
startPos: 	.asciiz "\nWhere would you like to start? Enter a for left, w for middle, or d for right."
verify:		.asciiz "\nInvalid entry. Please enter a, d, or w."
piece:		.asciiz "XX"
move:		.asciiz "Which way would you like to move? Press w for up, a for left, or d for right. You can't move down on the board."
lose:		.asciiz "GAME OVER! You ran out of time! Better luck next time!\n"
win:		.asciiz "Congratulations! You won! Your final score is: "
time:		.word 60
	
.text
main: 
	#lw	$s1, row 	#loading row into memory; $s1 = row
	#lw 	$s2, col 	#loading col into memory; $s2 = col
	li 	$s5, 1		#level = 1; $s5 = level
	li 	$s6, 0		#k = 0; $s6 = k; count for arrayAddress
	lw	$s4, time	#loading the initial time into memory
	subi	$sp, $sp, 8	#allocating stack space
levelLoop:		
	bgt 	$s5, 3, finalExit	#if(level > 3); goto finalExit
	bne 	$s5, 1, level2	#if(level == 1){
	la 	$s0, iBoard 	#Loading the array into memory; $s0 = iBoard[0][0]
	li 	$s7, 3		#key = 3
	lw	$s4, time
	j 	resume		#}
level2: 			#else
	bne 	$s5, 2, level3	#if(level == 2){
	la 	$s0, iBoard2 	#Loading the array into memory; $s0 = iBoard2[0][0]
	li 	$s7, 7		#key = 7
	sw	$s4, 4($sp)	#saving the time from the first level in the stack
	li	$s4, 45		#resetting time
	j 	resume		#}
level3: 			#else
	bne 	$s5, 3, finalExit	#if(level == 3){
	la 	$s0, iBoard3	#Loading the array into memory; $s0 = iBoard3[0][0]
	li 	$s7, 13		#key = 13;
	sw	$s4, 0($sp)	#saving the time from the secon dlevel in the stack
	li	$s4, 30		#resetting time
	j resume		#}
resume:
	li 	$s6, 0		#resetting k
	jal 	loopPrint	#Jumping to function that'll print the array
resume1:
	j	pathStart		
	addi 	$s5, $s5, 1	#adding on to the level count 	
	li 	$v0, 4
	la 	$a0, newLine	#printing a new line at the end of each level
	syscall	
	j 	levelLoop	
finalExit:
	bgt	$s4, 0, bigDub	#if score is greater than 0, goto bigDub
	li	$v0, 4
	la	$a0, lose
	syscall			#printing lose prompt
	li	$v0, 10
	syscall			#PROGRAM END
bigDub:
	li	$v0, 4
	la	$a0, win
	syscall			#printing win prompt
	add	$t6, $s4, $zero	#adding the time from the third level
	lw	$t5, 4($sp)	#loading the time of the second level from the stack
	lw	$t4, 0($sp)	#loading the time of the first level from the stack
	add	$t6, $t6, $t5	#adding time
	add	$t6, $t6, $t4	#adding time
	li	$v0, 1
	add	$a0, $t6, $zero
	syscall			#printing final score
	li	$v0, 10
	syscall 		#PROGRAM END
loopPrint:
	lw	$t0, row 	#loading row into memory; $s1 = row
	li 	$t9, 0		#int i = 0
	li 	$v0, 4
	la 	$a0, header	#loading the level prompt
	syscall 		#printing the prompt	
	li 	$v0, 1
	add 	$a0, $s5, $zero	#copying $s5 register to $a0
	syscall			#printing level variable
	li 	$v0, 4
	la 	$a0, header2	#continuing the level prompt
	syscall 		#printing the prompt		
	li	$v0, 1
	add	$a0, $s7, $zero	#copying $s7 to $a0
	syscall			#printing key variable	
	li	$v0, 4
	la	$a0, header3	#finishing the level prompt
	syscall 		#printing the prompt	
	li	$v0, 1
	add	$a0, $s4, $zero
	syscall			#printing the timer value
For1:
	bge 	$t9, 10, resume1	#for(i = 0; i < row; i++)
	addi 	$t9, $t9, 1 	#i++
	li 	$t8, 0 		#sets j to 0 (j = 0)
	li 	$v0, 4
	la 	$a0, newLine 	#loading newLine to print
	syscall 		#printing a new line to make a grid
	j 	For2	
For2:
	bge 	$t8, 3, For1 	#for(j = 0; j < col; j++)
	jal 	arrayAddress 	#Jumping to array address calculation
	move 	$t7, $v0	#$t1 contains address
	li 	$v0, 1
	lw 	$a0, 0($t7)	#saving the value of the address
	bne 	$a0, 1, else	#if($a0 == 1){
	jal 	randNumMod	#$a0 = randNumMod
	li 	$v0, 1		#}
	j 	after		#completing the conditional
else: 				#else if($a0 != 1){
	jal 	randNumNotMod	#$a0 = randNumNotMod
	li 	$v0, 1		#}
after:			
	syscall 		#printing	
	li 	$v0, 4
	la 	$a0, space
	syscall			#printing a space for -*.*AESTHETICS*.*-	
	addi 	$t8, $t8, 1 	#j++
	addi 	$s6, $s6, 1	#k++
	j 	For2	
arrayAddress:
	bgt 	$s6, 30, resume1	#if($s6 < arraySize)
	sll 	$t2, $s6, 2	#$t2 = $s6 * 4
	add 	$t0, $s0, $t2	#$t0 = iBoard[0][0] + $t2
	move 	$v0, $t0		
	jr 	$ra 		#returning value
randNumMod:
	li	$v0, 42		#load random number
	li 	$a1, 89		#setting the higher bound
	syscall
	addi 	$a0, $a0, 10 	#setting the lower bound 
	rem 	$t1, $a0, $s7	#$t1 = $a0 % $s7
	bne 	$t1, 0, randNumMod	#if($t1 == 0){
	jr 	$ra		#return value in $a0
randNumNotMod:
	li 	$v0, 42		#load random number
	li 	$a1, 89		#setting the higher bound
	syscall
	addi 	$a0, $a0, 10 	#setting the lower bound 
	rem 	$t1, $a0, $s7	#$t1 = $a0 % $s7
	beq 	$t1, 0, randNumNotMod	#if($t1 != 0){
	jr 	$ra		#return value in $a0
pathStart:
	li 	$v0, 4
	la 	$a0, startPos	
	syscall			#printing startPos prompt
verifyInput:
	li	$v0, 12		
	syscall			#asking the starting position
	beq	$v0, 'a', aNext	#if($v0 == 'a') goto next:
	beq	$v0, 'd', dNext	#if($v0 == 'd') goto next:
	beq	$v0, 'w', wNext	#if($v0 == 'w') goto next:
	li 	$v0, 4		#else 
	la 	$a0, verify	#print verify prompt
	syscall
	j 	verifyInput	#rerun loop if input isn't valid
aNext:	
	li	$t7, 27		#loading 27 for the third to last index of the array
	sll	$t7, $t7, 2	
	add	$s3, $s0, $t7	#getting the array address of iBoard[9][0]
	li	$v0, 1
	lw	$a0, 0($s3)	#loading the value at the address
	beq	$a0, 1, validMove	#if the value of the array equals 1
	subi	$s4, $s4, 5	#subtract 5 from the timer
	jal	sInvalid
	jal	pResume1
validMove:
	jal	sValid
	jal	pResume1
wNext:	
	li	$t7, 28		#loading 28 for the second ot last index of the array
	sll	$t7, $t7, 2	
	add	$s3, $s0, $t7	#getting the array address of iBoard[9][1]
	li	$v0, 1
	lw	$a0, 0($s3)	#loading the value at the address
	beq	$a0, 1, validMove	#if the value of the array equals 1
	subi	$s4, $s4, 5	#subtract 5 from the timer
	jal	sInvalid
	j 	pResume1	
dNext:	
	li	$t7, 29		#loading 29 because 29 is the last index of the array
	sll	$t7, $t7, 2	
	add	$s3, $s0, $t7	#getting the array address of iBoard[9][2]
	li	$v0, 1
	lw	$a0, 0($s3)	#loading the value at the address
	beq	$a0, 1, validMove	#if the value of the array equals 1
	subi	$s4, $s4, 5	#subtract 5 from the timer
	jal	sInvalid
	j 	pResume1
pResume1:
	li 	$s6, 0		#resetting k
	jal	clearScreen	#jump to clearScreen function
	jal	initialTime	#calling the initialTime function
	sub	$s4, $s4, $s2	#subtracting the passed time from the initial time
	blt	$s4, 0, finalExit	#if the timer runs out, goto finalExit
	#~~~~~~~~~~~~~~~~~~~~~~~starting the new array print
	lw	$t0, row 	#loading row into memory; $s1 = row
	li 	$t9, 0		#int i = 0
	li 	$v0, 4
	la 	$a0, header	#loading the level prompt
	syscall 		#printing the prompt	
	li 	$v0, 1
	add 	$a0, $s5, $zero	#copying $s5 register to $a0
	syscall			#printing level variable
	li 	$v0, 4
	la 	$a0, header2	#continuing the level prompt
	syscall 		#printing the prompt	
	li	$v0, 1
	add	$a0, $s7, $zero	#copying $s7 to $a0
	syscall			#printing level variable
	li	$v0, 4
	la	$a0, header3	#finishing the level prompt
	syscall 		#printing the prompt
	li	$v0, 1
	add	$a0, $s4, $zero
	syscall			#printing the current score after each movement
pFor1:
	bge 	$t9, 10, pResume2	#for(i = 0; i < row; i++)
	addi 	$t9, $t9, 1 	#i++
	li 	$t8, 0 		#sets j to 0 (j = 0)
	li 	$v0, 4
	la 	$a0, newLine 	#loading newLine to print
	syscall 		#printing a new line to make a grid
	j 	pFor2	
pFor2:
	bge 	$t8, 3, pFor1 	#for(j = 0; j < col; j++)
	jal 	pArrayAddress 	#Jumping to array address calculation
	move 	$t7, $v0	#$t1 contains address
	beq	$s3, $t7, printX	#if address matches starting address, got to printX
	lw 	$a0, 0($t7)	#saving the value of the address
	bne 	$a0, 1, pElse	#if($a0 == 1){
	jal 	randNumMod	#$a0 = randNumMod
	li 	$v0, 1		#}
	j	pAfter
printX:	
	li	$v0, 4
	la	$a0, piece	#printing the piece in place of the number
	j 	pAfter
pElse: 				#else if($a0 != 1){
	jal 	randNumNotMod	#$a0 = randNumNotMod
	li 	$v0, 1		#}	
pAfter:	
	syscall 		#printing	
	li 	$v0, 4
	la 	$a0, space
	syscall			#printing a space for -*.*AESTHETICS*.*-	
	addi 	$t8, $t8, 1 	#j++
	addi 	$s6, $s6, 1	#k++
	j 	pFor2
pArrayAddress:
	bgt 	$s6, 30, pResume2	#if($s6 < arraySize)
	sll 	$t2, $s6, 2	#$t2 = $s6 * 4
	add 	$t0, $s0, $t2	#$t0 = iBoard[0][0] + $t2
	move 	$v0, $t0		
	jr 	$ra 		#returning value	
pResume2:
	li 	$v0, 4
	la 	$a0, newLine	#printing a new line at the end of each level
	syscall
	beq	$s3, $s0, levelUp	#if the piece's address($s3) matches the 	
	addi	$t9, $s0, 4		#address of any of the of the top row
	beq	$s3, $t9, levelUp	#add one to the level and repeat the loop.
	addi	$t9, $s0, 8		#
	beq	$s3, $t9, levelUp	#
	j	movePiece		#
levelUp:
	addi	$s5, $s5, 1	#adding one to the level count to change levels
	j	levelLoop	#jumping to levelLoop to start next level
movePiece:
	li	$v0, 4
	la	$a0, move
	syscall			#printing the move prompt
pVerifyInput:
	li	$v0, 12		
	syscall			#asking the starting position
	beq	$v0, 'a', mANext	#if($v0 == 'a') goto next:
	beq	$v0, 'd', mDNext	#if($v0 == 'd') goto next:
	beq	$v0, 'w', mWNext	#if($v0 == 'w') goto next:
	li 	$v0, 4		#else 
	la 	$a0, verify	#print verify prompt
	syscall
	j 	pVerifyInput	#rerun loop if input isn't valid
mANext:	
	jal	afterTime	#calling the afterTime function
	rem	$t9, $s3, $s0	#finding the remainder between the base address of the left column and the current location
	rem	$t9, $t9, 12	#finding the remainder of the previous remainder and 12
	beq	$t9, 0, pResume1	#if that remainder is 0, don't move the player piece to the left
	subi	$s3, $s3, 4	#subtracting 4 from the current location if the above conditionals aren't met
	lw	$a0, 0($s3)	#loading the value at the address
	beq	$a0, 1, validMove	#if the value of the array equals 1
	subi	$s4, $s4, 5	#subtract 5 from the timer
	jal	sInvalid
	j	pResume1
mDNext:	
	jal	afterTime	#calling the afterTime function
	rem	$t9, $s3, $s0	#finding the remainder between the base address of the left column and the current location
	rem	$t9, $t9, 12	#finding the remainder of the previous remainder and 12
	subi	$t9, $t9, 8	#adding 8 to that remainder to shift over to the right column
	beq	$t9, 0, pResume1	#if that new value is 0, don't move the player piece to the right
	addi	$s3, $s3, 4	#adding 4 to the current piece location to move the player right
	lw	$a0, 0($s3)	#loading the value at the address
	beq	$a0, 1, validMove	#if the value of the array equals 1
	subi	$s4, $s4, 5	#subtract 5 from the timer
	jal	sInvalid
	j	pResume1
mWNext:	
	jal	afterTime	#calling the afterTime function
	subi	$s3, $s3, 12	#subtracting 12 from the current piece location to move the player upward
	lw	$a0, 0($s3)	#loading the value at the address
	beq	$a0, 1, validMove	#if the value of the array equals 1
	subi	$s4, $s4, 5	#subtract 5 from the timer
	jal	sInvalid
	j	pResume1
clearScreen:			#Function to clear the screen whenever called. 
	li	$t0, 0		#sets a temp register to 0
clrLoop:
	bgt	$t0, 25, return	#while loop that keeps printing a new line if the temp variable
	li	$v0, 4		#is less than 25
	la	$a0, newLine
	syscall
	addi 	$t0, $t0, 1
	j	clrLoop
return:
	jr	$ra	
sInvalid:
	li	$v0, 31		#loading the MIDI sound
	li	$a0, 120	#setting the pitch
	li	$a1, 75		#setting the duration in ms
	li	$a2, 124	#setting the instrument
	li	$a3, 75		#setting the volume
	syscall
	jr	$ra		#returning back to parent function
sValid:
	li	$v0, 31		#loading the MIDI sound
	li	$a0, 105	#setting the pitch
	li	$a1, 75		#setting the duration in ms
	li	$a2, 35		#setting the instrument
	li	$a3, 75		#setting the volume
	syscall
	jr	$ra		#returning back to parent function
initialTime:
	li	$v0, 30		#calling the system time
	syscall
	add	$s1, $a0, $zero	#saving start time into $s1	
	syscall			#printing initialTime prompt
	jr	$ra		#jumping back to parent function
afterTime:
	li	$v0, 30		#getting current time of key press
	syscall
	add	$s2, $a0, $zero	#saving current time of key press
	syscall
	sub	$s2, $s2, $s1	#since the time is a negative number, using subtract to calculate difference
	div	$s2, $s2, 1000	#dividing the difference by 1000 to put into seconds
	jr	$ra		#returning back to parent function with a value in seconds


