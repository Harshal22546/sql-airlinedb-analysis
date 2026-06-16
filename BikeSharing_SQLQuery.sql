--Identified the most popular product in each store based on quantity sold. Expected Output: store_name, product_name, quantity_sold
-- Expected Output columns should be exactly in the same sequence.
select
store_name,
product_name,
quantity_sold
from (
select
s.store_name,
p.product_name,
sum(oi.quantity) as quantity_sold,
rank() over(partition by s.store_name order by sum(oi.quantity) desc) as rank
from stores s
join orders o
on s.store_id = o.store_id
join order_items oi 
on o.order_id = oi.order_id
join products p
on oi.product_id = p.product_id
group by s.store_name, p.product_name
) subquery
where 
rank = 1