/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Id]
      ,[PropertyTypeId]
      ,[AddressId]
      ,[Name]
      ,[Description]
      ,[Bedroom]
      ,[Bathroom]
      ,[LandSqm]
      ,[ParkingSpace]
      ,[FloorArea]
      ,[TargetRent]
      ,[TargetRentTypeId]
      ,[YearBuilt]
      ,[IsActive]
      ,[CreatedOn]
      ,[CreatedBy]
      ,[UpdatedOn]
      ,[UpdatedBy]
      ,[HasCompany]
      ,[IsOwnerOccupied]
  FROM [Keys].[dbo].[Property]

  select distinct [dbo].[Property].Id, [dbo].[Property].Name, [dbo].[Property].Bedroom, [dbo].[Property].Bathroom, 
         IsNull([dbo].[Address].Number,'')+' '+IsNull([dbo].[Address].Street,'')+' '+IsNull([dbo].[Address].Suburb,'')+' '+IsNull([dbo].[Address].City,'') as FullAdress, 
		 ISNULL([dbo].[Person].FirstName,'')+' '+ISNULL( [dbo].[Person].MiddleName,'')+' '+ISNULL([dbo].[Person].LastName,'') as OwnerName,
         [dbo].[PropertyRentalPayment].Amount as RentalPayment, [dbo].[PropertyRentalPayment].FrequencyType, 
         [dbo].[PropertyExpense].Amount as Expense, [dbo].[PropertyExpense].CreatedOn
   from [dbo].[Property] inner join [dbo].[Address] on [dbo].[Property].AddressId = [dbo].[Address].AddressId
                         inner join [dbo].[OwnerProperty] on [dbo].[Property].Id = [dbo].[OwnerProperty].PropertyId
						 inner join [dbo].[Person] on [dbo].[OwnerProperty].OwnerId = [dbo].[Person].Id
						 inner join [dbo].[PropertyRentalPayment] on [dbo].[PropertyRentalPayment].PropertyId = [dbo].[Property].Id
						 inner join [dbo].[PropertyExpense] on [dbo].[PropertyExpense].PropertyId = [dbo].[Property].Id;