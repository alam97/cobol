      *-----------------------                            
        IDENTIFICATION DIVISION.                           
      *-----------------------                            
        PROGRAM-ID.    COB.                                
      *--------------------                               
        ENVIRONMENT DIVISION.                              
      *-------------                                      
        DATA DIVISION.                                     
        WORKING-STORAGE SECTION.                           
        01 Fname PIC X(20).                                
        01 Cntdwn PIC 99.                                  
      *--------------                                     
        PROCEDURE DIVISION.                                
        DISPLAY "Enter your name: " Fname.                 
        ACCEPT Fname                                       
        DISPLAY "Enter the number: " Cntdwn.               
        ACCEPT Cntdwn                                      
        PERFORM SUBT WITH TEST BEFORE UNTIL Cntdwn = 0.    
        DISPLAY "Your name is: " Fname.                    
        STOP RUN.                                          
                                                           
        SUBT.                                              
        COMPUTE Cntdwn = Cntdwn - 1.                                                                         
        DISPLAY Cntdwn.                                    
                                                           