000100171026     FMARKSDSP7 CF   E             WORKSTN                                                          
000101171026     D MINNUM          S             10I 0                                                          
000102171026                                                                                                    
000103171026      /FREE                                                                                         
000104170920       EXFMT RECORD1;                                                                               
000105170920       DOW NOT(*IN03);                                                                              
000106170927         EXSR GETGRADE; // call subroutine to get letter grade                                      
000107170927          WRITE RECORD1;                                                                            
000108170920         EXFMT RECORD2;                                                                             
000109170920         IF *IN03 = *OFF;                                                                           
000110170927           EXSR CLEARMARKS; // call subroutine to clear test score                                  
000111170927           EXFMT RECORD1;                                                                           
000112170920         ENDIF;                                                                                     
000113170920       ENDDO;                                                                                       
000114171026       AVG = AVG / QUERY;                                                                           
000115171026       EXFMT RECORD3;                                                                               
000116170920       *INLR = *ON;                                                                                 
000117170920       RETURN;                                                                                      
000118170920                                                                                                    
000119170927       // set the Letter Grade                                                                      
000120170920       BEGSR GETGRADE;                                                                              
000121171026         // find minimum test score and display msg                                                 
000122171026         // 'This Test Mark Dropped' beside the field                                               
000123171026         IF TEST1  <= TEST2 AND TEST1 <= TEST3;                                                     
000124171026           MINNUM = TEST1;                                                                          
000125171026           *IN30 = *ON;                                                                             
000126171026         ELSEIF TEST2  <= TEST1 AND TEST2 <= TEST3;                                                 
000127171026           MINNUM = TEST2;                                                                          
000128171026           *IN31 = *ON;                                                                             
000129171026         ELSE;                                                                                      
000130171026           MINNUM = TEST3;                                                                          
000131171026           *IN32 = *ON;                                                                             
000132171026         ENDIF;                                                                                     
000133171026                                                                                                    
000142171026         TESTOVRALL = (TEST1 + TEST2 + TEST3 - MINNUM) / 2; // set to 'Tests' on screen             
000143171026         NUMGRADE = LAB + (TESTOVRALL * 0.35) + (EXAM * 0.35); // set to 'Final Mar                 
000144171026                                                                                                    
000145171026         // set to 'Final Grade' on screen                                                          
000157170920         SELECT;                                                                                    
000158170920           WHEN 90 <= NUMGRADE;                                                                     
000159170920             LETGRADE = 'A+';                                                                       
000160170920           WHEN 80 <= NUMGRADE AND NUMGRADE <= 89;                                                  
000161170920             LETGRADE = 'A';                                                                        
000162170920           WHEN 75 <= NUMGRADE AND NUMGRADE <= 79;                                                  
000163170920             LETGRADE = 'B+';                                                                       
000164170920           WHEN 70 <= NUMGRADE AND NUMGRADE <= 74;                                                  
000165170920             LETGRADE = 'B';                                                                        
000166170920           WHEN 65 <= NUMGRADE AND NUMGRADE <= 69;                                                  
000167170920             LETGRADE = 'C+';                                                                       
000168170920           WHEN 60 <= NUMGRADE AND NUMGRADE <= 64;                                                  
000169170920             LETGRADE = 'C';                                                                        
000170170920           WHEN 55 <= NUMGRADE AND NUMGRADE <= 59;                                                  
000171170920             LETGRADE = 'D+';                                                                       
000172170920           WHEN 50 <= NUMGRADE AND NUMGRADE <= 54;                                                  
000173170920             LETGRADE = 'D';                                                                        
000174170920           WHEN NUMGRADE <= 49;                                                                     
000175170920             LETGRADE = 'F+';                                                                       
000176170920           OTHER;                                                                                   
000177170920             LETGRADE = 'NO';                                                                       
000178170920         ENDSL;                                                                                     
000179171026                                                                                                    
000180171026         // When the numeric grade is above 50 and the exam are                                     
000181171026         // failed show a message "Automatic F with Test Average below 50"                          
000182171026         IF NUMGRADE > 50 AND EXAM < 50;                                                            
000183171026           *IN33 = *ON;                                                                             
000184171026           FAIL = FAIL + 1; // increase the number of fail by  1                                    
000185171026         // When the numeric grade is above 50 and the tests are                                    
000186171026         // failed show a message "Automatic F with Test Average below 50"                          
000187171026         ELSEIF NUMGRADE > 50 AND TESTOVRALL < 50;                                                  
000188171026           *IN34 = *ON;                                                                             
000189171026           FAIL = FAIL + 1; // increase the number of fail by  1                                    
000190171026         ELSEIF LETGRADE = 'F+';                                                                    
000191171026           FAIL = FAIL + 1; // increase the number of fail by  1                                    
000192171026         ELSE;                                                                                      
000193171026           PASS = PASS + 1; // increase the number of pass by  1                                    
000194171026         ENDIF;                                                                                     
000195171026                                                                                                    
000196171026         QUERY = QUERY + 1; // increase the number of query by  1                                   
000197171026         AVG = AVG + NUMGRADE; // sum the final grade                                               
000198171026       ENDSR;                                                                                       
000200170920                                                                                                    
000201170927       // reset the marks back to 0                                                                 
000202170920       BEGSR CLEARMARKS;                                                                            
000203170927         TEST1 = 0;                                                                                 
000204170927         TEST2 = 0;                                                                                 
000205170927         TEST3 = 0;                                                                                 
000206170927         LAB = 0;                                                                                   
000207170927         EXAM = 0;                                                                                  
000208171026         *IN30 = *OFF;                                                                              
000209171026         *IN31 = *OFF;                                                                              
000210171026         *IN32 = *OFF;                                                                              
000211171026         *IN33 = *OFF;                                                                              
000212171026         *IN34 = *OFF;                                                                              
000213171026       ENDSR;                                                                                       
