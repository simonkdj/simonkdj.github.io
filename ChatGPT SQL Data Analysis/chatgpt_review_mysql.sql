 SELECT * FROM dbo.clean_chatgpt_reviews

-- <DataVisualization 1>
--Finding the average, standard deviation, minimum value, maximum value, and the median of all 149719 of the scores.
SELECT  
    ROUND(AVG(TRY_CAST(score AS int)),2) AS average,
    ROUND(STDEV(TRY_CAST(score AS int)),2) AS stdev,
    ROUND(MIN(TRY_CAST(score AS int)),2) AS minval,
    ROUND(MAX(TRY_CAST(score AS int)),2) AS maxval,
    (SELECT TOP 1 score from
(
    SELECT TOP 50 PERCENT score 
    FROM dbo.clean_chatgpt_reviews 
    ORDER BY  score
)for_median
ORDER BY score DESC) AS median
FROM dbo.clean_chatgpt_reviews

--Find distribution of the scores, ordered in descending order by count. 5-4-1-3-2 was the order. 
SELECT score ,COUNT(*)
FROM dbo.clean_chatgpt_reviews
GROUP BY score
ORDER BY 2 DESC

--number of total reviews
SELECT COUNT(*) FROM dbo.clean_chatgpt_reviews

--It seems like most of the people do not care about leaving reviews as 144491 people did not leave any reviews out of 149719.
--That is about 96.5% of the people who did not care about leaving a review, making this column not significant. 

-- <Data Visualization 2>
SELECT thumbsUpCount, COUNT(*) AS count
FROM dbo.clean_chatgpt_reviews 
GROUP BY thumbsUpCount
ORDER BY 2 DESC

-- <Data Visualization 3>
-- change of score over time, since the January of 2023 to near June 2024. Created the table from CTE. 
WITH score_over_time AS (
    SELECT  
        TRY_CONVERT(datetime, at) AS converted_date , score   
    FROM dbo.clean_chatgpt_reviews
    WHERE TRY_CONVERT(datetime, at) IS NOT NULL 
)
SELECT * FROM score_over_time
ORDER BY converted_date 


--anaylsis on content or the comment column. 

--make all content lowercase
UPDATE dbo.clean_chatgpt_reviews
SET content = LOWER(content) 
SELECT content FROM dbo.clean_chatgpt_reviews

--only keeping English to facilitate data analysis and removed emojis. tested the modified content alongside its original content to see if cleaning was successful.
SELECT
    content,
    REPLACE(CAST(content as char(255)), '??', '' ) AS cleaned_content
FROM dbo.clean_chatgpt_reviews

--updated the table.
UPDATE dbo.clean_chatgpt_reviews
SET content = REPLACE(CAST(content as char(255)), '??', '' )
SELECT content FROM dbo.clean_chatgpt_reviews

--make sure the table consistent.
SELECT * FROM dbo.clean_chatgpt_reviews

-- Splitting the cleaned sentences in the content column with STRING_SPLIT and applying them to every column in the table.
CREATE TABLE #WordList (
    word NVARCHAR(255)
)
INSERT INTO #WordList (word)
SELECT value AS word
FROM dbo.clean_chatgpt_reviews
CROSS APPLY STRING_SPLIT(content, ' ')
WHERE value NOT IN ('', 'the', 'and', 'is', 'in', 'of', 'to')

-- <Data Visualization 4>
--created a table of all the words and their frequencies.
SELECT word, COUNT(*) AS frequency
FROM #WordList
GROUP BY word
ORDER BY frequency DESC