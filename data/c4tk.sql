CREATE DATABASE bible;
USE bible;

CREATE TABLE test_table
AS (
	SELECT
		1 AS a,
        2 AS b
	)
;
-- SELECT * FROM test_table;

-- ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'margins';
-- SHOW VARIABLES LIKE "secure_file_priv";

CREATE TABLE IF NOT EXISTS books (
    book VARCHAR(50),
    chapters INTEGER,
    testament CHAR(3)
);
LOAD DATA
    INFILE '/Users/sethdimick/Documents/Personal_Projects/my_bible_stats/my-bible-stats/data/books.csv'
    INTO TABLE books
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES
;
-- SELECT * FROM books;

CREATE TABLE IF NOT EXISTS chapters (
    book VARCHAR(50),
    chapter INTEGER,
    testament CHAR(3)
);
LOAD DATA
    INFILE '/Users/sethdimick/Documents/Personal_Projects/my_bible_stats/my-bible-stats/data/chapters.csv'
    INTO TABLE chapters
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES
;
-- SELECT * FROM chapters;

-- Get chapters for navigation after book click
SELECT chapter
FROM chapters
WHERE book = 'Genesis' -- Make dynamic on book selecttion
ORDER BY chapter;

-- CREATE TABLES FOR STATS

DROP TABLE IF EXISTS book_stats;
CREATE TABLE book_stats (
	userid VARCHAR(50),
	book VARCHAR(50),
    chapters INTEGER,
    views FLOAT,
    norm_views FLOAT
);

DROP TABLE IF EXISTS chapter_stats;
CREATE TABLE chapter_stats (
	userid VARCHAR(50),
	book VARCHAR(50),
    chapter INTEGER,
    views FLOAT
);

CREATE TABLE view_logs (
	userid VARCHAR(50),
	book VARCHAR(50),
    chapter INTEGER,
    tstamp DATETIME
);

LOAD DATA
    INFILE '/Users/sethdimick/Documents/Personal_Projects/my_bible_stats/my-bible-stats/data/views.csv'
    INTO TABLE view_logs
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES
;

CREATE TABLE users (
	userid VARCHAR(50),
    parent_group VARCHAR(50)
);

INSERT INTO users (
	SELECT 'user1' AS userid, 'group1' AS parent_group
    UNION ALL
    SELECT 'user2' AS userid, 'group1' AS parent_group
    UNION ALL
    SELECT 'user3' AS userid, 'group1' AS parent_group
    UNION ALL
    SELECT 'group1' AS userid, NULL AS parent_group
);
-- SELECT * FROM users;

-- Truncate stat tables and update from view logs
TRUNCATE TABLE chapter_stats;
INSERT INTO chapter_stats (
	SELECT
		u.userid,
		c.book,
		c.chapter,
		COUNT(v.tstamp) AS views
	FROM
		users AS u
		CROSS JOIN chapters AS c
		LEFT JOIN view_logs AS v
			ON u.userid = v.userid
			AND c.book = v.book
			AND c.chapter = v.chapter
	WHERE
		u.userid LIKE 'user%'
	GROUP BY
		u.userid,
		c.book,
		c.chapter
);
INSERT INTO chapter_stats (
	SELECT
		u.parent_group AS userid,
		c.book,
		c.chapter,
		COUNT(v.tstamp) / COUNT(DISTINCT u.userid) AS views
	FROM
		users AS u
		CROSS JOIN chapters AS c
		LEFT JOIN view_logs AS v
			ON u.userid = v.userid
			AND c.book = v.book
			AND c.chapter = v.chapter
	WHERE
		u.parent_group IS NOT NULL
	GROUP BY
		u.parent_group,
		c.book,
		c.chapter
);

TRUNCATE TABLE book_stats;
INSERT INTO book_stats (
	SELECT
		cs.userid,
		b.book,
		b.chapters,
		SUM(cs.views) AS views,
		SUM(cs.views) / b.chapters AS norm_views
	FROM
		books AS b
		INNER JOIN chapter_stats as cs
			ON b.book = cs.book
	GROUP BY
		cs.userid,
		b.book,
		b.chapters
);
-- SELECT * FROM book_stats LIMIT 100;


-- Update chapter stats based on views
