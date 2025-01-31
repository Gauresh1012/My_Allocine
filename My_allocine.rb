# Movies Database SQL Documentation

## Database Setup
```sql
-- Create Database
CREATE DATABASE movies;

-- Use Database
USE movie;
```

## Query Examples

### Movie Search Queries

#### Find American Beauty Release Year
```sql
SELECT mov_title, mov_year 
FROM movies 
WHERE mov_title = 'American Beauty';
```

#### Find Movies Released in 1999
```sql
SELECT mov_title, mov_year 
FROM movies 
WHERE mov_year = 1999;
```

#### Find Movies Before 1998
```sql
SELECT mov_title, mov_year 
FROM movies 
WHERE mov_year < 1998;
```

### Rating and Review Queries

#### Find High-Rating Reviewers
```sql
SELECT r.rev_name, mrr.rev_stars 
FROM reviews r 
JOIN movies_rating_reviews mrr ON r.id = mrr.rev_id 
WHERE rev_stars > 7 
ORDER BY 1 ASC;
```

### Movie ID Queries

#### Find Movies by Specific IDs
```sql
SELECT id, mov_title 
FROM movies 
WHERE id = '905' OR id = '907' OR id = '917';
```

#### Find Movies Containing "Boogie Nights"
```sql
SELECT id, mov_title, mov_year 
FROM movies 
WHERE mov_title LIKE '%Boogie Nights%';
```

### Actor Queries

#### Find Actor by Name
```sql
SELECT id 
FROM actor 
WHERE act_fname LIKE '%woody';
```

#### Find Actors in "Annie Hall"
```sql
SELECT actor.id, act_fname 
FROM actor, movies_actors, movies 
WHERE mov_title = 'Annie Hall';
```

#### Find Actor Roles in "Annie Hall"
```sql
SELECT act_fname, act_lname, role 
FROM movies, movies_actors, actor 
WHERE movies.mov_title = 'Annie Hall' 
  AND movies_actors.act_id = actor.id 
  AND movies_actors.mov_id = movies.id;
```

### Director Queries

#### Find Director of "Sean Maguire" Role
```sql
SELECT m.mov_title, d.dir_fname, d.dir_lname, role 
FROM movies m 
JOIN director_movies dm ON m.id = dm.mov_id 
JOIN directors d ON dm.dir_id = d.id 
JOIN movies_actors ma ON m.id = ma.mov_id 
WHERE role = 'Sean Maguire';
```

### Complex Queries

#### Find Actors Not Active Between 1990-2000
```sql
SELECT act_fname, act_lname, mov_title, 
       EXTRACT(Year FROM mov_dt_rel) as release_year 
FROM actor a 
JOIN movies_actors ma ON a.id = ma.act_id 
JOIN movies m ON ma.mov_id = m.id 
HAVING release_year NOT BETWEEN 1990 AND 2000;
```
