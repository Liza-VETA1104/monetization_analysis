with paying_users as (
select
	date_trunc('month', o.order_date)::date as order_month,
	count(distinct o.user_id) as paying_users,
	sum(total_amount) as amount_per_month
from
	orders o
group by
	order_month),
active_users as (
select
	date_trunc('month', session_start)::date as active_month,
	count(distinct user_id) as active_users
from
	user_sessions us
group by
	active_month )
select
	order_month, 
	round(p.amount_per_month / a.active_users, 2) as arpu, 
	round(p.amount_per_month / p.paying_users, 2) as arppu, 
	round(paying_users * 1.0 / a.active_users, 2) as share_of_paying_users
from
	paying_users p
join active_users a on
	p.order_month = a.active_month
order by
	order_month

