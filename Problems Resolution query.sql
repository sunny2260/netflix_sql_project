/* Data Analysis on Netflix DATABASE */

-- Q1. Count the number of Movies vs TV Shows 
SELECT 
	type as CONTENT_TYPE,
	count(*) as TOTAL_RECORDS
from netflix
GROUP BY type


-- Q2. Find the most common rating for movies and TV shows 
SELECT
	type,
	rating as max_rating
FROM
(	SELECT
		type,
		rating,
		count(*),
		RANK() OVER(PARTITION BY type ORDER BY count(*) DESC) AS RANKING 
	FROM netflix
	GROUP BY 1,2
)
as t1
WHERE ranking = 1


-- Q3. List all movies released in a specific year (e.g., 2020)
SELECT * from netflix
WHERE 
	release_year = 2020 
	AND 
	type = 'Movie'


-- Q4. Find the top 5 countries with the most content on Netflix
SELECT 
	UNNEST(STRING_TO_ARRAY(country, ',')) as new_country,
	COUNT(show_id) as total_content
FROM netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5


-- Q5. Identify the longest movie
SELECT  
	title, director, release_year, duration,listed_in, rating
from netflix
WHERE 
	type = 'Movie'
	AND
	duration = (SELECT MAX(duration) from netflix)


-- Q6. Find content added in the last 5 years
select 
	*
from netflix
where
	TO_DATE(date_added, 'Month DD,YYYY') >= CURRENT_DATE - INTERVAL '5 years' 


-- Q7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
select * from netflix
where director ilike '%Rajiv Chilaka%'


--Q8. List all TV shows with more than 5 seasons
select
	title,
	duration
from netflix
where 
	type = 'TV Show'
	and
	SPLIT_PART(duration, ' ', 1)::numeric >= 5 
order by 2 desc


-- Q9. Count the number of content items in each genre
SELECT 
	UNNEST(STRING_TO_ARRAY(listed_in, ',')) as new_genre,
	COUNT(*) as Total_Content
FROM netflix
GROUP BY 1
ORDER BY 2 DESC


/* Q10. Find each year and the average numbers of content release in India on netflix. 
		return top 5 year with highest avg content release! */
SELECT
	EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) as new_date,
	count(show_id) as content_yearly,
	ROUND(count(show_id)::numeric/(SELECT count(*) from netflix WHERE country = 'India')::numeric * 100, 2) 
	as avg_content_yearly
FROM netflix
WHERE country = 'India'
GROUP BY 1
ORDER BY 2 DESC

-- Q11. List all movies that are documentaries
SELECT * FROM netflix 
WHERE listed_in ILIKE '%documentaries%'

-- Q12. Find all content without a director
select * from netflix
where director is null

-- Q13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
select * from netflix
where 
	casts ILIKE '%Salman Khan%'
	AND
	release_year = EXTRACT(YEAR FROM CURRENT_DATE) - 10

-- Q14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
select 
	UNNEST(STRING_TO_ARRAY(casts,',')) as actors,
	count(*) as TOTAL_CONTENTS
from netflix
where country ILIKE '%India%'
GROUP BY 1
ORDER By 2 Desc
LIMIT 10

/* Q15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
		the description field. Label content containing these keywords as 'Bad' and all other 
		content as 'Good'. Count how many items fall into each category. */
WITH categorized_table
AS
(
SELECT 
	*,
	CASE
	WHEN 
		description ILIKE '%kill%' OR
		description ILIKE '%violence%' OR 
		description ILIKE '%murder%' 
		THEN 'Bad_Influence'
		ELSE 'Neutral_Content'
	END category
FROM netflix
)
SELECT 
	category,
	count(*) as total_content
FROM categorized_table
GROUP BY 1
	
		







	



 








	
	