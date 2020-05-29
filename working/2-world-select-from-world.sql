/*
Second section of sqlzoo, SELECT FROM country
*/


--#1
/*
Read the notes about this table. Observe the result of running a simple SQL command.
*/
SELECT name, continent, population
FROM country

--#2
/*
How to use WHERE to filter records.
Show the name for the countries that have a population of at least 200 million. 200 million is 200000000, there are eight zeros.
*/
SELECT name
FROM country
WHERE population>=200000000

--#3
/*
Give the name and the per capita GNP for those countries with a population of at least 200 million.
*/
SELECT name, gnp/population
FROM country
WHERE population >= 200000000

--#4
/*
Show the name and population in millions for the countries of the continent 'South America'. Divide the population by 1000000 to get population in millions.
*/
SELECT name, population/1000000
FROM country
WHERE continent = 'South America'

--#5
/*
Show the name and population for France, Germany, Italy
*/
SELECT name, population
FROM country
WHERE name in ('France', 'Germany', 'Italy')

--#6
/*
Show the countries which have a name that includes the word 'United'
*/
SELECT name
FROM country
WHERE name LIKE '%united%'

--#7
/*
Two ways to be big: A country is big if it has an area of more than 3 million sq km or it has a population of more than 250 million.

Show the countries that are big by area or big by population. Show name, population and area.
*/
SELECT name, population, surfacearea
FROM country
WHERE surfacearea > 3000000 OR population > 250000000

--#8
/*
USA and China are big in population and big by area. Exclude these countries.

Show the countries that are big by area or big by population but not both. Show name, population and area.
*/
SELECT name, population, surfacearea
FROM country
WHERE (surfacearea > 3000000 AND population < 250000000)
  OR (surfacearea < 3000000 and population > 250000000)

--#9
/*
Show the name, population, and GNP for the countries of the continent 'South America'. Use the ROUND function to show the values to the nearest 1000s.

*/
SELECT name, ROUND(population,-3), ROUND(gnp, -3)
FROM country
WHERE continent = 'South America'

--#10
/*
Show the per-capita GNP for those countries with a GNP of at least one trillion (1000000000000; that is 12 zeros). Round this value to the nearest 1000.

Show per-capita GNP for the trillion dollar countries to the nearest $1000.
*/
SELECT name, ROUND(gnp/population, -3)
FROM country
WHERE gnp > 1000000000000

--#11
/*
The CASE statement shown is used to substitute North America for Caribbean in the third column.

Show the name and the continent - but substitute Australasia for Oceania - for countries beginning with N.
*/
SELECT name, continent,
       CASE WHEN continent='Caribbean' THEN 'North America'
            ELSE continent END
FROM country
WHERE name LIKE 'J%'

--#12
/*
Show the name and the continent - but substitute Eurasia for Europe and Asia; substitute America - for each country in North America or South America or Caribbean.
Show only countries beginning with A or B
*/
SELECT name,
CASE WHEN continent = 'Europe' OR continent = 'Asia' THEN 'Eurasia'
      WHEN continent LIKE '%america%' OR continent = 'Caribbean' THEN 'America'
      ELSE continent END
FROM country
WHERE name LIKE 'a%' or name LIKE 'b%'

--#13
/*
Put the continents right...

Oceania becomes Australasia
Countries in Eurasia and Turkey go to Europe/Asia
Caribbean islands starting with 'B' go to North America, other Caribbean islands go to South America
Show the name, the original continent and the new continent of all countries.
*/
SELECT name, continent,
CASE WHEN continent = 'Oceania' THEN 'Australasia'
     WHEN continent = 'Eurasia' OR name = 'Turkey' THEN 'Europe/Asia'
     WHEN continent = 'Caribbean' AND name LIKE 'b%' THEN 'North America'
     WHEN continent = 'Caribbean' AND name NOT LIKE 'b%' THEN 'South America'
     ELSE continent END
FROM country
ORDER BY name
