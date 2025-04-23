SELECT * FROM ola.bookings;
use ola;
select count(distinct(Booking_ID))
from bookings;

#1. Retrieve all successful bookings:
create view success_bookings as
select * from bookings 
where booking_status = 'success';

#2. Find the average ride distance for each vehicle type:
create view Avg_ride_distance as 
select vehicle_type, avg(Ride_Distance)
from bookings 
group by vehicle_type ;

#3. Get the total number of cancelled rides by customers:
create view cancelled_rides_by_customers as 
select count(*)
from bookings
where Booking_Status = 'Canceled by Customer' ;

#4. List the top 5 customers who booked the highest number of rides:
create view top_5_customers as 
select customer_id, count(booking_id)
from bookings
group by customer_id
order by count(booking_id) desc limit 5;

#5. Get the number of rides cancelled by drivers due to personal and car-related issues:
create view numberofridescancelledbydriversduetopersonalandcar_relatedissues as
select count(Canceled_Rides_by_Driver)
from bookings 
where Canceled_Rides_by_Driver = 'Personal & Car related issue';

#6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
select vehicle_type, max(Driver_Ratings) as max_rating, min(Driver_Ratings) as min_rating
from bookings 
where Vehicle_Type = 'Prime Sedan';

#7. Retrieve all rides where payment was made using UPI:
select * from bookings 
where Payment_Method = 'UPI';

#8. Find the average customer rating per vehicle type:
create view avg_customer_rating_per_vehicle as 
select Vehicle_Type, avg(Customer_Rating)
from bookings 
group by Vehicle_Type;

#9. Calculate the total booking value of rides completed successfully:
create view total_value_of_success_rides as 
select Booking_Status, sum(Booking_Value)
from bookings 
group by Booking_Status
having Booking_Status = 'success';

#10. List all incomplete rides along with the reason:
select Booking_Status, Incomplete_Rides, Incomplete_Rides_Reason
from bookings 
where Incomplete_Rides = 'yes';

select * from total_value_of_success_rides;