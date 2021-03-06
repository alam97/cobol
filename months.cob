        IDENTIFICATION DIVISION.                                      
        PROGRAM-ID.    TABL.                                          
        ENVIRONMENT DIVISION.                                         
        INPUT-OUTPUT SECTION.                                         
        FILE-CONTROL.                                                 
            SELECT REC-IN ASSIGN TO RECIN                             
            ORGANIZATION IS SEQUENTIAL.                               
        DATA DIVISION.                                                
        FILE SECTION.                                                 
         FD  REC-IN     RECORDING MODE F.                             
         01  REC-IN-MSG         PIC X(80).                            
        WORKING-STORAGE SECTION.                                      
         01 FLAGS.                                                    
             05 LASTREC PIC X VALUE SPACE.                            
                88 LAST-REC  VALUE "N".                               
         01 MonthTab.                                                 
              02 Month OCCURS 12 TIMES INDEXED BY I.                  
                 03 MonthName PIC X(3).                               
         01 StudTab.                                                  
              02 Stud OCCURS 12 TIMES INDEXED BY J.                   
                 03 StudNum PIC 99.                                   
         01 Indx    PIC 99 VALUE 1.                                   
         01 TempSt  PIC 99.                                           
                                                                      
        PROCEDURE DIVISION.                                           
            MOVE 'JANFEBMARAPRMAYJUNJULAUGSEPOCTNOVDEC' TO MonthTab.  
            MOVE '0000000000000000000000000000' TO StudTab.           
                                                                      
         OPEN-FILES.                                                  
            OPEN INPUT REC-IN.                                        
         READ-NEXT-RECORD.                                            
            PERFORM UNTIL LAST-REC                                    
            PERFORM READ-RECORD                                       
            PERFORM STOP-AT-LAST-RECORD                               
            PERFORM OUTER-COUNT                                       
            END-PERFORM.                                              
                                                                       
         READ-RECORD.                                                  
            READ REC-IN                                                
            AT END SET LAST-REC TO TRUE                                
            END-READ.                                                  
                                                                       
         OUTER-COUNT.                                                  
            PERFORM CHECK-NUM VARYING Indx FROM 1 BY 1 UNTIL Indx > 12.
                                                                       
         CHECK-NUM.                                                    
            IF REC-IN-MSG(33:2) = Indx THEN                            
            MOVE Stud(Indx) TO TempSt                                  
            COMPUTE TempSt = TempSt + 1                                
            MOVE TempSt to Stud(Indx)                                  
            END-IF.                                                    
                                                                       
         STOP-AT-LAST-RECORD.                                          
            IF LAST-REC THEN                                           
            CLOSE REC-IN                                               
            MOVE 1 TO Indx                                             
            DISPLAY "Months   Number of Students"                      
            MOVE 1 TO Indx                                             
            PERFORM 12 TIMES                                           
            DISPLAY Month(Indx) "               " Stud(Indx)           
            COMPUTE Indx = Indx + 1                                    
            END-PERFORM                                                
            STOP RUN                                                   
