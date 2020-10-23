ods pdf file='/folders/myfolders/week2_hw/my_report.pdf';

proc document name=temp(write);
   import textfile="/folders/myfolders/week2_hw/LabHomework/new_hw1.sas" to ^;
   replay;
run;

proc format;
 value $cauto ''  = "Not Applicable"
 	   		  '0' = "No Autopsy"
 	   		  '1' = "Autopsy Performed"
 	   		  'N' = "No Autopsy performe"
 	   		  'U' = "Unknown"
 	   		  'Y' = "Autopsy Performed";
 value $ccvs 'A' = "Alive"
 		     'D' = "Dead"
 		     'U' = "Unknown";
 value $cdmv '' = "Not Submitted"
 			 'N' = "Not Found"
 			 'Y' = "Found";
 value $cdrace '' = "Not Applicable"
 			  '1' = "Oriental"
 			  '2' = "Native American"
 			  '3' = "Black"
 			  'U' = "Unknown";
 value $cdsex '' = "Not Applicable"
 			  '0' = "Male"
 			  'F' = "Female";
 value $ceduc '1' = "Grade School"
              '2' = "Some high school"
              '3' = "High School Graduate"
              '4' = "Associates Degree"
              '5' = "College Graduate"
              '6' = "Advanced Degree"
              '9' = "Unknown"
              'U' = "Unknown";
  value $crace '' = "Unknonw"
 			   '0' = "White"
 			   '2' = "Other"
 			   '3' = "Black";
  value csex 0 = "Male"
 			 1 = "Female"
 			 9 = "Unknonw";
  value $cssa '' = "Not Submitted"
  			  'A' = "Alive"
  			  'D' = "Dead"
  			  'I' = "Impossible SSN"
  			  'N' = "Non-match"
  			  'U' = "Unknown"
  			  'X' = "Duplicate";
  value ceducs 1 = "Grade School"
               2 = "Some high school"
               3 = "High School Graduate"
               4 = "Associates Degree"
               5 = "College Graduate"
               6 = "Advanced Degree"
               9 = "Unknown";
run;			

data mdfacw02;
	infile "/folders/myfolders/week2_hw/MDFACW02_d1.csv" DSD MISSOVER FIRSTOBS=2;
	informat bdate mmddyy10. ;
	informat hiredate mmddyy10. ;
 	informat termdate mmddyy10. ;
 	informat ddate mmddyy10. ;
 	informat dla mmddyy10. ;
	input orauid bdate sex educ $ hiredate termdate ddate icda8 $ autopsy $ dsex $ drace $ dcity $ dstate $ dcounty $ race $ dmvflag $ dmvdate $ cvs $ ssa861 $ dla seq_no;
	format bdate mmddyy10. ;
	format hiredate mmddyy10. ;
 	format termdate mmddyy10. ;
 	format ddate mmddyy10. ;
 	format dla mmddyy10. ;
 	format educ ceduc.;
 	format autopsy $cauto.;
 	format cvs $ccvs.;
 	format dmvflag $cdmv.;
 	format drace $cdrace.;
 	format dsex $cdsex.;
 	format race $crace.;
 	format sex csex.;
 	format ssa861 $cssa.;
	label autopsy = "Autopsy"
		  bdate	= "Date of birth"
		  cvs = "Vital status EOS 1983"
		  dcity	= "The city of death"
		  dcounty = "The county of death"
		  ddate = "Date of death"
		  dla = "Date last alive"
		  dmvdate= "Activity date returned by DMV"
		  dmvflag="Submitted to Ohio DMV in 1988"
		  drace="Race on death certificate"
		  dsex="Sex on death certificate"
		  dstate="The state of death"
		  educ="Education"
		  hiredate="Date of first hire at Mound"
		  icda8="Cause of death - ICDA 8th revision"
		  orauid="Oak Ridge assigned id number"
		  race="Race of worker"
		  seq_no="Sequence Number of Row"
		  sex="Sex"
		  ssa861="Results of a 1986 SSA submission"
	 	  termdate="Date of last termination from Mound";
run;

/* Exercise 2 Proc means */
proc means data=mdfacw02 n mean std median min max;
vars ddate dla seq_no ;
run;

/* Exercise 3 format and freq */
proc freq data=mdfacw02;
format educ $ceduc.;
tables educ /nocum;
run;

/* Exercise 4 Proc format and freq */
proc freq data=mdfacw02;
tables (educ)*cvs/norow nocol;
run;

/* Exercise 5 Proc means */
data age_data;
set mdfacw02;
age = (hiredate-bdate)/365;
run;

proc means data = age_data n mean std median min max nonobs maxdec = 2;
var age;
class educ;
run;

/* Exercise 6 */
data mdfacw_new;
	infile "/folders/myfolders/week2_hw/MDFACW02_d1.csv" DSD MISSOVER FIRSTOBS=2;
	informat bdate mmddyy10. ;
	informat hiredate mmddyy10. ;
 	informat termdate mmddyy10. ;
 	informat ddate mmddyy10. ;
 	informat dla mmddyy10. ;
	input orauid bdate sex educ hiredate termdate ddate icda8 $ autopsy $ dsex $ drace $ dcity $ dstate $ dcounty $ race $ dmvflag $ dmvdate $ cvs $ ssa861 $ dla seq_no;
	format bdate mmddyy10. ;
	format hiredate mmddyy10. ;
 	format termdate mmddyy10. ;
 	format ddate mmddyy10. ;
 	format dla mmddyy10. ;
 	format educ ceducs.;
 	format autopsy $cauto.;
 	format cvs $ccvs.;
 	format dmvflag $cdmv.;
 	format drace $cdrace.;
 	format dsex $cdsex.;
 	format race $crace.;
 	format sex csex.;
 	format ssa861 $cssa.;
	label autopsy = "Autopsy"
		  bdate	= "Date of birth"
		  cvs = "Vital status EOS 1983"
		  dcity	= "The city of death"
		  dcounty = "The county of death"
		  ddate = "Date of death"
		  dla = "Date last alive"
		  dmvdate= "Activity date returned by DMV"
		  dmvflag="Submitted to Ohio DMV in 1988"
		  drace="Race on death certificate"
		  dsex="Sex on death certificate"
		  dstate="The state of death"
		  educ="Education"
		  hiredate="Date of first hire at Mound"
		  icda8="Cause of death - ICDA 8th revision"
		  orauid="Oak Ridge assigned id number"
		  race="Race of worker"
		  seq_no="Sequence Number of Row"
		  sex="Sex"
		  ssa861="Results of a 1986 SSA submission"
	 	  termdate="Date of last termination from Mound";
run;

proc contents data=mdfacw_new order=varnum ;run;

ods _all_ close;