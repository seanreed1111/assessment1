```sql
CREATE TABLE city (
    id integer NOT NULL,
    name text NOT NULL,
    countrycode character(3) NOT NULL,
    district text NOT NULL,
    population integer NOT NULL
);
```

```sql
CREATE TABLE country (
    code character(3) NOT NULL,
    name text NOT NULL,
    continent text NOT NULL,
    region text NOT NULL,
    surfacearea real NOT NULL,
    indepyear smallint,
    population integer NOT NULL,
    lifeexpectancy real,
    gnp numeric(10,2),
    gnpold numeric(10,2),
    localname text NOT NULL,
    governmentform text NOT NULL,
    headofstate text,
    capital integer,
    code2 character(2) NOT NULL,
    CONSTRAINT country_continent_check CHECK ((((((((continent = 'Asia'::text) OR (continent = 'Europe'::text)) OR (continent = 'North America'::text)) OR (continent = 'Africa'::text)) OR (continent = 'Oceania'::text)) OR (continent = 'Antarctica'::text)) OR (continent = 'South America'::text)))
);
```

```sql
CREATE TABLE countrylanguage (
    countrycode character(3) NOT NULL,
    lang text NOT NULL,
    isofficial boolean NOT NULL,
    percentage real NOT NULL
);
```


* Show the names of countries, their populations and the sum of the inhabitants of the cities of these countries, but only those countries for which this sum is less than 3/4 of the population of the country.

```
mysql> SELECT k.name, k.population,
    -> SUM(m.population) 
    -> FROM city m, country k
    -> WHERE k.code = m.countrycode
    -> GROUP BY 1
    -> HAVING SUM(m.population) > 0.75 * k.population;
```

* List how many forms of government (GovermentForm) there are in North America

```
mysql> SELECT COUNT(DISTINCT(GovernmentForm))
    -> FROM country
    -> WHERE continent = "North America";
```

* List countries and their capitals. The name of the country is to begin with the same letter. The name of capitals too (not necessarily in the country and capital letters must be the same). We are also interested in countries without capital (in this case, we omit the condition for the extreme letters of the capital.


```
mysql> SELECT k.name, m.name
    -> FROM country k LEFT JOIN city m
    -> ON k.capital = m.id
    -> WHERE LEFT(k.name, 1) = RIGHT(k.name, 1)
    -> AND (
    -> k.capital IS NULL
    -> OR (LEFT(m.name, 1) = RIGHT(m.name, 1))
    -> );
```

* List the names of the countries, the names of their capitals, populations of capitals. The area of the country is to be larger than the average area of South America and the population of capitals smaller than the population of the largest population of the city with code (its country) starting with the letter V and ending with the letter M

```
mysql> SELECT country.name, city.name, city.population
    -> FROM city, country
    -> WHERE country.capital = city.id
    -> AND country.surfacearea > (
    ->     SELECT AVG(k.surfacearea)
    ->     FROM country k
    ->     WHERE k.continent = "South America"
    -> )
    -> AND city.population < (
    ->     SELECT MAX(m.population)
    ->     FROM city m
    ->     WHERE m.countrycode LIKE "V%" AND m.countrycode LIKE "%M"
    -> );
```

* List the city and the continent on which it lies. The population of this city should be more than half of the average population of countries on the same continent as cities that are listed.

```
mysql> SELECT m.name, k.continent
    -> FROM city m, country k
    -> WHERE k.code = m.countrycode
    -> AND m.population > 0.5 * (
    -> SELECT AVG(kk.surfacearea
    -> FROM country kk
    ->  WHERE k.continent = kk.continent
    -> );
```

* List the countries and the number of their official languages, which is to be more than the length of the name of the shortest African city.

```
mysql> SELECT country.name kraj, COUNT(*) 
    -> FROM country, countrylanguage
    -> WHERE code = countrycode
    -> GROUP BY countrycode
    -> HAVING jezykow > (
    ->  SELECT MIN(LENGTH(kk.name))
    ->  FROM country kk
    ->  WHERE kk.continent = "Africa"
    -> );
```
* Show the name of the country and its population, which is to be equal to the population of a city with three letters in the name

```
mysql> SELECT k.name, k.population
    -> FROM country k
    -> WHERE k.population IN (
    ->  SELECT m.population
    ->  FROM city m
    ->  WHERE m.name REGEXP '^.*a.*a.*a.*$'
    -> );
```

* List the languages spoken on each of the inhabited continents.

```
mysql> SELECT continent, COUNT(language)
    -> FROM country, countrylanguage
    -> WHERE code = countrycode
    -> GROUP BY continent;
```





# !challenge

* type: code-snippet
* language: sql
* id: 65cd1e1e-6d5d-11ea-901a-60f81dc9f21e
* title: SELECT queries
* data_path: /DATA/sqlzoo.sql


##### !question
How many cities in China are in the database?
##### !end-question

##### !placeholder

```sql

```

##### !end-placeholder


##### !tests
SELECT COUNT(*) FROM city
WHERE countrycode = "CHN";
##### !end-tests

### !hint

### !end-hint

#### !explanation
```sql
SELECT COUNT(*) FROM city
WHERE countrycode = "CHN";
```
#### !end-explanation

# !end-challenge

# !challenge

* type: code-snippet
* language: sql
* id: 65cd1e86-6d5d-11ea-91be-60f81dc9f21e
* title: SELECT queries
* data_path: /DATA/sqlzoo.sql


##### !question
List all the languages spoken in the ‘Caribbean’ region.
##### !end-question

##### !placeholder

```sql

```

##### !end-placeholder


##### !tests
SELECT country.region, countrylanguage.lang
FROM country
LEFT JOIN countrylanguage 
ON country.code = countrylanguage.countrycode
WHERE country.region = "Caribbean"
##### !end-tests

### !hint

### !end-hint

#### !explanation
```sql
SELECT 
    country.region, 
    countrylanguage.lang
FROM country
LEFT JOIN countrylanguage 
ON country.code = countrylanguage.countrycode
WHERE country.region = "Caribbean";
```
#### !end-explanation

# !end-challenge