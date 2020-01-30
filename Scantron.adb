
with Ada.Text_IO; 
with Ada.Integer_Text_IO;
use Ada.Text_IO; 

PROCEDURE Scantron IS
	type response_array is array(Integer range 1..50) of Integer; 
	type freq is array(Integer range 0..100) of Integer;
	type Student is 
		record
			student_id : Integer := 0; 
			test_response : response_array; 
		end record; 
	file : FILE_TYPE; 
	questions : Integer := 0; 
	total_test : Integer := 0; 
	answer_key : response_array; 
	score_freq : freq := (others=>0);  
	stu : Student; 

	procedure grade(answers : in response_array) is	
		count : Integer := 0; 
	begin 
		for I in 1 .. questions loop
			if (answer_key(I) = answers(I)) then
				count := count + 1;   
			end if;
		end loop; 
		count := 100*count/questions; 
		score_freq(count) := score_freq(count)+1;
		total_test := total_test + 1; 
		Ada.Integer_Text_IO.Put(stu.student_id); 
		Ada.Text_IO.Put(" "); 
		Ada.Integer_Text_IO.Put(count); 
		New_Line; 
	end grade;

	procedure average(scores : in freq) is
		total : Integer := 0;
		avg : Integer := 0; 
	begin
		for I in 1 .. 100 loop
			if (scores(I)>0) then
				total := total + I*scores(I); 
			end if;
		end loop;
		avg := total/total_test;  
		Ada.Integer_Text_IO.Put(avg);  
	end average;

	procedure printArray(arr : in freq) is
		begin
			for I in reverse 0 .. 100 loop
				if (arr(I) > 0) then
					Ada.Integer_Text_IO.Put(I);
			 		Ada.Integer_Text_IO.Put(arr(I));
			 		New_Line;
				end if;
			end loop;
    end PrintArray;

begin 
	Ada.Text_IO.Put("File Name := "); 
	declare
		fileName : String := Ada.Text_IO.Get_Line; 
	begin
		Ada.Text_IO.Open(file, In_File, fileName);
		Ada.Integer_Text_IO.Get(file, questions); 
		for I in 1 ..questions loop
		 		Ada.Integer_Text_IO.Get(File, answer_key(I));  
		end loop;
		Ada.Text_IO.Put("     Student_ID     Score"); 
		New_Line;
		Ada.Text_IO.Put("    ======================");
		New_Line; 
		loop 
			exit when End_Of_File(File); 

			Ada.Integer_Text_IO.Get(file, stu.student_id); 
			For I in 1 .. questions loop
					Ada.Integer_Text_IO.Get(File, stu.test_response(I)); 
			end Loop; 	
			grade(stu.test_response); 
		end loop;
		Ada.Text_IO.Put("    ======================");
		New_Line;
		Ada.Text_IO.Put("     Test Graded =");
		Ada.Integer_Text_IO.Put(total_test);  
		New_Line;
		Ada.Text_IO.Put("    ======================");
		New_Line;
		Ada.Text_IO.Put("     Score      Frequency"); 
		New_Line;
		Ada.Text_IO.Put("    ======================");
		New_Line;
		PrintArray(score_freq);
		Ada.Text_IO.Put("    ======================");
		New_Line;
		Ada.Text_IO.Put("     Class average =");
		average(score_freq);
	end; 
end Scantron;  