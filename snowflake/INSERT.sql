-- YOUTUBE --
INSERT INTO SOCIAL_MEDIAS.YOUTUBE.STATISTICS
SELECT DISTINCT
     raw_file:id::int as id
    ,TO_TIMESTAMP(raw_file:createdAt) as createdAt
    ,raw_file:description::string as description
    ,raw_file:likeDislike.dislikes::INT as dislikes
    ,raw_file:likeDislike.likes::INT as likes
    ,raw_file:likeDislike.userAction::INT as userAction
    ,f.value:id::INT as multiMedia_id
FROM SOCIAL_MEDIAS.YOUTUBE.STATISTICS_RAW ,
table(flatten(raw_file:multiMedia)) f;

