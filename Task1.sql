--a. Display a list of all property names and their property id¡¯s for Owner Id: 1426.
Select [dbo].[Property].Id, [dbo].[Property].Name
from [dbo].[Property] inner join [dbo].[OwnerProperty] on
     [dbo].[OwnerProperty].PropertyId = [dbo].[Property].Id
where [dbo].[OwnerProperty].OwnerId = 1426;



--b. Display the current home value for each property in question a).
select [dbo].[Property].[Id], [dbo].[Property].Name, [dbo].[PropertyHomeValue].Value
from [dbo].[PropertyHomeValue] inner join [dbo].[Property] on
[dbo].[PropertyHomeValue].PropertyId = [dbo].[Property].Id
where [dbo].[PropertyHomeValue].[IsActive] = 1 and [dbo].[Property].Id in
                    (Select [dbo].[Property].Id
                     from [dbo].[Property] inner join [dbo].[OwnerProperty] on
                     [dbo].[OwnerProperty].PropertyId = [dbo].[Property].Id
                     where [dbo].[OwnerProperty].OwnerId = 1426)
order by [dbo].[Property].[Id];



--C. For each property in question a), return the following:                                                                      
--i. Using rental payment amount, rental payment frequency, tenant start date and tenant end date to write a query that returns the sum of all payments from start date to end date. 
--ii. Display the yield.
Select [dbo].[TenantProperty].TenantID, [dbo].[TenantProperty].PropertyID, [dbo].[TenantProperty].PaymentFrequencyID, [dbo].[TenantProperty].PaymentAmount,
IIf([dbo].[TenantProperty].PaymentFrequencyId=1, [dbo].[TenantProperty].PaymentAmount*Datediff(week,[dbo].[TenantProperty].StartDate,[dbo].[TenantProperty].Enddate),
    IIF([dbo].[TenantProperty].PaymentFrequencyId=2, [dbo].[TenantProperty].PaymentAmount*(Datediff(week,[dbo].[TenantProperty].StartDate,[dbo].[TenantProperty].Enddate)/2),
	 [dbo].[TenantProperty].PaymentAmount*(Datediff(month,[dbo].[TenantProperty].StartDate,[dbo].[TenantProperty].Enddate)+1))) as SumOfPayment
from [dbo].[TenantProperty] 
where [dbo].[TenantProperty].PropertyId in (Select [dbo].[Property].Id
                     from [dbo].[Property] inner join [dbo].[OwnerProperty] on
                     [dbo].[OwnerProperty].PropertyId = [dbo].[Property].Id
                     where [dbo].[OwnerProperty].OwnerId = 1426)
order by [dbo].[TenantProperty].PropertyID;



--d. Display all the jobs available in the marketplace (jobs that owners have advertised for service suppliers). 
Select * from [dbo].[Job]
Where [dbo].[Job].JobEndDate is null and [dbo].[Job].JobDescription like '%service%';



--e. Display all property names, current tenants first and last names and rental payments per week/ fortnight/month for the properties in question a). 
Select [dbo].[TenantProperty].TenantId, [dbo].[Property].Id, [dbo].[Property].Name as PropertyName, [dbo].[Person].FirstName, [dbo].[Person].LastName, 
       [dbo].[TenantProperty].PaymentAmount, [dbo].[TenantProperty].PaymentFrequencyId, [dbo].[TenantPaymentFrequencies].Name as Frequency
From [dbo].[Person] inner join [dbo].[Tenant] on [dbo].[Person].Id = [dbo].[Tenant].Id 
                    inner join [dbo].[TenantProperty] on [dbo].[Tenant].Id = [dbo].[TenantProperty].TenantId
					inner join [dbo].[Property] on [dbo].[TenantProperty].PropertyId = [dbo].[Property].Id
					inner join [dbo].[TenantPaymentFrequencies] on [dbo].[TenantPaymentFrequencies].Id = [dbo].[TenantProperty].PaymentFrequencyId
where [dbo].[Property].Id in (Select [dbo].[Property].Id
                     from [dbo].[Property] inner join [dbo].[OwnerProperty] on
                     [dbo].[OwnerProperty].PropertyId = [dbo].[Property].Id
                     where [dbo].[OwnerProperty].OwnerId = 1426)
order by [dbo].[Property].Id;