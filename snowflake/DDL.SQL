--OPEN DATA
CREATE DATABASE OPEN_DATA;
CREATE SCHEMA OPEN_DATA.NOAA;
USE DATABASE OPEN_DATA;
USE SCHEMA NOAA;


CREATE TABLE IF NOT EXISTS OPEN_DATA.NOAA.MAGNETOMETERS_7_DAYS_RAW (
    JSON_RAW VARIANT
);


CREATE TABLE OPEN_DATA.NOAA.MAGNETOMETERS_7_DAYS AS
SELECT
     elements.value:He AS He
    ,elements.value:Hn AS Hn
    ,elements.value:Hp AS Hp
    ,elements.value:arcjet_flag AS arcjet_flag
    ,elements.value:satellite AS satellite
    ,elements.value:time_tag AS time_tag
    ,elements.value:total AS total
FROM OPEN_DATA.NOAA.MAGNETOMETERS_7_DAYS_RAW
, LATERAL FLATTEN ( input => JSON_RAW ) elements
;


-- YOUTUBE --
CREATE DATABASE SOCIAL_MEDIAS;
CREATE SCHEMA SOCIAL_MEDIAS.YOUTUBE;

CREATE TABLE SOCIAL_MEDIAS.YOUTUBE.STATISTICS_RAW (
    RAW_FILE VARIANT
);

CREATE OR REPLACE TABLE SOCIAL_MEDIAS.YOUTUBE.STATISTICS AS
SELECT DISTINCT
     raw_file:id::int as id
    ,TO_TIMESTAMP(raw_file:createdAt) as createdAt
    ,raw_file:description::string as description
    ,raw_file:likeDislike.dislikes::INT as dislikes
    ,raw_file:likeDislike.likes::INT as likes
    ,raw_file:likeDislike.userAction::INT as userAction
    ,f.value:id::INT as multiMedia_id
FROM SOCIAL_MEDIAS.YOUTUBE.STATISTICS_RAW ,
table(flatten(raw_file:multiMedia)) f
;





