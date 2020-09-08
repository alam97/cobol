        IDENTIFICATION DIVISION.                    
        PROGRAM-ID.    FILER.                       
        ENVIRONMENT DIVISION.                       
        INPUT-OUTPUT SECTION.                       
        FILE-CONTROL.                               
            SELECT REC-IN ASSIGN TO RECIN           
            ORGANIZATION IS SEQUENTIAL.             
        DATA DIVISION.                              
        FILE SECTION.                               
         FD  REC-IN     RECORDING MODE F.           
         01  REC-IN-MSG         PIC X(24).          
        WORKING-STORAGE SECTION.                    
         01 FLAGS.                                  
             05 LASTREC PIC X VALUE SPACE.          
                88 LAST-REC  VALUE "N".             
         01 Cnt  PIC 99.                            
                                                    
        PROCEDURE DIVISION.                         
         OPEN-FILES.                                
            OPEN INPUT REC-IN.                      
         READ-NEXT-RECORD.                          
            PERFORM UNTIL LAST-REC                  
            PERFORM READ-RECORD                     
            PERFORM STOP-AT-LAST-RECORD             
            END-PERFORM.                            
                                                    
         READ-RECORD.                               
            READ REC-IN                             
            AT END SET LAST-REC TO TRUE             
            END-READ.                               
                                                    
         STOP-AT-LAST-RECORD.                       
            COMPUTE Cnt = Cnt + 1                   
            IF LAST-REC THEN                        
            CLOSE REC-IN                            
            COMPUTE Cnt = Cnt - 1                   
            DISPLAY "THERE ARE " Cnt " LINES IN THE FILE"    
            STOP RUN.                                        