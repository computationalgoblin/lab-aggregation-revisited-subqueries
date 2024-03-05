-- Select the first name, last name, and email address of all the customers who have rented a movie.
select c.first_name, c.last_name, c.email from customer as c
join rental as r
on c.customer_id = r.customer_id
group by c.customer_id;

-- What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
select c.customer_id, concat(c.first_name, ' ', c.last_name) as `name`, avg(p.amount) as `avg_payment` from customer as c
join rental as r
on c.customer_id = r.customer_id
join payment as p
on r.customer_id = p.customer_id
group by r.customer_id, `name`;

-- Select the name and email address of all the customers who have rented the "Action" movies.
-- a: Write the query using multiple join statements
select c.first_name, c.last_name, c.email from customer as c
join rental as r
on c.customer_id = r.customer_id
join inventory as i
on r.inventory_id = i.inventory_id
join film_category as fa
on i.film_id = fa.film_id
where fa.category_id = 1
group by c.customer_id;

-- b: Write the query using sub queries with multiple WHERE clause and IN condition

select first_name, last_name, email
from customer
where customer_id in (
    select distinct r.customer_id
    from rental as r
    where inventory_id in (
        select distinct i.inventory_id
        from inventory as i
        where film_id in (
            select film_id
            from film_category
            where category_id = 1
        )
    )
);

-- Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.
select payment_id, amount,
case 
when amount between 0 and 2 then 'low'
when amount between 2 and 4 then 'medium'
when amount > 4 then 'high'
else 'unknown'
end as payment
from payment;