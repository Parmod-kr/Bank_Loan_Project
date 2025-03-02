select * from bank_loan_table;

-- Total_Loan_Application

SELECT COUNT(id) AS Total_Applications FROM bank_loan_table;

--MTD loan Application

select COUNT(id) as Total_MTD_Application from bank_loan_table
where MONTH(issue_date) = 12 And YEAR(issue_date) = 2021 ;

--PMTD loan Application

select COUNT(id) as Total_PMTD_Application from bank_loan_table
where MONTH(issue_date) = 11 And YEAR(issue_date) = 2021 ;

--Total_funded_amount

SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_table;

--MTD Total Sale

SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount FROM bank_loan_table
where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021;

--PMTD Total Sale
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount FROM bank_loan_table
where MONTH(issue_date) = 11 and YEAR(issue_date) = 2021;

-- Total amount received By Bank
SELECT SUM(total_payment) AS Total_Amount_Received FROM bank_loan_table;

-- Total amount received By Bank in MTD
SELECT SUM(total_payment) AS MTD_Total_Amount_Received FROM bank_loan_table
WHERE MONTH(issue_date) = 12 and YEAR(issue_date) = 2021;

-- Total amount received By Bank in PMTD
SELECT SUM(total_payment) AS PMTD_Total_Amount_Received FROM bank_loan_table
WHERE MONTH(issue_date) = 11 and YEAR(issue_date) = 2021;

--Average Interest Rate
SELECT round(AVG(int_rate)*100,2) AS Avg_Int_Rate FROM bank_loan_table;

--MTD Average Interest Rate
SELECT round(AVG(int_rate)*100,2) AS MTD_Avg_Int_Rate FROM bank_loan_table
where MONTH(issue_date) = 12 and YEAR (issue_date) = 2021;

--PMTD Average Interest Rate
SELECT round(AVG(int_rate)*100,2) AS PMTD_Avg_Int_Rate FROM bank_loan_table
where MONTH(issue_date) = 11 and YEAR (issue_date) = 2021;

----Average DTI
select round(AVG(dti)*100,2) from bank_loan_table;

--Average MTD Dti
select ROUND(avg(dti)*100,2) as MTD_avg_dti from bank_loan_table
where MONTH(issue_date) = 12 And year(issue_date) = 2021;

--Average PMTD Dti
select ROUND(avg(dti)*100,2) as PMTD_avg_dti from bank_loan_table
where MONTH(issue_date) = 11 And year(issue_date) = 2021;

--GOOD LOAN ISSUED
--Good Loan Percentage
SELECT
	(COUNT(case when loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END)*100)/ 
	COUNT(id) as good_loan_percentage
from bank_loan_table;

--Good Loan Application
SELECT COUNT(id) as good_loan_application from bank_loan_table
WHERE loan_status = 'Fully Paid' or loan_status = 'Current';


--Good Loan Funded Amount
SELECT sum(loan_amount) as good_loan_funded from bank_loan_table
WHERE loan_status = 'Fully Paid' or loan_status = 'Current';

--Good Loan Amount Received
SELECT sum(total_payment) as good_loan_received from bank_loan_table
WHERE loan_status = 'Fully Paid' or loan_status = 'Current';

--Bad Loan
-- Bad loan Percentage

SELECT
	(COUNT(case when loan_status = 'Charged off' THEN id END)*100)/ 
	COUNT(id) as bad_loan_percentage
from bank_loan_table;

--Bad Loan Application

SELECT COUNT(id) as bad_loan_application from bank_loan_table
where loan_status = 'Charged off';

--Bad Loan Funded Amount
SELECT sum(loan_amount) as Bad_loan_funded from bank_loan_table
WHERE loan_status = 'Charged off';

--Bad Loan Amount Received
SELECT sum(total_payment) as Bad_loan_amount_received from bank_loan_table
WHERE loan_status = 'Charged off';

--Loan Status
Select loan_status,
COUNT(id) as total_loan_application,
SUM(total_payment) as total_amount_received,
SUM(loan_amount) as total_amount_funded,
round(AVG(int_rate*100),2) as interest_rate,
round(AVG(dti*100),2) as avg_Dti
from 
	bank_loan_table
GROUP BY
	loan_status;

--Loan Status MTD
Select loan_status,
COUNT(id) as total_loan_application,
SUM(total_payment) as total_amount_received,
SUM(loan_amount) as total_amount_funded
from 
	bank_loan_table
WHERE
	MONTH(issue_date) = 12
GROUP BY
	loan_status;

----------------------Bank Loan Report-----------------------------------
--Monthly Loan_Status
Select 
MONTH(issue_date) as month_number,
datename(Month,issue_date) as month_name,
COUNT(id) as total_loan_application,
SUM(total_payment) as total_amount_received,
SUM(loan_amount) as total_amount_funded
from 
	bank_loan_table
GROUP BY
	MONTH(issue_date),DATENAME(Month,issue_date)
ORDER BY MONTH(issue_date);

--Loan_Status_STATEWISE
Select 
address_state as State,
COUNT(id) as total_loan_application,
SUM(total_payment) as total_amount_received,
SUM(loan_amount) as total_amount_funded
from 
	bank_loan_table
GROUP BY
	address_state
ORDER BY total_loan_application desc,address_state;

--Loan_Status_as_per_Duration
Select 
term ,
COUNT(id) as total_loan_application,
SUM(total_payment) as total_amount_received,
SUM(loan_amount) as total_amount_funded
from 
	bank_loan_table
GROUP BY
	term
ORDER BY total_loan_application ;

--Loan_Status_as_per_emp_serving_duration
Select 
emp_length as employee_length,
COUNT(id) as total_loan_application,
SUM(total_payment) as total_amount_received,
SUM(loan_amount) as total_amount_funded
from 
	bank_loan_table
GROUP BY
	emp_length
ORDER BY total_loan_application ;

--Loan_Status_as_per_home_ownership

Select 
home_ownership as HO_new,
COUNT(id) as total_loan_application,
SUM(total_payment) as total_amount_received,
SUM(loan_amount) as total_amount_funded
from 
	bank_loan_table
GROUP BY
	home_ownership
ORDER BY total_loan_application;

---Loan_status as per grade

Select 
purpose as Purpose,
COUNT(id) as total_loan_application,
SUM(total_payment) as total_amount_received,
SUM(loan_amount) as total_amount_funded
from 
	bank_loan_table
Where grade = 'A'
GROUP BY purpose
Order by purpose;























