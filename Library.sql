create database Library
go
use Library
go
	create table Books(
	Id int identity primary key,
	[Name] Nvarchar(255) check (len([Name]) between 2 and 100) unique not null,
	[PageCount] int check ([PageCount] >=10)
);

	create table Authors(
	Id int identity primary key,
	[Name] Nvarchar(255) unique not null,
	[Surname] Nvarchar(255) unique not null,
);

	create table BookAuthors(
	Id int identity primary key,
	BookId int,
	AuthorId int,
	foreign key (BookId) references Books(Id),
	foreign key (AuthorId) references Authors(Id)
);


go

insert into Books (Name, PageCount) values 
('Life of Farid', 150),
('Life of Kamran', 200),
('Lifes of Farid and Kamran', 300);

insert into Authors (Name, Surname) values
('Kamran', 'Zeynalov'),
('Farid', 'Mursagulov'),
('FarKam', 'MursaZeynalov');

insert into BookAuthors (BookId, AuthorId) values
(1, 1),
(1, 2),
(1, 3),
(3, 1),
(2, 2),
(3, 2);

go

--///////////////////////////////////////////
--VIEW
create view BookAuthorInfo as
SELECT 
    B.Id as Id,
    B.Name as [Name],
    B.PageCount as PageCount,
    concat(A.Name, ' ', A.Surname) as AuthorFullName
from 
    Books B
join 
    BookAuthors BA on B.Id = BA.BookId
join 
    Authors A on BA.AuthorId = A.Id;

go
--///////////////////////////////////////////
--PROCEDURE
create procedure GetBooksByAuthorName
    @AuthorName nvarchar(255)
as
begin
    select
        B.Id as Id,
        B.Name as Name,
        B.PageCount as PageCount,
        concat(A.Name, ' ', A.Surname) as AuthorFullName
    from
        Books B
    join 
        BookAuthors BA on B.Id = BA.BookId
    join 
        Authors A on BA.AuthorId = A.Id
    where 
        A.Name = @AuthorName;
end;

go

--//////////////////////////
--INSERT
create procedure AddAuthor
    @Name nvarchar(255),
    @Surname nvarchar(255)
as
begin
    insert into Authors (Name, Surname) values (@Name, @Surname);
end;

go
--//////////////////////
--UPDATE
create procedure UpdateAuthor
    @AuthorId int,
    @Name nvarchar(255),
    @Surname nvarchar(255)
as
begin
    update Authors set Name = @Name, Surname = @Surname where Id = @AuthorId;
end;
--///////////////////
--DELETE
go
create procedure DeleteAuthor
    @AuthorId int
as
begin
    delete from Authors where Id = @AuthorId;
end;

go 
--/////////////////////////////////////
-- All VIEW
create view AuthorDetails as
select 
    A.Id as Id,
    concat(A.Name, ' ', A.Surname) as FullName,
    count(BA.BookId) as BooksCount,
    sum(B.PageCount) as OverallPageCount
from
    Authors A
left join
    BookAuthors BA on A.Id = BA.AuthorId
left join 
    Books B on BA.BookId = B.Id
group by 
    A.Id, A.Name, A.Surname;

go

	select * from BookAuthorInfo;
	exec GetBooksByAuthorName 'FarKam';
	EXEC AddAuthor 'Kamran', 'Zeynalov';
	EXEC UpdateAuthor 2, 'Fariidd', 'Mursaaa';
	EXEC DeleteAuthor 1;
	SELECT * FROM AuthorDetails;









