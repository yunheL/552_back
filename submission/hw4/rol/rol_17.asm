//shift left -1 bit which is the same as shift right 1 bit
//this set of test every of the 16bit and further than 16bit
lbi r1, 001
lbi r2, -001
rol r3, r1, r2
halt
