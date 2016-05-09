// Write your assembly program for Problem 2 (a) here.
lbi r1, 10 //load 10 into r1
lbi r2, 10 //load 10 into r2
beqz r2, 2 //if value in r1 is 0, then branch pc+2+2(sign ext.)
add r4, r1, r2 //add r1 and r2, save the result in r4
halt
