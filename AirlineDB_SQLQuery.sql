-- How many tickets are there without boading passes? Expected Output: just one numbers required
with tickets_without_boarding as (
select
t.ticket_no
from tickets t
left join boarding_passes bp
on t.ticket_no = bp.ticket_no
where bp.ticket_no is null
)
select
count(*) ticket_without_boarding_pass
from tickets_without_boarding

-- Represent the “book_date” column in “yyyy_mm_dd” format using Bookings table. Expected output: book_ref, book_date (in "yyyy-mm-dd" format)& total amount. Output columns should be in Exact same sequence as given in Expected Output.
select
book_ref,
CONVERT(VARCHAR(10), book_date, 23) AS book_date, 
total_amount
from bookings

-- Rank airports based on the number of flights departing from them. Expected output: departure_airport, total_flights, and airport_rank in the exact same sequence
with flight_counts as (
select
departure_airport,
count(*) total_flights
from flights
group by departure_airport
),
ranked_airports as (
select
departure_airport,
total_flights,
rank() over(order by total_flights desc) airport_rank
from flight_counts
)
select
departure_airport,
total_flights,
airport_rank
from ranked_airports

