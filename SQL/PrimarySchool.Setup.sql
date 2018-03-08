if not exists(select * from sys.databases d where d.[name] = 'PrimarySchool')
begin
	create database PrimarySchool;
end;
GO

use PrimarySchool;
GO

if not exists(select * from sys.schemas s where s.[name] = 'ps')
begin
	exec('create schema ps;');
end;

if exists(select *
          from sys.tables t
			inner join sys.schemas s on s.[schema_id] = t.[schema_id]
          where t.[name] = 'tSchool' and s.[name] = 'ps')
begin
	drop table ps.tSchool;
end;

create table ps.tSchool
(
	EntityId  int not null identity(0, 1),
	FirstName nvarchar(32) null,
	LastName  nvarchar(32) null,
	BirthDate datetime2 null,
	ClassId   int null,
	ClassName nvarchar(8) null,
	[Level]   varchar(3) null,
	TeacherId int null,

	constraint PK_PS_tSchool primary key(EntityId),
	constraint CK_PS_tSchool_BirthDate check(BirthDate < getutcdate()),
	constraint FK_PS_tSchool_TeacherId foreign key(TeacherId) references ps.tSchool(EntityId)
);