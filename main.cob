001360*>
001370 IDENTIFICATION DIVISION.
001380 PROGRAM-ID.   DEMO.
001390 ENVIRONMENT    DIVISION.
001400 CONFIGURATION  SECTION.
001410 INPUT-OUTPUT SECTION.
001420 FILE-CONTROL.
001430 		SELECT PRODUCT ASSIGN TO FILE01 
001431 			ORGANIZATION LINE SEQUENTIAL.
001432 		
001433 		SELECT SORTED-PRODUCT-FILE ASSIGN TO FILE02
001435			ORGANIZATION IS LINE SEQUENTIAL.
001436			
001437		SELECT WORK ASSIGN TO WORK01.
001438		
001439		SELECT FILE-OUT ASSIGN TO FILE03
001440			ORGANIZATION LINE SEQUENTIAL.
001441		
001442 DATA DIVISION.
001450 FILE SECTION.
001460 FD PRODUCT.
001470 01 PRODUCT-DETAILS.
001480 	02 PRODUCT-ID-I					PIC X(4).
001490 	02 PRODUCT-NAME-I				PIC X(20).
001500 	02 PRICE-I						PIC 9(4).
001510 	02 QUANTITY-I					PIC 9(3).
001511 		
001520 FD SORTED-PRODUCT-FILE.
001521 01 PRODUCT-DETAILS.
001523 	02 PRODUCT-ID					PIC X(4).
001524 	02 PRODUCT-NAME					PIC X(20).
001525 	02 PRICE						PIC 9(4).
001526 	02 QUANTITY						PIC 9(3).
001527 		
001528 SD WORK.
001529 01 WORK-PRODUCT.
001530  02 PRODUCT-ID-WF				PIC X(4).
001531 	02 PRODUCT-NAME-WF				PIC X(20).
001532 	02 PRODUCT-PRICE-WF		    	PIC 9(4).
001533 	02 PRODUCT-QUANTITY-WF			PIC 9(3).
001534 
001535 FD FILE-OUT.
001536 01 LINE-RECORD					PIC X(100).
001537 
001540 WORKING-STORAGE SECTION.
001550 01 REPORT-HEADING.
001551 	02 FILLER PIC X(88)
001552 		VALUE "        ****** REPORT FOR THE SHOP ******       ".
001553 		
001554 01 REPORT-COLUMN.
001555 	02 COL-PRODUCT-ID		PIC X(10) VALUE "PRODUCT-ID".
001556 	02 FILLER				PIC XX VALUE SPACES.
001557 	02 COL-PRODUCT-NAME		PIC X(20) VALUE "PRODUCT-NAME".
001558 	02 FILLER				PIC XX VALUE SPACES.
001559 	02 COL-PRODUCT-PRICE 	PIC X(5)  VALUE "PRICE".
001560 	02 FILLER				PIC XX VALUE SPACES.
001561 	02 COL-PRODUCT-QUANTITY	PIC X(8)  VALUE "QUANTITY".
001562 	02 FILLER				PIC X(6) VALUES SPACES.
001563 	02 COL-PRODUCT-VALUE	PIC X(49) VALUE "TOTAL".
001564 	
001565 01 REPORT-FOOTING PIC X(88) 
001566 		VALUE "        ******    END OF REPORT    ******        ".
001568  		
001569 01 PRINT-PRODUCT-VALUE.
001570 	02 PR-PRODUCT-ID		PIC X(4).
001571 	02 FILLER				PIC X(8) VALUE SPACES.
001572 	02 PR-PRODUCT-NAME		PIC X(20).
001573 	02 FILLER				PIC XX VALUE SPACES.
001574 	02 PR-PRODUCT-PRICE 	PIC z,zz9 BLANK WHEN ZERO.
001575 	02 FILLER				PIC X(3) VALUE SPACES.
001576 	02 PR-PRODUCT-QUANTITY	PIC zz9 BLANK WHEN ZERO.
001577 	02 FILLER				PIC X(7) VALUES SPACES.
001578 	02 PR-PRODUCT-VALUE		PIC z,zzz,zz9 BLANK WHEN ZERO.
001579 		
001580 01 ERROR-MESSAGE.
001581 	02 READ-ERROR PIC X(46).			
001582 	  88 MESSAGE-ERROR VALUE "READ ERROR - CAN'T READ A FILE DATA".
001583 	02 NOT-VALID-NUMBER.	    
001584 	  05 RECORD-NUMBER 		PIC 99.
001585 	  05 FILLER				PIC XX VALUE SPACES.
001586 	  05 COLUMN-NAME 		PIC X(20) VALUE SPACES.	
001587 	  05 MESSAGE-NOTVALID 	PIC X(100)
001588 		VALUE "NOT-VALID-NUMBER - THIS DATA IS NOT A VALID NUMBER".
001589 		
001590 01 PR-ERROR.
001591 	02 PR-PRODUCT-ID-ERROR		PIC X(4).
001592 	02 FILLER					PIC X(8) VALUE SPACES.
001593 	02 PR-PRODUCT-NAME-ERROR	PIC X(20).
001594 	02 FILLER					PIC XX VALUE SPACES.
001595 	02 PR-PRICE-ERROR			PIC	X(6) VALUE "----".
001596 	02 FILLER					PIC X(3) VALUE SPACES.
001597 	02 PR-QUANTITY-ERROR		PIC X(4) VALUE "---".
001598 	02 FILLER					PIC X(7) VALUES SPACES.
001599 	02 PR-VALUE-ERROR			PIC X(7) VALUE "-------".
001600 
001601 01 PRINT-SHOP-PRICE-TOTAL.
001602 	02 FILLER			PIC X(43) 	VALUE SPACES.
001603 	02 FILLER			PIC X(8) 	VALUE "TOTAL: ".
001604 	02 PRINT-TOTAL		PIC zz,zzz,zz9 BLANK WHEN ZERO.
001605 
001606 01 PRINT-GROUP-LINE.
001607 	02 FILLER			PIC X(34)	VALUE SPACES.
001608 	02 FILLER			PIC X(6) 	VALUE "GROUP ".
001609 	02 PR-GROUP-ID		PIC X.
001610 	02 FILLER			PIC X(9) 	VALUE " TOTAL : ".
001611 	02 PR-GROUP-TOTAL	PIC zzz,zzz,zz9 BLANK WHEN ZERO.
001612 
001613 01 PRINT-INFO-ERROR.
001614 	02 FILLER			PIC X(22)	 VALUE "TOTAL RECORDS ERROR : ".
001615 	02 PR-COUNT-RECORD-ERROR  PIC zz,zz9 BLANK WHEN ZERO.
001616 	
001617 01 PRINT-INFO-RECORD.
001618 	02 FILLER				PIC X(16)	VALUE "TOTAL RECORDS : ".
001619 	02 PR-COUNTER 			PIC zz,zz9 BLANK WHEN ZEROS.
001620 
001621 01 GROUP-PRODUCT.
001622 	02 GROUP-ID			PIC 9.
001623 	02 PREV-GROUP-ID	PIC 9		VALUE ZERO.
001624 	02 GROUP-TOTAL		PIC 9(9)	VALUE ZEROS.
001625 		
001626 01 EOF-FILE				PIC X 		VALUE "N".
001627 01 PRICE-TOTAL			PIC 9(8) 	VALUE ZERO.
001628 01 CHECK-PRICE			PIC 9 		VALUE 0.
001636 01 CHECK-QUANTITY		PIC 9 		VALUE 0.
001680 01 DELAY					PIC 9 		VALUE 0.
001720 01 CHECK-ERROR			PIC 9 		VALUE ZERO.
001721 01 PRODUCT-VALUE			PIC 9(8) 	VALUE ZERO.
001730 01 COUNT-RECORD-ERROR	PIC 9(8) 	VALUE 0.
001740 01 COUNTER 				PIC 9(8) 	VALUE 0.
001750 
001790 PROCEDURE DIVISION.
001800 MAIN.
001801 		SORT WORK ON ASCENDING KEY PRODUCT-ID-WF
001802   	USING PRODUCT GIVING SORTED-PRODUCT-FILE
001803   	
001804   	OPEN OUTPUT FILE-OUT
001805   	
001810 		DISPLAY REPORT-HEADING
001811 		DISPLAY REPORT-COLUMN
001812 		
001813 		MOVE REPORT-HEADING TO LINE-RECORD
001814 		WRITE LINE-RECORD
001815 		MOVE REPORT-COLUMN 	TO LINE-RECORD
001816 		WRITE LINE-RECORD
001817 		
001820 		PERFORM READ-FILE
001830 		PERFORM MAIN-PROCESS UNTIL EOF-FILE = "Y"
001831 		PERFORM PRINT-SHOP-TOTAL
001832 		
001842 		MOVE COUNT-RECORD-ERROR TO PR-COUNT-RECORD-ERROR
001843 		MOVE COUNTER TO PR-COUNTER
001850 		DISPLAY PRINT-INFO-ERROR
001851 		DISPLAY PRINT-INFO-RECORD
001852 		
001855 		MOVE PRINT-INFO-ERROR TO LINE-RECORD
001856 		WRITE LINE-RECORD
001857 		
001860 		MOVE PRINT-INFO-RECORD TO LINE-RECORD
001861 		WRITE LINE-RECORD
001862 		
001863 		DISPLAY REPORT-FOOTING
001864 		MOVE REPORT-FOOTING TO LINE-RECORD
001865 		WRITE LINE-RECORD
001866 		
001867 		CLOSE SORTED-PRODUCT-FILE
001868 		CLOSE FILE-OUT
001870 		ACCEPT DELAY
001880 		STOP RUN.
001881 		
001890 READ-FILE.
001900 		OPEN INPUT SORTED-PRODUCT-FILE
001910 		READ SORTED-PRODUCT-FILE
001920 			AT END
001930 				MOVE "Y" TO EOF-FILE
001940 			NOT AT END
001950 				COMPUTE COUNTER = COUNTER + 1
001960 		END-READ.
001961 		
001970 MAIN-PROCESS.
001980 	   COMPUTE GROUP-ID = FUNCTION  NUMVAL(PRODUCT-ID(1:1))
001990 		
002000 	   IF PREV-GROUP-ID = ZERO
002010 	   		COMPUTE PREV-GROUP-ID = FUNCTION NUMVAL(PRODUCT-ID(1:1))
002020 	   END-IF
002030 		
002040 	   PERFORM UNTIL PREV-GROUP-ID NOT = GROUP-ID OR EOF-FILE = "Y"
002050 			COMPUTE PREV-GROUP-ID = FUNCTION NUMVAL(PRODUCT-ID(1:1))
002060	 		IF PREV-GROUP-ID NOT = GROUP-ID
002070	 			THEN EXIT PERFORM
002080	 		ELSE
002090	 			IF QUANTITY IS NOT NUMERIC 
002100	 				MOVE 0 TO QUANTITY
002110	 				MOVE 1 TO CHECK-ERROR
002120	 				MOVE 1 TO CHECK-QUANTITY
002130	 			END-IF
002140	 			IF PRICE IS NOT NUMERIC
002150	 				MOVE 0 TO PRICE
002160	 				MOVE 1 TO CHECK-ERROR
002170	 				MOVE 1 TO CHECK-PRICE
002180	 			END-IF
002190	 			
002200	 			IF CHECK-QUANTITY = 1 OR CHECK-PRICE = 1
002210	 				MOVE 0 TO CHECK-QUANTITY
002220	 				MOVE 0 TO CHECK-PRICE
002230	 				ADD  1 TO COUNT-RECORD-ERROR	
002240	 			END-IF
002250	 			
002260	 			IF CHECK-ERROR = 1
002270	 				MOVE PRODUCT-ID 		TO PR-PRODUCT-ID-ERROR
002271				 	MOVE PRODUCT-NAME		TO PR-PRODUCT-NAME-ERROR
002280					PERFORM PRINT-ERROR
002340	 				MOVE 0 TO CHECK-ERROR 
002350	 			ELSE
002360		 			COMPUTE PRODUCT-VALUE = QUANTITY * PRICE
002370		 			ADD PRODUCT-VALUE TO GROUP-TOTAL 
002381		 			
002390		 			MOVE PRODUCT-ID 		TO PR-PRODUCT-ID
002391				 	MOVE PRODUCT-NAME		TO PR-PRODUCT-NAME
002392				 	MOVE PRICE				TO PR-PRODUCT-PRICE
002393				 	MOVE QUANTITY			TO PR-PRODUCT-QUANTITY
002394				 	MOVE PRODUCT-VALUE		TO PR-PRODUCT-VALUE
002400		 			PERFORM TERM-PROC
002460		 		END-IF
002470	 		END-IF
002480	 	END-PERFORM
002490 		
002491 		PERFORM PRINT-GROUP-TOTAL
002492 		ADD GROUP-TOTAL TO PRICE-TOTAL
002500 		MOVE 0 TO GROUP-TOTAL.
002510 	
002612 TERM-PROC.
002613 		MOVE PRINT-PRODUCT-VALUE TO LINE-RECORD
002615 		DISPLAY PRINT-PRODUCT-VALUE
002616 		WRITE LINE-RECORD
002617 		READ SORTED-PRODUCT-FILE
002618		 	AT END
002619		 		MOVE "Y" TO EOF-FILE
002620		 	NOT AT END
002621		 		COMPUTE COUNTER = COUNTER + 1
002622		END-READ.
002623 PRINT-ERROR.
002624 		MOVE PR-ERROR TO LINE-RECORD
002625 		DISPLAY PR-ERROR
002626 		WRITE LINE-RECORD
002627 		READ SORTED-PRODUCT-FILE
002628		 	AT END
002629		 		MOVE "Y" TO EOF-FILE
002630		 	NOT AT END
002631		 		COMPUTE COUNTER = COUNTER + 1
002632		END-READ.
002633		
002634 PRINT-GROUP-TOTAL.
002635 		MOVE GROUP-ID 			TO PR-GROUP-ID
002636		MOVE GROUP-TOTAL		TO PR-GROUP-TOTAL
002637		MOVE PRINT-GROUP-LINE 	TO LINE-RECORD 
002638		DISPLAY PRINT-GROUP-LINE
002639		WRITE LINE-RECORD.
002640
002641 PRINT-SHOP-TOTAL.
002642 		MOVE PRICE-TOTAL TO PRINT-TOTAL
002643 		MOVE PRINT-SHOP-PRICE-TOTAL TO LINE-RECORD
002644 		DISPLAY PRINT-SHOP-PRICE-TOTAL
002645 		WRITE LINE-RECORD.
002646		
002647 END PROGRAM DEMO.
002650