select  make, count(*) as carsNumber from masterDetails
where year between 1950 and 2000
group by make 
order by carsNumber desc


select * from (
select   makes.MakeID , count(*) as carsNumber from VehicleDetails 
inner join makes on makes.MakeID = VehicleDetails.MakeID
where year between 1950 and 2000 
group by makes.MakeID
) r1  

select * , CAST(carsNumber as float) / CAST(total as float) from (
select top 100   makes.MakeID , count(*) as carsNumber,  (select count(*) from VehicleDetails) as total  from VehicleDetails 
inner join makes on makes.MakeID = VehicleDetails.MakeID
where year between 1950 and 2000 
group by makes.MakeID ) r1
order by carsNumber desc

-- Get Make, FuelTypeName and Number of Vehicles per FuelType per Make
select Makes.make , FuelTypes.FuelTypeName , count(*) as CarsNumber from VehicleDetails 
join Makes on Makes.MakeID = VehicleDetails.MakeID
join FuelTypes on FuelTypes.FuelTypeID = VehicleDetails.FuelTypeID
group by Makes.make , FuelTypes.FuelTypeName
order by Makes.Make

--  Problem 9: Get all vehicles that runs with GAS

select VehicleDetails.ID, FuelTypes.FuelTypeName  from VehicleDetails 
join FuelTypes on FuelTypes.FuelTypeID = VehicleDetails.FuelTypeID
where  FuelTypes.FuelTypeName = 'GAs'

--  Problem 10: Get all Makes that runs with GAS

select distinct  Makes.make, FuelTypes.FuelTypeName  from VehicleDetails 
join FuelTypes on FuelTypes.FuelTypeID = VehicleDetails.FuelTypeID
join Makes on Makes.MakeID = VehicleDetails.MakeID

where  FuelTypes.FuelTypeName = N'GAs'

--Problem 11: Get Total Makes that runs with GAS

select count(*)  from (
select distinct   Makes.make, FuelTypes.FuelTypeName  from VehicleDetails 
join FuelTypes on FuelTypes.FuelTypeID = VehicleDetails.FuelTypeID
join Makes on Makes.MakeID = VehicleDetails.MakeID

where  FuelTypes.FuelTypeName = N'GAs') as r1

--  Problem 12: Count Vehicles by make and order them by NumberOfVehicles from high to low.

select * from (
select distinct   Makes.make, count(*) as totalVehicles  from VehicleDetails 
join FuelTypes on FuelTypes.FuelTypeID = VehicleDetails.FuelTypeID
join Makes on Makes.MakeID = VehicleDetails.MakeID
group by Makes.make
) r1 order by totalVehicles desc


select distinct   Makes.make, count(*) as totalVehicles  from VehicleDetails 
join FuelTypes on FuelTypes.FuelTypeID = VehicleDetails.FuelTypeID
join Makes on Makes.MakeID = VehicleDetails.MakeID
group by Makes.make
order by totalVehicles desc

--  Problem 13: Get all Makes/Count Of Vehicles that manufactures more than 20K Vehicles

select * from (
select distinct   Makes.make, count(*) as totalVehicles  from VehicleDetails 
join FuelTypes on FuelTypes.FuelTypeID = VehicleDetails.FuelTypeID
join Makes on Makes.MakeID = VehicleDetails.MakeID
group by Makes.make
) r1
where totalVehicles > 20000 order by totalVehicles desc


select distinct   Makes.make from VehicleDetails 
join FuelTypes on FuelTypes.FuelTypeID = VehicleDetails.FuelTypeID
join Makes on Makes.MakeID = VehicleDetails.MakeID
where Makes.make like 'b%'

--  Problem 15: Get all Makes with make ends with 'W'
select make from Makes 
where make like '%w'

--  Problem 16: Get all Makes that manufactures DriveTypeName = FWD
select distinct Makes.make , DriveTypes.DriveTypeName from VehicleDetails 
 join Makes on Makes.MakeID = VehicleDetails.MakeID 
join DriveTypes on DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID
where DriveTypes.DriveTypeName = 'FWD'

--  Problem 17: Get total Makes that Mantufactures DriveTypeName=FWD
select count(*) from (
select distinct makes.Make from Makes
join VehicleDetails on VehicleDetails.MakeID = Makes.MakeID
join DriveTypes on DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID
where DriveTypes.DriveTypeName = 'fwd'
) r1

--  Problem 18: Get total vehicles per DriveTypeName Per Make and order them per make asc then per total Desc
select Makes.Make, DriveTypes.DriveTypeName , count(*) as totalV from VehicleDetails
join Makes on Makes.MakeID = VehicleDetails.MakeID 
join DriveTypes on DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID
group by Makes.Make, DriveTypes.DriveTypeName 
order by  Makes.Make asc  , totalV desc 

--  Problem 19: Get total vehicles per DriveTypeName Per Make then filter only results with total > 10,000
select Makes.Make, DriveTypes.DriveTypeName , count(*) as totalV from VehicleDetails
join Makes on Makes.MakeID = VehicleDetails.MakeID 
join DriveTypes on DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID
group by Makes.Make, DriveTypes.DriveTypeName 
having count(*) > 10000
 
--  Problem 20: Get all Vehicles that number of doors is not specified
select id, NumDoors  as number from VehicleDetails
where NumDoors is null

select distinct NumDoors , count (*) as number from VehicleDetails
group by NumDoors

--   Problem 21: Get Total Vehicles that number of doors is not specified
select count(*) as number from VehicleDetails
where NumDoors is null

--   Problem 22: Get percentage of vehicles that has no doors specified

select 
(cast(count(*) as float)  
/ 
(select  count(*) from VehicleDetails))       
from VehicleDetails
where NumDoors is null
  
  select 
	(
		CAST(	(select count(*) as TotalWithNoSpecifiedDoors from VehicleDetails
		where NumDoors is Null) as float)
		/
		Cast( (select count(*) from VehicleDetails as TotalVehicles) as float)
	) as PercOfNoSpecifiedDoors

--  Problem 23: Get MakeID , Make, SubModelName for all vehicles that have SubModelName 'Elite'
select distinct VehicleDetails.MakeID, Makes.Make, SubModels.SubModelName from VehicleDetails 
join Makes on makes.MakeID = VehicleDetails.MakeID
join SubModels on SubModels.SubModelID = VehicleDetails.SubModelID
where SubModels.SubModelName = 'elite'
 
--  Problem 24: Get all vehicles that have Engines > 3 Liters and have only 2 doors
select * from VehicleDetails 
where Engine_Liter_Display > 3 and NumDoors= 2
order by Engine_Liter_Display

--  Problem 25: Get make and vehicles that the engine contains 'OHV' and have Cylinders = 4
select Makes.Make , VehicleDetails.*  from VehicleDetails
join makes on makes.MakeID = VehicleDetails.MakeID
where VehicleDetails.Engine  like '%ohv%' and VehicleDetails.Engine_Cylinders = 4

--   Problem 26: Get all vehicles that their body is 'Sport Utility' and Year > 2020
select Bodies.BodyName , VehicleDetails.*  from VehicleDetails
join Bodies on Bodies.BodyID = VehicleDetails.BodyID
where Bodies.BodyName = 'Sport Utility' and VehicleDetails.Year = 2020
 
--  Problem 27: Get all vehicles that their Body is 'Coupe' or 'Hatchback' or 'Sedan'

select Bodies.BodyName , VehicleDetails.*  from VehicleDetails
join Bodies on Bodies.BodyID = VehicleDetails.BodyID
where BodyName in ( 'coupe' ,'hatchback' , 'sedan')

--  Problem 28: Get all vehicles that their body is 'Coupe' or 'Hatchback' or 'Sedan' and manufactured in year 2008 or 2020 or 2021

select Bodies.BodyName , VehicleDetails.*  from VehicleDetails
join Bodies on Bodies.BodyID = VehicleDetails.BodyID
where BodyName in ( 'coupe' ,'hatchback' , 'sedan') and VehicleDetails.Year in ( 2008, 2020, 2021)

--   Problem 29: Return found=1 if there is any vehicle made in year 1950
select found=1 
where 
exists (
        select top 1 * from VehicleDetails where Year =1950
      )

--  Problem 30: Get all Vehicle_Display_Name, NumDoors and add extra column to describe number of doors by words, and if door is null display 'Not Set'

select Vehicle_Display_Name, NumDoors, doorStatus = 
case 
	when NumDoors is null then 'not set'
	when NumDoors = 0 then 'Zeero door'
	when NumDoors = 1 then 'one door'
	when NumDoors = 2 then 'tow door'
	when NumDoors = 3 then 'three doors'
	when NumDoors = 4 then 'four doors'
	when NumDoors = 5 then 'five doors'
	 
end
from VehicleDetails

 -- Problem 31: Get all Vehicle_Display_Name, year and add extra column to calculate the age of the car then sort the results by age desc.

select Vehicle_Display_Name, year , ( year(getdate()) - VehicleDetails.Year) as age  from VehicleDetails
order by age desc

--  Problem 32: Get all Vehicle_Display_Name, year, Age for vehicles that their age between 15 and 25 years old
select * from (
select Vehicle_Display_Name, year , ( year(getdate()) - VehicleDetails.Year) as age  from VehicleDetails
)  R1
where age between 15 and 25
order by age desc

--  Problem 33: Get Minimum Engine CC , Maximum Engine CC , and Average Engine CC of all Vehicles
select min(engine_cc) as minEngine,avg(engine_cc) as avgEngine, max(engine_cc) as maxEngine from VehicleDetails

--  Problem 34: Get all vehicles that have the minimum Engine_CC

select *  from VehicleDetails 
where Engine_CC = ( select min(engine_cc) from VehicleDetails)

--  Problem 35: Get all vehicles that have the Maximum Engine_CC
select * from VehicleDetails 
join (select max(engine_cc)as maxEng from VehicleDetails)as v on v.maxEng = VehicleDetails.Engine_CC 
--  Problem 36: Get all vehicles that have Engin_CC below average

select *  from VehicleDetails 
where Engine_CC < ( select avg(engine_cc) from VehicleDetails)

--  Problem 37: Get total vehicles that have Engin_CC above average

select count(*) as NumberOfVehiclesAboveAverageEngineCC  from VehicleDetails 
where Engine_CC > ( select avg(engine_cc) from VehicleDetails)

select Count(*) as NumberOfVehiclesAboveAverageEngineCC from
(
 
	Select ID,VehicleDetails.Vehicle_Display_Name from VehicleDetails
	where Engine_CC > ( select  Avg(Engine_CC) as MinEngineCC  from VehicleDetails )

) R1

--  Problem 38: Get all unique Engin_CC and sort them Desc
 select  distinct   Engine_CC from VehicleDetails
 order by Engine_CC desc
 --  Problem 39: Get top 3 unique Engin_CC and sort them Desc

select  distinct top 3  Engine_CC from VehicleDetails
order by Engine_CC desc

--  Problem 40: Get all vehicles that has one of the Max 3 Engine CC
select * from VehicleDetails
where Engine_CC in ( select distinct top 3  Engine_CC from VehicleDetails  order by Engine_CC desc)  
order by Engine_CC desc

--  Problem 41: Get all Makes that manufactures one of the Max 3 Engine CC
select distinct Makes.Make   from VehicleDetails
join Makes on makes.MakeID = VehicleDetails.MakeID
where Engine_CC in ( select distinct top 3  Engine_CC from VehicleDetails  order by Engine_CC desc)  
order by makes.Make 

--   Problem 42: Get a table of unique Engine_CC and calculate tax per Engine CC

select Engine_cc , tax = 
case 
	when Engine_cc between 0 and 1000 then 100
	when Engine_cc between 1001  and 2000 then 200
	else 0
end 
from (
select distinct Engine_cc from VehicleDetails 
)r1
order by Engine_cc

--   Problem 43: Get Make and Total Number Of Doors Manufactured Per Make
select Makes.make, sum(NumDoors ) as total from VehicleDetails
join Makes on Makes.MakeID = VehicleDetails.MakeID
group by Makes.make
Order By total desc 
--   Problem 44: Get Total Number Of Doors Manufactured by 'Ford'

select Makes.make, sum(NumDoors ) as total from VehicleDetails
join Makes on Makes.MakeID = VehicleDetails.MakeID
group by Makes.make
having Makes.Make ='ford'
Order By total desc 

--   Problem 45: Get Number of Models Per Make
 select Makes.make , count(MakeModels.ModelName) as NumModels from MakeModels
 join Makes on Makes.MakeID = MakeModels.MakeID
 group by Makes.make
 order by NumModels desc

 --  Problem 46: Get the highest 3 manufacturers that make the highest number of models
 select top 3 Makes.make , count(MakeModels.ModelName) as NumModels from MakeModels
 join Makes on Makes.MakeID = MakeModels.MakeID
 group by Makes.make
 order by NumModels desc
 
 --   Problem 47: Get the highest number of models manufactured
 select top 1  count(MakeModels.ModelName) as maxNumModels from MakeModels
 join Makes on Makes.MakeID = MakeModels.MakeID
  group by Makes.make
   order by maxNumModels desc
    
	select Max(NumberOfModels) as MaxNumberOfModels
from
(

		SELECT        Makes.Make, COUNT(*) AS NumberOfModels
		FROM            Makes INNER JOIN
								 MakeModels ON Makes.MakeID = MakeModels.MakeID
		GROUP BY Makes.Make
		
) R1

--  Problem 48: Get the highest Manufacturers manufactured the highest number of models 
 
  select Makes.make , count(*) as NumModels from Makes
  join MakeModels on MakeModels.MakeID = makes.MakeID
  group by Makes.make 
  having count(*) = 
 ( select max(NumModels) from (
 
  select Makes.make , count(*) as NumModels from Makes
  join MakeModels on MakeModels.MakeID = makes.MakeID
  group by Makes.make ) r )
