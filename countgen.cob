        IDENTIFICATION DIVISION.                    
        PROGRAM-ID.    CNTGEN.                       
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
         01 Fem  PIC 99. 
         01 Male PIC 99.

                                                    
        PROCEDURE DIVISION.                         
         OPEN-FILES.                                
            OPEN INPUT REC-IN.                      
         READ-NEXT-RECORD.                          
            PERFORM UNTIL LAST-REC                  
            PERFORM READ-RECORD                     
            PERFORM STOP-AT-LAST-RECORD  
            PERFORM COUNT-PERSON           
            END-PERFORM.                            
                                                    
         READ-RECORD.                               
            READ REC-IN                             
            AT END SET LAST-REC TO TRUE             
            END-READ.    

         COUNT-PERSON.
            IF REC-IN-MSG(22:1) = 'M' THEN
            COMPUTE Male = Male + 1
            ELSE
            COMPUTE Fem = Fem + 1
            END-IF.                               
                                                    
         STOP-AT-LAST-RECORD.                                       
            IF LAST-REC THEN                        
            CLOSE REC-IN                            
            DISPLAY "THERE ARE " Fem " FEMALES AND " Male " MALES."    
            STOP RUN.                                        