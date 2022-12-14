CREATE TABLE restaurants (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    location VARCHAR(50) NOT NULL,
    price_range INT NOT NULL check(price_range >= 1 and price_range <=5)
);

-- fake restaurant create

INSERT INTO restaurants ( name,location, price_range) values ( 'mcdonalds', 'new york', 3);

INSERT INTO restaurants ( name,location, price_range) values ( 'pizza hut', 'vegas', 2);

-- create table reviews

CREATE TABLE reviews (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    restaurant_id BIGINT NOT NULL REFERENCES restaurants(id),
    name VARCHAR(50) NOT NULL,
    review TEXT NOT NULL,
    rating INT NOT NULL check(
        rating >= 1
        and rating <= 5
    )
);

-- fake review create

INSERT INTO reviews (restaurant_id, name,review, rating) values (8 ,'carl', 'restaurant was awesome', 5);

INSERT INTO reviews (restaurant_id, name,review, rating) values (5,'carl', 'restaurant was ugly', 1);

select *
from restaurants
    left join(
        select restaurant_id,
            count(*),
            TRUNC(AVG(rating, 1)) as average_rating
        from reviews
        group by restaurant_id
    ) reviews on restaurants.id = reviews.restaurant_id;