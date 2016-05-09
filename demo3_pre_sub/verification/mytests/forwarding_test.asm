// Write your assembly program for Problem 1 (a) here.
lbi r1, 1 //load 1 into reg 1
lbi r2, 2 //load 2 into reg 2
add r3, r1, r2 //add r1 and r2, save result into r3
add r4, r3, r1 //add r3 and r1, save result into r4
add r5, r3, r1 //add r3 and r1, save result into r5
halt
