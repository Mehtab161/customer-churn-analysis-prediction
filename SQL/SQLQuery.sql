use db_churn;

select * from [dbo].[stg_Churn];

select Gender, count(*) as Total_Count,
count(gender) * 1.0 / (select count(*) from stg_Churn) as Percentage from stg_Churn
group by Gender;

select Contract, count(*) as Total_Count,
count(Contract) * 1.0 / (select count(*) from stg_Churn) as Percentage from stg_Churn
group by Contract;

select Customer_Status, count(Customer_Status) as Total_Count, sum(Total_Revenue) as TotalRev,
sum(Total_Revenue) / (select sum(Total_Revenue) from stg_Churn) * 100 as Percentage from stg_Churn
group by Customer_Status;


select State, count(State) as Total_Count,
count(State) * 100 / (select count(*) from stg_Churn) as Percentage from stg_Churn
group by State
order by Percentage desc;

select distinct Internet_Type from stg_Churn;

select
sum(case when Customer_ID is null then 1 else 0 end) as Customer_ID_Null_Count,
sum(case when Gender is null then 1 else 0 end) as Gender_Null_Count,
sum(case when Age is null then 1 else 0 end) as Age_Null_Count,
sum(case when Married is null then 1 else 0 end) as Married_Null_Count,
sum(case when State is null then 1 else 0 end) as State_Null_Count,
sum(case when Number_of_Referrals is null then 1 else 0 end) as Number_of_Referrals_Null_Count,
sum(case when Tenure_in_Months is null then 1 else 0 end) as Tenure_in_Months_Null_Count,
sum(case when Value_Deal is null then 1 else 0 end) as Value_Deal_Null_Count,
sum(case when Phone_Service is null then 1 else 0 end) as Phone_Service_Null_Count,
sum(case when Multiple_Lines is null then 1 else 0 end) as Multiple_Lines_Null_Count,
sum(case when Internet_Service is null then 1 else 0 end) as Internet_Service_Null_Count,
sum(case when Internet_Type is null then 1 else 0 end) as Internet_Type_Null_Count,
sum(case when Online_Security is null then 1 else 0 end) as Online_Security_Null_Count,
sum(case when Online_Backup is null then 1 else 0 end) as Online_Backup_Null_Count,
sum(case when Device_Protection_Plan is null then 1 else 0 end) as Device_Protection_Plan_Null_Count,
sum(case when Premium_Support is null then 1 else 0 end) as Premium_Support_Null_Count,
sum(case when Streaming_TV is null then 1 else 0 end) as Streaming_TV_Null_Count,
sum(case when Streaming_Movies is null then 1 else 0 end) as Streaming_Movies_Null_Count,
sum(case when Streaming_Music is null then 1 else 0 end) as Streaming_Music_Null_Count,
sum(case when Unlimited_Data is null then 1 else 0 end) as Unlimited_Data_Null_Count,
sum(case when Contract is null then 1 else 0 end) as Contract_Null_Count,
sum(case when Paperless_Billing is null then 1 else 0 end) as Paperless_Billing_Null_Count,
sum(case when Payment_Method is null then 1 else 0 end) as Payment_Method_Null_Count,
sum(case when Monthly_Charge is null then 1 else 0 end) as Monthly_Charge_Null_Count,
sum(case when Total_Charges is null then 1 else 0 end) as Total_Charges_Null_Count,
sum(case when Total_Refunds is null then 1 else 0 end) as Total_Refunds_Null_Count,
sum(case when Total_Extra_Data_Charges is null then 1 else 0 end) as Total_Extra_Data_Charges_Null_Count,
sum(case when Total_Long_Distance_Charges is null then 1 else 0 end) as Total_Long_Distance_Charges_Null_Count,
sum(case when Total_Revenue is null then 1 else 0 end) as Total_Revenue_Null_Count,
sum(case when Customer_Status is null then 1 else 0 end) as Customer_Status_Null_Count,
sum(case when Churn_Category is null then 1 else 0 end) as Churn_Category_Null_Count,
sum(case when Churn_Reason is null then 1 else 0 end) as Churn_Reason_Null_Count
from stg_Churn;

select
Customer_ID,
Gender,
Age,
Married,
State,
Number_of_Referrals,
Tenure_in_Months,
isnull(Value_Deal, 'None') as Value_Deal,
Phone_Service,
isnull(Multiple_Lines, 'No') as Multiple_Lines,
Internet_Service,
isnull(Internet_Type, 'None') as Internet_Type,
isnull(Online_Security, 'No') as Online_Security,
isnull(Online_Backup, 'No') as Online_Backup,
isnull(Device_Protection_Plan, 'No') as Device_Protection_Plan,
isnull(Premium_Support, 'No') as Premium_Support,
isnull(Streaming_TV, 'No') as Streaming_TV,
isnull(Streaming_Movies, 'No') as Streaming_Movies,
isnull(Streaming_Music, 'No') as Streaming_Music,
isnull(Unlimited_Data, 'No') as Unlimited_Data,
Contract,
Paperless_Billing,
Payment_Method,
Monthly_Charge,
Total_Charges,
Total_Refunds,
Total_Extra_Data_Charges,
Total_Long_Distance_Charges,
Total_Revenue,
Customer_Status,
isnull(Churn_Category, 'Others') as Churn_Category,
isnull(Churn_Reason, 'Others') as Churn_Reason
into [db_churn].[dbo].[prod_Churn]
from [db_churn].[dbo].[stg_Churn];

select * from prod_Churn;

create view vw_ChurnData as
	select * from prod_Churn where Customer_Status in ('Churned', 'Stayed');

create view vw_JoinData as
	select * from prod_Churn where Customer_Status = 'Joined';
