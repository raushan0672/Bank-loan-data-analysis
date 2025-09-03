CREATE DATABASE Bank_loan ;
USE Bank_loan;

-- view database
select * from bank_loan_data;

-- total loan applications
select count(id) as Total_Loan_Application from bank_loan_data;

select count(id) as MTD_Total_Loan_Application from bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021;

-- total funded amount
select sum(loan_amount) as Total_Funded_Amount from bank_loan_data;

select sum(loan_amount) as MTD_Total_Funded_Amount from bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021;

select sum(loan_amount) as PMTD_Total_Funded_Amount from bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021;

-- total payments
select sum(total_payment) as Total_Payments from bank_loan_data;

select sum(total_payment) as MTD_Total_Payments from bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021;

select sum(total_payment) as PMTD_Total_Payments from bank_loan_data
where month(issue_date) = 11 and year(issue_date) = 2021;

-- average interest rate
select Round(avg(int_rate)*100,2) as AVG_Interest_Rate from bank_loan_data;

select Round(avg(int_rate)*100,2) as MTD_AVG_Interest_Rate from bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021;

select Round(avg(int_rate)*100,2) as PMTD_AVG_Interest_Rate from bank_loan_data
where month(issue_date) = 11 and year(issue_date) = 2021;

-- average DTI
select Round(avg(dti)*100,2) as AVG_DTI from bank_loan_data;

select Round(avg(dti)*100,2) as MTD_AVG_dti from bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021;

select Round(avg(dti)*100,2) as PMTD_AVG_dti from bank_loan_data
where month(issue_date) = 11 and year(issue_date) = 2021;

-- loan status
select distinct loan_status from bank_loan_data;

-- Loans
-- GOOD LOAN

-- total loan_status percentage 
select
	(count(case when loan_status = 'Fully Paid' or loan_status = 'Current' then id end)*100)
    / count(id) as Good_loan_percentage
from bank_loan_data;    
    
-- total no of good loans 
select count(id) as Good_loan_Application from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current';   



-- good loan funded amount
select sum(loan_amount) as Good_loan_Funded_Amt from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current';   

-- good loan total received amount
select sum(total_payment) as Good_loan_Recevied_Amt from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current';  

-- good loan total received amount > good loan funded amount , so bank is receiveing profit from good loans

-- checking the same for bad loans

-- BAD LOANS
-- total loan_status percentage 
select
    (count(case when loan_status = 'Charged Off' then id end)*100)
    / count(id) as Bad_loan_percentage
from bank_loan_data;    

-- total no of bad loans 
select count(id) as Bad_loan_Application from bank_loan_data
where loan_status = 'Charged Off'; 

-- bad loan funded amount
select sum(loan_amount) as Bad_loan_Funded_Amt from bank_loan_data
where loan_status = 'Charged Off';

-- bad loan total received amount
select sum(total_payment) as Bad_loan_Recevied_Amt from bank_loan_data
where loan_status = 'Charged Off';

-- bad loan total received amount < bad loan funded amount , so bank is NOT receiveing profit from bad loans

-- ----------------------------------------------------------------------------------------------------------------

-- LOAN STATUS GRID

select
        loan_status,
        COUNT(id) as Total_Loan_Application,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
from
        bank_loan_data
group by
        loan_status;
        
-- MTD Loan Status

select 
	loan_status, 
	sum(total_payment) as MTD_Total_Amount_Received, 
	sum(loan_amount) as MTD_Total_Funded_Amount 
from bank_loan_data
where month(issue_date) = 12 
group by loan_status;

-- -------------------------------------------------------
-- insignts wrt to monthly trend
select
	month(issue_date) as Month_Number,
	monthname(issue_date) as Month_Name,
    count(id) as Total_Loan_Application,
    sum(loan_amount) as Total_Funded_Amount,
    sum(total_payment) as Total_received_Amount
from bank_loan_data    
group by monthname(issue_date) ,month(issue_date)
order by month(issue_date);

-- insights wrt to addres state
select
	address_state,
    count(id) as Total_Loan_Application,
    sum(loan_amount) as Total_Funded_Amount,
    sum(total_payment) as Total_received_Amount
from bank_loan_data    
group by address_state
order by address_state;

-- wrt to term

select
	term,
    count(id) as Total_Loan_Application,
    sum(loan_amount) as Total_Funded_Amount,
    sum(total_payment) as Total_received_Amount
from bank_loan_data    
group by term
order by term;

-- wrt to employee length

select
	emp_length,
    count(id) as Total_Loan_Application,
    sum(loan_amount) as Total_Funded_Amount,
    sum(total_payment) as Total_received_Amount
from bank_loan_data    
group by emp_length
order by count(id) desc;

-- wrt to purpose
select
	purpose,
    count(id) as Total_Loan_Application,
    sum(loan_amount) as Total_Funded_Amount,
    sum(total_payment) as Total_received_Amount
from bank_loan_data    
group by purpose
order by count(id) desc;

-- wrt to home ownership
select
	home_ownership,
    count(id) as Total_Loan_Application,
    sum(loan_amount) as Total_Funded_Amount,
    sum(total_payment) as Total_received_Amount
from bank_loan_data    
group by home_ownership
order by count(id) desc;

-- ---------------------------------------------------------------------------------





