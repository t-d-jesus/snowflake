--OPEN DATA--
SELECT $1
FROM @OPEN_DATA.NOAA.NOAA_STAGE/json/goes/primary/magnetometers-7-day.json;

SELECT * FROM MAGNETOMETERS_7_DAYS_RAW;

SELECT * FROM OPEN_DATA.NOAA.MAGNETOMETERS_7_DAYS_RAW;

SELECT JSON_RAW[0] FROM OPEN_DATA.NOAA.MAGNETOMETERS_7_DAYS_RAW;

SELECT elements.value, elements.seq FROM OPEN_DATA.NOAA.MAGNETOMETERS_7_DAYS_RAW
, LATERAL FLATTEN ( input => JSON_RAW ) elements
;


-- YOUTUBE --
SELECT * FROM SOCIAL_MEDIAS.YOUTUBE.STATISTICS_RAW;

TRUNCATE TABLE SOCIAL_MEDIAS.YOUTUBE.STATISTICS_RAW;

SELECT COUNT(*) FROM SOCIAL_MEDIAS.YOUTUBE.STATISTICS;

TRUNCATE TABLE SOCIAL_MEDIAS.YOUTUBE.STATISTICS;

SELECT 
     distinct $1:id::int as id,
    array_size(RAW_FILE:multiMedia) as size
FROM SOCIAL_MEDIAS.YOUTUBE.STATISTICS_RAW;


SELECT DISTINCT
     raw_file:id::int as id
    ,raw_file:createdAt as createdAt
    ,raw_file:description::string as description
    ,raw_file:likeDislike.dislikes as dislikes
    ,raw_file:likeDislike.likes as likes
    ,raw_file:likeDislike.userAction as userAction
    ,f.value:id as multiMedia_id
FROM SOCIAL_MEDIAS.YOUTUBE.STATISTICS_RAW ,
table(flatten(raw_file:multiMedia)) f
;


SELECT DISTINCT
     $1:id::int as id
    ,$1:createdAt as createdAt
    ,$1:description::string as description
    ,$1:likeDislike.dislikes as dislikes
    ,$1:likeDislike.likes as likes
    ,$1:likeDislike.userAction as userAction
    ,$1:multiMedia[0].name::string as name
FROM SOCIAL_MEDIAS.YOUTUBE.STATISTICS_RAW
ORDER BY id DESC


SELECT DISTINCT
     $1:id::int as id
    ,$1:createdAt as createdAt
    ,$1:description::string as description
    ,$1:likeDislike.dislikes as dislikes
    ,$1:likeDislike.likes as likes
    ,$1:likeDislike.userAction as userAction
    ,$1:multiMedia[0].name::string as name
FROM SOCIAL_MEDIAS.YOUTUBE.STATISTICS_RAW
where $1:id::int = 1066
union all
SELECT DISTINCT
     $1:id::int as id
    ,$1:createdAt as createdAt
    ,$1:description::string as description
    ,$1:likeDislike.dislikes as dislikes
    ,$1:likeDislike.likes as likes
    ,$1:likeDislike.userAction as userAction
    ,$1:multiMedia[1].name::string as name
FROM SOCIAL_MEDIAS.YOUTUBE.STATISTICS_RAW
where $1:id::int = 1066
;

