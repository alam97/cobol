      *----------------------
      * INPUT DATASET LOOKS LIKE THIS:
      * NAME(10) ID(8)
      * JOHN      12345678 
      *----------------------                     
        IDENTIFICATION DIVISION.                                 
      *----------------------                                    
        PROGRAM-ID.    EXERC.                                    
      *----------------------                                    
        ENVIRONMENT DIVISION.                                    
      *----------------------                                    
        INPUT-OUTPUT SECTION.                                    
      *----------------------                                    
        FILE-CONTROL.                                            
           SELECT REC-OUT    ASSIGN TO RECOUT.                   
           SELECT REC-IN     ASSIGN TO RECIN                     
                  ORGANIZATION IS SEQUENTIAL.                    
      *----------------------                                    
       DATA DIVISION.                                            
      *----------------------                                    
       FILE SECTION.                                             
       FD  REC-IN     RECORDING MODE F.                          
       01  REC-IN-MSG         PIC X(20).                         
      *                                                          
       FD  REC-OUT    RECORDING MODE F.                          
       01  REC-OUT-MSG        PIC X(24).                         
      *----------------------                                    
        DATA DIVISION.                                           
        WORKING-STORAGE SECTION.                                 
        01 FLAGS.                                                
         05 LASTREC           PIC X VALUE SPACE.                 
             88 LAST-REC            VALUE "N".                   
        01 ALPH PIC X(26) VALUE "ABCDEFGHIJKLMNOPQRSTUVWXYZ".    
        01 POST PIC 99 VALUE 1.                                  
        01 SRCH PIC X(1).                                        
        01 STRG PIC X(2).                                        
      *----------------------                                    
        PROCEDURE DIVISION.                                      
        OPEN-FILES.                                              
           OPEN INPUT  REC-IN.                                   
           OPEN OUTPUT REC-OUT.                                  
         READ-NEXT-RECORD.                                             
            PERFORM UNTIL LAST-REC                                     
            PERFORM READ-RECORD                                        
            PERFORM STOP-AT-LAST-RECORD                                
            PERFORM CHANGE-RECORD                                      
            PERFORM WRITE-RECORD                                       
            END-PERFORM.                                               
      *----------------------                                         
            READ-RECORD.                                               
            READ REC-IN                                                
            AT END SET LAST-REC TO TRUE                                
            END-READ.                                                  
      *----------------------                                         
            STOP-AT-LAST-RECORD.                                       
             IF LAST-REC THEN                                          
               CLOSE REC-IN                                            
               CLOSE REC-OUT                                           
               STOP RUN.                                               
      *----------------------                                         
            CHANGE-RECORD.                                             
      *------ (1:1) ONE LETTER ON THE FIRST POSITION                  
             MOVE REC-IN-MSG(1:1) TO SRCH.                             
             PERFORM TST1 WITH TEST BEFORE UNTIL SRCH = ALPH(POST:1).  
      *------ MOVE NUMERIC TO STRING TO BE ABLE TO CONCATENATE
             MOVE POST TO STRG.                                        
             STRING REC-IN-MSG DELIMITED BY SIZE                       
             SPACE                                                     
             STRG DELIMITED BY SIZE                                    
             INTO REC-OUT-MSG.                                         
             END-STRING.                                                                              
      *------ SET POSITION 1 FOR THE NEW RECORD                       
             MOVE 1 TO POST.                                           
      *----------------------                                                    
             TST1.                              
             ADD 1 TO POST.                     
      *----------------------                  
            WRITE-RECORD.                         
             WRITE REC-OUT-MSG.                        

      *----------------------
      * OUTPUT DATASET LOOKS LIKE THIS:
      * JOHN      12345678  10 
      *----------------------  