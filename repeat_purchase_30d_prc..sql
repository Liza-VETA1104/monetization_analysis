with first_orders as(
    select user_id, min(order_date) as first_order
    from orders
    group by user_id
  ), 
intervals as(
	select f.user_id, o.order_date - f.first_order as interval
	from first_orders f
	join orders o on f.user_id = o.user_id and o.order_date > f.first_order 
	where o.order_date - f.first_order < 30
  )
select
	round(count(distinct user_id)* 100.0 /(select count(distinct user_id) from orders), 2) as repeat_purchase_30d_prc
from
	intervals
