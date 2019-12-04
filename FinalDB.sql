CREATE OR REPLACE FUNCTION SHOW_VERIFICATION_DIGIT(text_input varchar2) RETURN NUMBER IS
  response_code number := 0;
  acum number := 0;
  ctrl_size number := 0;
  check_digit number := 0;
BEGIN
   ctrl_size := length(text_input) + 1;
   
   FOR X IN 1..length(text_input) LOOP
     DBMS_OUTPUT.PUT_LINE('value => '|| ctrl_size);
     acum := acum + TO_NUMBER(SUBSTR(text_input, X, 1)) * ctrl_size;
     ctrl_size := ctrl_size - 1;
     DBMS_OUTPUT.PUT_LINE(acum);
     
     IF X = length(text_input) and length(text_input) = 10 THEN
       check_digit := floor( (acum / 11) - 9);
       DBMS_OUTPUT.PUT_LINE('Verification digit ISBN-10 => '||check_digit);
     ELSIF X = length(text_input) and length(text_input) = 13 THEN
       check_digit := floor( (acum / 10) - 3);
       DBMS_OUTPUT.PUT_LINE('Verification digit ISBN-13 => '||check_digit);
     END IF;
   END LOOP;
   
   
   IF check_digit > 9 THEN 
      check_digit := 0; --return 0, because I can't return X (character)
      DBMS_OUTPUT.PUT_LINE('Verification digit ISBN-10 => X');
   END IF;
   
   CASE
      WHEN length(text_input) = 10 THEN 
        DBMS_OUTPUT.PUT_LINE('Can be handled ten digits (ISBN-10)');
        RETURN check_digit;
      WHEN length(text_input) = 13 THEN 
        DBMS_OUTPUT.PUT_LINE('Can be handled ten digits (ISBN-13)');
        RETURN check_digit;
   ELSE
        DBMS_OUTPUT.PUT_LINE('The size of ISBN is not valid, the size must be 10 or 13, try again');
        RETURN 99;
   END CASE;
   
END;

DECLARE
   text_input varchar2(13) := '030640615';
   text_input2 varchar2(13) := '978030640615';
   response number;
   response2 number;
BEGIN
  response := SHOW_VERIFICATION_DIGIT(text_input);
  response2 := SHOW_VERIFICATION_DIGIT(text_input2);
  dbms_output.put_line('The result is: ' || response );
END;


create table isbns (
 id INT,
 isbn VARCHAR(50),
 verification_digit INT
);
insert into isbns (id, isbn, verification_digit) values (1, '2562661363', 0);
insert into isbns (id, isbn, verification_digit) values (2, '3561817960', 0);
insert into isbns (id, isbn, verification_digit) values (3, '0887756445', 0);
insert into isbns (id, isbn, verification_digit) values (4, '5724355022', 0);
insert into isbns (id, isbn, verification_digit) values (5, '6993457337', 0);
insert into isbns (id, isbn, verification_digit) values (6, '1132996889', 0);
insert into isbns (id, isbn, verification_digit) values (7, '9532197546', 0);
insert into isbns (id, isbn, verification_digit) values (8, '8269322525', 0);
insert into isbns (id, isbn, verification_digit) values (9, '4565761265', 0);
insert into isbns (id, isbn, verification_digit) values (10, '4476752961', 0);

select * from isbns;

select SHOW_VERIFICATION_DIGIT(isbn) from isbns where ID = 1;
/*Create a function which will receive a string of 10 or 13 digits.
The function must raise an exception if the size of the string is different than 10 or 13 and return '99'
The function should return the verification digit.*/