use movie_snowflake;

-- -----------------------------------------------------
-- Table `movie_snowflake`.`dim_time`
-- -----------------------------------------------------

insert into dim_time (date_id, year)
select release_date, right(release_date,4) 
from movie.movie
group by release_date;


-- -----------------------------------------------------
-- Table `movie_snowflake`.`dim_genre`
-- -----------------------------------------------------

insert into dim_genre (genre_id, genre_name)
select genre_id, genre_name
from movie.genre;

-- -----------------------------------------------------
-- Table `movie_snowflake`.`dim_production_country`
-- -----------------------------------------------------

insert into dim_production_country (production_country_code, production_country_name)
select production_country_code, production_country_name
from movie.production_country;



-- -----------------------------------------------------
-- Table `movie_snowflake`.`dim_movie`
-- -----------------------------------------------------


INSERT INTO dim_movie (    
    movie_id,
    title,
    original_language,
    status,
    revenue,
    budget,
    release_date,
    runtime, 
    popularity,
    vote_average,
    vote_count,
    count_production_company,
    count_production_country,
    count_genre,
    count_cast,
	count_spoken_language
    )
(SELECT 
    mm.movie_id,
    title,
    original_language,
    status,
    revenue,
    budget,
    release_date,
    runtime, 
    popularity,
    vote_average,
    vote_count,
	count(distinct production_co_id),
    count(distinct production_country_code),
    count(distinct genre_id),
    count(distinct cast_id),
    count(distinct language_code)
FROM
    movie.movie mm
    left join movie.movie_production_company mmpco on mmpco.movie_id = mm.movie_id
    left join movie.movie_production_country mmpc on mmpc.movie_id = mm.movie_id
    left join movie.movie_genre mmg on mmg.movie_id = mm.movie_id
    left join movie.movie_cast mmc on mmc.movie_id = mm.movie_id
    left join movie.movie_spoken_language mmsl on mmsl.movie_id = mm.movie_id
GROUP BY mm.movie_id
);

-- -----------------------------------------------------
-- Table `movie_snowflake`.`dim_imdb`
-- -----------------------------------------------------

insert into dim_imdb (imdb_id, movie_id)
select imdb_id, movie_id
from movie.imdb;


-- -----------------------------------------------------
-- Table `movie_snowflake`.`dim_fact`
-- -----------------------------------------------------

INSERT INTO fact (
    rating_id,
    imdb_id,
    production_country_code,
    genre_id,
    release_date,
    rating,
    user_id
)
(SELECT    
	distinct mr.rating_id,
    di.imdb_id,
    dpc.production_country_code,
    dg.genre_id,
    mm.release_date,
    mr.rating,
    mr.user_id
FROM
    movie.rating as mr
    inner join dim_imdb di on di.imdb_id = mr.imdb_id
    inner join movie.movie mm on mm.movie_id = di.movie_id
    inner join dim_production_country dpc on dpc.production_country_code = mm.major_production_country
    inner join dim_genre dg on dg.genre_id = mm.major_genre);







