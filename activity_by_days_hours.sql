select
	extract('isodow' from order_date) as day_of_week,
	count(order_id) as orders_cnt
from
	orders o
group by
	day_of_week
order by
	day_of_week

select
	extract('hour' from order_timestamp) as hour_of_order,
	count(order_id) as orders_cnt
from
	orders o
group by
	hour_of_order
order by
	hour_of_order
