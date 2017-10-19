000100171009     FTAXDSP    CF   E             WORKSTN                                      
000101171009      /FREE                                                                     
000102171009       EXFMT GETVALUE;                                                          
000103171009       DOW NOT(*IN03);                                                          
000104171009         EXSR DETERMINETAX;                                                     
000105171009         //*IN99 = *ON;                                                         
000106171009         WRITE GETVALUE;                                                        
000107171009         EXFMT SHOWTAX;                                                         
000108171009         //*IN99 = *OFF;                                                        
000109171009         IF *IN03 = *OFF;                                                       
000110171009           EXSR CLEAR;                                                          
000111171009           EXFMT GETVALUE;                                                      
000112171009         ENDIF;                                                                 
000113171009       ENDDO;                                                                   
000114171009       *INLR = *ON;                                                             
000115171009       RETURN;                                                                  
000116171009                                                                                
000117171009       BEGSR DETERMINETAX;                                                      
000119171009         SELECT;                                                                
000120171009           WHEN (OWNERTYPE = 'C');                                              
000121171009             PROPTYPE = 'Commercial';                                           
000122171009             SELECT;                                                            
000123171009  		      WHEN (VALUE >= 500000);                                               
000124171009		        TAXAMT = .025 * VALUE + 150;                                          
000125171009  		      WHEN (VALUE >= 375000);                                               
000126171009		        TAXAMT = .02 * VALUE + 90;                                            
000141171009  		      WHEN (VALUE >= 250000);                                               
000142171009		        TAXAMT = .016 * VALUE + 75;                                           
000143171009  		      WHEN (VALUE >= 1);                                                    
000144171009		        TAXAMT = .0125 * VALUE;                                               
000145171009               OTHER;                                                           
000146171009                 TAXAMT = 0;                                                    
000147171009 		    ENDSL;                                                                   
000148171009           WHEN (OWNERTYPE = 'R');                                              
000150171009             PROPTYPE = 'Residential';                                          
000151171009             SELECT;                                                            
000152171009  		      WHEN (VALUE >= 500000);                                               
000153171009		        TAXAMT = .02 * VALUE + 100;                                           
000154171009  		      WHEN (VALUE >= 375000);                                               
000155171009		        TAXAMT = .015 * VALUE + 70;                                           
000156171009  		      WHEN (VALUE >= 250000);                                               
000157171009		        TAXAMT = .014 * VALUE + 50;                                           
000158171009  		      WHEN (VALUE >= 1);                                                    
000159171009		        TAXAMT = .01 * VALUE;                                                 
000160171009               OTHER;                                                           
000161171009                 TAXAMT = 0;                                                    
000162171009 		    ENDSL;                                                                   
000163171009         ENDSL;                                                                 
000164171009       ENDSR;                                                                   
000165171009                                                                                
000166171009       // initialize                                                            
000167171009       BEGSR CLEAR;                                                             
000168171009         VALUE = 0;                                                             
000169171009         OWNERTYPE = ' ';                                                       
000170171009         TAXAMT = 0;                                                            
000173171009       ENDSR;                                                                   
