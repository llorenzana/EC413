############################################################################
# 
#                       EC413
#
#    		Assembly Language Lab -- Programming with Loops.
#
############################################################################
#  DATA
############################################################################
        .data           # Data segment
Hello:  .asciiz " \n Hello Leanorine! \n"  # declare a zero terminated string
AnInt:	.word	17      # a word initialized to 17
space:	.asciiz	" "	    # declare a zero terminate string
AnotherInt: .word 23	# another word, this time initialized to 23
WordAvg:   .word 0		#use this variable for part 4
ValidInt:  .word 0		#
ValidInt2: .word 0		#
lf:     .byte	10, 0	# string with carriage return and line feed
InLenW:	.word   4       # initialize to number of words in input1 and input2
InLenB:	.word   16      # initialize to number of bytes in input1 and input2
        .align  4       # pad to next 16 byte boundary (address % 16 == 0)
Input1_TAG: .ascii "Input1 starts on next line"
		.align	4
Input1:	.word	0x01020304,0x05060708
	    .word	0x090A0B0C,0x0D0E0F10
        .align  4
Input2_TAG: .ascii "Input2 starts on next line"
        .align  4
Input2: .word   0x01221117,0x090b1d1f   # input
        .word   0x0e1c2a08,0x06040210
        .align  4
Copy_TAG: .ascii "Copy starts on next line"
        .align  4
Copy:  	.space  128		# space to copy input word by word
        .align  4
Input3_TAG: .ascii "Input3 starts on next line"
        .align  4
Input3:	.space	400		# space for data to be transposed
Transpose_TAG: .ascii "Transpose starts on next line"
        .align  4
Transpose: .space 400	# space for transposed data
 
############################################################################
#  CODE
############################################################################
        .text                   # code segment
#
# print out greeting.  
# Task 2:  change the message so that it prints out your name.
main:
        la	$a0,Hello		# address of string to print
        li	$v0,4			# system call code for print_str
        syscall				# print the string
#

# Print the integer value of AnInt
# Task 3: modify the code so that it prints out two integers
# separated by a space.
        lw	$a0,AnInt  # load I/O register with value of AnInt
        li	$v0,1	   # system call code for print_int
        syscall		   # print the integer

        la $a0,space       # load I/0 register with value of space
        li $v0,4           # system call code for print_str
        syscall            # print the string

        lw $a0,AnotherInt  # load I/0 register with value of AnotherInt
        li $v0,1           # system call code for print_int
        syscall            # print the integer 

        la $a0, lf         # print a new line
        li $v0,4           # system call for print_str
        syscall            # print the string
#
# Print the integer values of each byte in the array Input1
# Task 4a: modify the code so that it prints spaces between the integers
        la $s0,Input1		# load pointer to array Input1
        lw $s1,InLenB		# get length of array Input1 in bytes
task4:	
        ble $s1,$zero,done4	# test if done
        lb $a0,($s0)		# load next byte into I/O register
        li $v0,1		# specify print integer
        syscall			# print the integer

        la $a0,space            # load I/0 register with value of space
        li $v0,4                # system call code for print_str
        syscall                 # print the string

        add $s0,$s0,1	        # point to next byte
        sub $s1,$s1,1	        # decrement index variable
        j task4		        # do it again
done4:
        la $a0, lf              # print a new lime
        li $v0,4                # system call for print_str
        syscall                 # print the string
#
# Task 4b: copy the Task 4 code and paste here.  Modify the code to print
# the array backwards.
        la $s0,Input1
        lw $s1,InLenB
        sub $s1,$s1,1
        add $s2,$s0,$s1
task4b:
        blt $s1,$zero,done4b	# test if done
        lb $a0,($s2)		# load next byte into I/O register
        li $v0,1			# specify print integer
        syscall				# print the integer

        sub $s1,$s1,1
        add $s2,$s0,$s1
        la $a0,space       # load I/0 register with value of space
        li $v0,4           # system call code for print_str
        syscall            # print the string

        j task4b			# do it again

done4b:
        la $a0,lf         # print a new lime
        li $v0,4           # system call for print_str
        syscall            # print the string

#
# Code for Task 5 -- copy the contents of Input2 to Copy
        la $s0,Input2		# load pointer to array Input1
        la $s1,Copy		# load pointer to array Copy
        lw $s2,InLenB		# get length of array Input1 in bytes

task5:
        blt $s2,$zero,done5	# test if done
        lb $t0,($s0)		# get the next byte
        sb $t0,($s1)		# put the byte
        add $s0,$s0,1		# increment input pointer
        add $s1,$s1,1		# increment output point
        sub $s2,$s2,1		# decrement index variable
        j task5			# continue
done5:
        la $a0,lf         # print a new line
        li $v0,4           # system call for print_str
        syscall            # print the string

#
# Task 5:  copy the Task 5 code and paste here.  Modify the code to copy
# the data in words rather than bytes.

        la $s0,Input2		# load pointer to array Input1
        la $s1,Copy		# load pointer to array Copy
        lw $s2,InLenB		# get length of array Input1 in bytes

task5b:
        blt $s2,$zero,done5b	# test if done
        lw $t0,($s0)		# get the next byte
        sw $t0,($s1)		# put the byte
        add $s0,$s0,4		# increment input pointer changed 1 to 4
        add $s1,$s1,4		# increment output point changed 1 to 4
        sub $s2,$s2,1		# decrement index variable
        j task5b			# continue

done5b:
        la $a0,lf         # print a new lime
        li $v0,4           # system call for print_str
        syscall            # print the string
#
# Code for Task 6 -- 
# Print the integer average of the contents of array Input2 (bytes)
        la $s0,Input2		# load pointer to array Input2
        lw $s1,InLenB		# get length of array Input2 in bytes
	lw $s2,InLenB		# get length of array Input2 to use as a counter for the for Loops
        lw $s3,WordAvg           # get average of words var

task6:
        ble $s2,$zero,done6	# test if done
        lb $t0,($s0)		# get the next byte
        add $s3,$s3,$t0		# each loop you add the elements of Input2 and store in AVGword
        add $s0,$s0,1		# increment output point 
        sub $s2,$s2,1		# decrement index variable
        j task6			# continue
done6:
        div $s3,$s1         # get the average word by dividing the totalsum stored in $s3 by the number of elements in Input2
        mflo $t0            # use this command after a division, will store result of avg in $t0
        la $a0,($t0)        # load avg val into $a0
        li $v0,1           # system call for print_int
        syscall

        la $a0,lf         # print a new lime
        li $v0,4           # system call for print_str
        syscall            # print the string
#
# Code for Task 7 --  
# Print the first 25 integers that are divisible by 7 (with spaces)
        li $s0,0		# load initial int value to test
        li $s1,7		# divisor into $s1
task7:
        beq $s0,25,done7	# test if done
        div $s0,$s1        # divide s0 by 7
        mfhi $t0           # store the remainder
        bne $t0,$zero,ddiv # if $t0 != 0 then target
        la $a0,($s0)        # load the answer from division
        li $v0,1           # system call for print_int
        syscall

        la $a0,space       # load I/0 register with value of space
        li $v0,4           # system call code for print_str
        syscall            # print the string    
 
ddiv: 
        add $s0,$s0,1      # increment $s0 by 1
        j task7

done7:
        la $a0,lf         # print a new lime
        li $v0,4           # system call for print_str
        syscall            # print the string



#
# The following code initializes Input3 for Task9
		la $s0,Input3		# load pointer to Input3
		li $s1,100			# load size of array in bytes
		li $t0,3			# start with 3
init8a:
		ble $s1,$zero,done8a	# test if done
		sb  $t0,($s0)		# write out another byte
		add $s0,$s0,1		# point to next byte
		sub $s1,$s1,1		# decrement index variable
		add $t0,$t0,1		# increase value by 1
		j init8a			# continue
done8a:
        la $a0,lf         # print a new lime
        li $v0,4           # system call for print_str
        syscall            # print the string
#
# Code for Task 9 --
# Transpose the 10x10 byte array in Input3 into Transpose
                la $s0,Input3	    # load pointer to Input3
                la $s1,Transpose    # points to transpose
                li $s2,0            # counts the index of loop
                li $s3,10           # inside loop index for transpose
                li $t0,3			# start with 3


checkloop: 
        beq $s2,10,done9   # check loop is done

insideloop: 
        ble $s3,$zero,endloop # check its done and move
        
        la $s1,10($s0)     # load pointer to transpose into t0
        la $t0,($s1)       # stores t0 into Transpose
        
        sub $s3,$s3,1      # decrement inside loop counter 
        add $s0,$s0,10     # increment input3 by 10 for next val
        add $s1,$s1,1      # increment Tranpose by 10 

        j insideloop       # rerun insideloop

endloop: 
        add $s2,$s2,1     # increment loop counter
        li $t0,3          # reinitialize t0 to 3
        add $t0,$t0,$s2   # get new starting value of t0
        li $s3,10         # inside loop index for transposing
	sub $s1,$s1,99    # pointer of transpose by 10
        sub $s0,$s0,99	  # move pointer of input3 by 10 		

        la $a0,lf         # print a new lime
        li $v0,4           # system call for print_str
        syscall            # print the string

        j checkloop

done9: 
        la $a0,lf          # print a new lime
        li $v0,4           # system call for print_str
        syscall            # print the string

# ALL DONE!
Exit:
jr $ra

