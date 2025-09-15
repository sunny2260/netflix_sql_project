-- Netflix Data Analysis Project

CREATE TABLE netflix (
	show_id	varchar(7),
	type varchar(10),	
	title varchar(150),
	director varchar(250),	
	casts varchar(800),
	country	varchar(150),
	date_added varchar(50),
	release_year int,
	rating varchar(10),
	duration varchar(15),
	listed_in varchar(100),
	description varchar(275) 
)

SELECT * FROM netflix

/* Counting total records */
SELECT count(*) as Total_Records FROM netflix

/* Distinct Types of Content on Netflix */
SELECT distinct(type) from netflix