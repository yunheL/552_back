//shift left 16 bit which will shift back to orginal position
//this set of test every of the 16bit and further than 16bit
lbi r1, 001
lbi r2, 016
rol r3, r1, r2
halt
