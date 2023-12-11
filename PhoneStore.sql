create database FaridBase
go
use FaridBase

go

	create table Brands(
	Id int identity primary key,
	[Name] nvarchar(255) unique not null,
);

create table Laptops (
    Id int identity primary key,
    Name nvarchar(255) unique not null,
	Price decimal(10,2),
    BrandId int,
    foreign key (BrandId) references Brands(Id)
);

create table Phones (
    Id int identity primary key,
    Name nvarchar(255) unique not null,
	Price decimal(10,2),
    BrandId int,
    foreign key (BrandId) references Brands(Id)
);


go
insert into Brands 
values
('Samsung'),
('IOS'),
('Lenovo'),
('MSI'),
('Acer');

insert into Phones 
values
('A33', 200, 1),
('Iphone 11', 500, 2),
('Redmi', 1000, 1),
('Iphone SE', 320, 2),
('Xiaomi', 120, 1);

insert into Laptops 
values
('ThinkPad', 7000, 3),
('Macos', 1050, 2),
('F220', 2500, 5),
('Gaming', 3020, 4),
('Hp', 120, 1);

go
--////////////////////////////////
--QUERY
--3
select 
L.Name as LaptopName, 
B.Name as Brandname,
L.Price
from Laptops L
join Brands B on L.BrandId = B.Id

--4
select 
P.Name as PhoneName, 
B.Name as Brandname,
P.Price
from Phones P
join Brands B on P.BrandId = B.Id;

--5
select	* from Brands
where [Name] like '%s%';

--6
select * from Laptops
where Price between 2000 and 5000 or Price > 5000;

--7
select * from Phones
where Price between 1000 and 1500 or Price > 1500;

--8
select B.Name as BrandName, Count(L.BrandId) as LaptopCount 
from Brands B
left join Laptops L on B.Id =L.BrandId
group by
B.Name;

--9
select B.Name as BrandName, Count(P.BrandId) as PhoneCount 
from Brands B
left join Phones P on B.Id =P.BrandId
group by
B.Name;

--10
select Name, BrandId from Phones
union
select Name, BrandId from Laptops

--11
select Id, Name,Price,BrandId from Phones
union all
select Id, Name,Price,BrandId from Laptops

--12
select 
    P.Id,
    P.Name,
    P.Price,
    BP.Name as BrandName
from 
    Phones P
join
    Brands BP on P.BrandId = BP.Id

union all

select
    L.Id as LaptopId,
    L.Name as LaptopName,
    L.Price,
    BL.Name as BrandName
from
    Laptops L
join 
    Brands BL on L.BrandId = BL.Id;

--13
select
    Id,
    Name,
    Price,
    BrandName
from (
    select
        P.Id,
        P.Name,
        P.Price,
        BP.Name as BrandName
    from 
        Phones P
    join 
        Brands BP on P.BrandId = BP.Id

    union all

	select
        L.Id as Id,
        L.Name as Name,
        L.Price,
        BL.Name as BrandName
    from
        Laptops L
    join 
        Brands BL on L.BrandId = BL.Id
) as CombinedData
where Price > 1000;

--14
select
    B.Name as BrandName,
    sum(P.Price) as TotalPrice,
    count(P.Id) as ProductCount
from 
    Brands B
join 
    Phones P on B.Id = P.BrandId
group by 
    B.Name;

--15
select
    B.Name as BrandName,
    sum(L.Price) as TotalPrice,
    count(L.Id) as LaptopCount
from 
    Brands B
join 
    Laptops L on B.Id = L.BrandId
group by 
    B.Name
having 
	Count(L.Id) >= 3;




