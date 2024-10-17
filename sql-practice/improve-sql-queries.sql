cd sql-practice
sqlite3
.open practice.db
.databases
.mode box
----------
-- Step 0 - Create a Query 
----------
-- Query: Select all cats that have a toy with an id of 5

    -- Your code here 
SELECT * FROM cats WHERE id = 5;

-- Paste your results below (as a comment):
┌────┬─────────┬───────┬───────┐
│ id │  name   │ color │ breed │
├────┼─────────┼───────┼───────┤
│ 5  │ Carlene │ Olive │ Asian │
└────┴─────────┴───────┴───────┘



----------
-- Step 1 - Analyze the Query
----------
-- Query:

    -- Your code here 
EXPLAIN QUERY PLAN SELECT name FROM cats LIMIT 10;
-- Paste your results below (as a comment):
QUERY PLAN
--SCAN cats

-- What do your results mean?

    -- Was this a SEARCH or SCAN?

SCAN

    -- What does that mean?

If you see the SCAN keyword, that means that SQL is going through
each row in the table and determining if it should be added to
the results of the query.


----------
-- Step 2 - Time the Query to get a baseline
----------
-- Query (to be used in the sqlite CLI):

    -- Your code here 
.timer on
SELECT name FROM cats WHERE name = 'Jet';;
-- Paste your results below (as a comment):
┌──────┐
│ name │
├──────┤
│ Jet  │
└──────┘
Run Time: real 0.003 user 0.001128 sys 0.000514

EXPLAIN QUERY PLAN SELECT name FROM cats WHERE name = 'Jet';
QUERY PLAN
--SCAN cats
Run Time: real 0.000 user 0.000099 sys 0.000013

----------
-- Step 3 - Add an index and analyze how the query is executing
----------

-- Create index:

    -- Your code here 
CREATE INDEX idx_cat_name ON cats(name);
Run Time: real 0.010 user 0.007109 sys 0.002424
-- Analyze Query:
    -- Your code here 
    .index
    idx_cat_name
EXPLAIN QUERY PLAN SELECT name FROM cats WHERE name = 'Jet';

-- Paste your results below (as a comment):
QUERY PLAN
--SEARCH cats USING COVERING INDEX idx_cat_name (name=?)
Run Time: real 0.000 user 0.000126 sys 0.000025

-- Analyze Results:

    -- Is the new index being applied in this query?
yes



----------
-- Step 4 - Re-time the query using the new index
----------
-- Query (to be used in the sqlite CLI):

    -- Your code here 
sqlite> SELECT name FROM cats WHERE name = 'Jet';
┌──────┐
│ name │
├──────┤
│ Jet  │
└──────┘
Run Time: real 0.000 user 0.000150 sys 0.000205

-- Analyze Results:
    -- Are you still getting the correct query results?
Run Time: real 0.003 user 0.001128 sys 0.000514
yes

    -- Did the execution time improve (decrease)?
improve

    -- Do you see any other opportunities for making this query more efficient?


---------------------------------
-- Notes From Further Exploration
---------------------------------
