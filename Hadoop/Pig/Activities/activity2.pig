-- Load the input file
inputFile = LOAD 'hdfs:///user/Akhila/input.txt' AS (line);
-- Tokeize the line into words
words = FOREACH inputFile GENERATE FLATTEN(TOKENIZE(line)) AS word;
-- Group the words (MAP)
grpd = GROUP words BY word;
-- Count the total number of words
totalCount = FOREACH grpd GENERATE group, COUNT($1) AS no_of_words;

--to remove old output
rmf hdfs:///user/Akhila/pigOutput1;
-- Store the result in HDFS
STORE totalCount INTO 'hdfs:///user/Akhila/pigOutput';
