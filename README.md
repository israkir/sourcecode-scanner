Description
===========
sourcecode-scanner project aims to provide a lexical analyser for C-like programming language 
source code which is automatically generated by flex (fast lexical analyser generator).

---------------------------------------

Insructions
-----------

To generate the actual scanner program use flex (in linux):

    $ flex scanner.l
    
flex will output a file names 'lex.yy.c'. Still need to compile this:

    $ gcc lex.yy.l
    
Note: Keep in mind... If gcc gives a yywrap error (about linkage to libfl.a), you need to add -lfl 
parameter while compiling. Probably this will not happen, because it is already ignored to link 
that library in the source code.

To run:

    $ a.out [input-file]
    
---------------------------------------
    
The output will be the tokens with token numbers line by line. An example of running:

Input file: test.c 

    int main ( )
    {
        /* comment */
        
        /* First comment 
           first commentóline two*/
        /* Second comment */
        
        int sum ; // comment
        char w_12hat___is_me122_ = "This is a string_____";
        sum = 0 ;
        int i ;
        
        for ( i = 0 ; i < 25 ; i = i + 1 ) {
                sum = sum + i ;
        }
        
        for(i=0;i<=16;i++){ /* do
        * something 
        * here
        */
        }
        
        return 0 ;
    }
    
    
Output: stdout

    269
    258     main
    40
    41
    123
    269
    258     sum
    59
    268
    258     w_12hat___is_me122_
    61
    260     This is a string_____
    59
    258     sum
    61
    259     0x00000000
    59
    269
    258     i
    59
    274
    40
    258     i
    61
    259     0x00000000
    59
    258     i
    60
    259     0x00000019
    59
    258     i
    61
    258     i
    43
    259     0x00000001
    41
    123
    258     sum
    61
    258     sum
    43
    258     i
    59
    125
    274
    40
    258     i
    61
    259     0x00000000
    59
    258     i
    261
    259     0x00000010
    59
    258     i
    43
    43
    41
    123
    125
    277
    259     0x00000000
    59
    125