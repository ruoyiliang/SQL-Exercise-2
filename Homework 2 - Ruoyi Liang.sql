Use Colonial;

select Trip.TripID, Trip.TripName, Reservation.ReservationID
from Trip
left join Reservation
on Trip.TripID = Reservation.TripID
where Reservation.ReservationID is Null; -- Q1/1

select STRR_1.TripID, STRR_1.TripName, STRR_2.TripID, STRR_2.TripName
from Trip STRR_1
inner join Trip STRR_2
on STRR_1.StartLocation = STRR_1.StartLocation and STRR_2.TripID < STRR_2.TripID; -- Q1/2

select distinct Customer.CustomerNum, Customer.LastName, Customer.FirstName 
from Customer
inner join Reservation 
on Reservation.CustomerNum = Customer.CustomerNum; -- Q1/3

select * from Guide 
left outer join TripGuides 
on Guide.GuideNum = TripGuides.GuideNum 
where TripGuides.GuideNum is null; -- Q1/4

select INFO_1.GuideNum, INFO_1.LastName, INFO_1.FirstName, INFO_2.GuideNum, INFO_2.LastName, INFO_2.FirstName, INFO_2.State
from Guide INFO_1
inner join Guide INFO_2
on INFO_1.State = INFO_2.State and INFO_1.GuideNum < INFO_2.GuideNum; -- Q1/5

select INFO_1.GuideNum, INFO_1.LastName, INFO_1.FirstName, INFO_2.GuideNum, INFO_2.LastName, INFO_2.FirstName, INFO_2.City, INFO_2.State
from Guide INFO_1
inner join Guide INFO_2
on INFO_1.State = INFO_2.State and INFO_1.City = INFO_2.City and INFO_1.GuideNum < INFO_2.GuideNum; -- Q1/6

Use EntertainmentAgencyExample;

select EntStageName, EntPhoneNumber, EntCity
from Entertainers
where EntCity = 'Bellevue' or EntCity = 'Redmond' or EntCity = 'Woodinville'; -- Q2/1

select EngagementNumber, StartDate, EndDate
from Engagements
where datediff(EndDate, StartDate) = 3; -- Q2/2

select Entertainers.EntertainerID, Engagements.StartDate, Engagements.EndDate, Engagements.ContractPrice
from Entertainers
inner join Engagements
on Entertainers.EntertainerID = Engagements.EntertainerID; -- Q2/3

select distinct Entertainers.EntertainerID from Entertainers
inner join Engagements on Entertainers.EntertainerID = Engagements.EntertainerID
inner join Customers on Engagements.CustomerID = Customers.CustomerID
where Customers.CustLastName = 'Berg' or Customers.CustLastName = 'Hallmark'; -- Q2/4

select AgentID, StartDate
from Engagements
order by StartDate; -- Q2/5

select distinct Customers.CustomerID, Entertainers.EntertainerID
from Customers
inner join Engagements on Customers.CustomerID = Engagements.CustomerID
inner join Entertainers on Engagements.EntertainerID = Entertainers.EntertainerID; -- Q2/6

select concat(Agents.AgtFirstName, ' ',  Agents.AgtLastName) as AgtFullName, Entertainers.EntStageName
from Agents, Entertainers
where Agents.AgtZipCode = Entertainers.EntZipCode; -- Q2/7

select Entertainers.EntertainerID
from Entertainers
left join Engagements on Entertainers.EntertainerID = Engagements.EntertainerID
where Engagements.EntertainerID is null; -- Q2/8

select Musical_Styles.StyleName, Musical_Preferences.PreferenceSeq
from Musical_Styles
left join Musical_Preferences on Musical_Styles.StyleID = Musical_Preferences.StyleID
where PreferenceSeq > 0 or PreferenceSeq is null; -- Q2/9

select Agents.AgentID, Engagements.EngagementNumber
from Agents
left join Engagements on Agents.AgentID = Engagements.AgentID
where Engagements.EngagementNumber is null; -- Q2/10

select Customers.CustomerID, Engagements.EngagementNumber
from Customers
left join Engagements on Customers.CustomerID = Engagements.CustomerID
where Engagements.EngagementNumber is null; -- Q2/11

select distinct Entertainers.EntertainerID, Engagements.EngagementNumber
from Entertainers
left join Engagements on Entertainers.EntertainerID = Engagements.EntertainerID; -- Q2/12

select distinct concat(CustLastName, ' ', CustFirstName) as Name, 'Customer' as 'Type'
from Customers
Union
select distinct EntStageName as Name, 'Entertainer' as 'Type'
from Entertainers; -- Q2/13

select concat(CustLastName, ' ', CustFirstName) as Name, 'Customer' as 'Type'
from Customers
inner join Musical_Preferences on Customers.CustomerID = Musical_Preferences.CustomerID
where Musical_Preferences.StyleID = 10
union
select EntStageName as Name, 'Entertainer' as 'Type'
from Entertainers
inner join Entertainer_Styles on Entertainers.EntertainerID = Entertainer_Styles.EntertainerID
where Entertainer_Styles.StyleID = 10; -- Q2/14

select distinct concat(AgtLastName, ' ', AgtFirstName) as Name, 'Agent' as 'Type'
from Agents
Union
select distinct EntStageName as Name, 'Entertainer' as 'Type'
from Entertainers; -- Q2/15

Use accountspayable;

select *
from invoices; -- Q3/1

select invoice_number, invoice_date, invoice_total
from invoices
order by invoice_total desc; -- Q3/2

select  invoice_id, invoice_number
from invoices
where invoice_date like '2014-06%'; -- Q3/3

select vendor_contact_last_name, vendor_contact_first_name
from vendors
order by vendor_contact_last_name, vendor_contact_first_name; -- Q3/4

select vendor_contact_last_name, vendor_contact_first_name
from vendors
where vendor_contact_last_name like 'A%' 
or vendor_contact_last_name like 'B%'
or vendor_contact_last_name like 'C%'
or vendor_contact_last_name like 'E%'
order by vendor_contact_last_name, vendor_contact_first_name; -- Q3/5

select invoice_due_date, invoice_total*1.1
from invoices
where invoice_total >= 500 and invoice_total <= 1000
order by invoice_due_date desc; -- Q3/6

select invoice_number, invoice_total, credit_total, invoice_total - payment_total - credit_total
from invoices
where invoice_total - payment_total - credit_total > 50
order by 4 desc
limit 5; -- Q3/7

select invoice_id
from invoices
where invoice_total - payment_total - credit_total > 0; -- Q3/8

select vendor_name
from vendors
inner join invoices on vendors.vendor_id = invoices.vendor_id
where invoice_total - payment_total - credit_total > 0; -- Q3/9

select vendor_name, default_account_number
from vendors; -- Q3/10

select line_item_description, vendor_id
from invoice_line_items
inner join invoices on invoice_line_items.invoice_id = invoices.invoice_id; -- Q3/11

select vendor1.vendor_name, vendor2.vendor_name, vendor1.vendor_contact_last_name
from vendors vendor1 
inner join vendors vendor2 on vendor1.vendor_contact_last_name = vendor2.vendor_contact_last_name
where vendor1.vendor_name <> vendor2.vendor_name; -- Q3/12

select distinct general_ledger_accounts.account_number
from general_ledger_accounts
left join invoice_line_items on invoice_line_items.account_number = general_ledger_accounts.account_number
where invoice_line_items.account_number is null
order by general_ledger_accounts.account_number; -- Q3/13

select vendor_name, 'CA' as 'State'
from vendors
where vendor_state = 'CA'
union
select vendor_name, 'Outside CA' as 'State'
from vendors
where vendor_state <> 'CA'; -- Q3/14






































