-- Step 1: Total booking value per customer
WITH customer_total AS (
    SELECT 
        customer_id,
        SUM(booking_value) AS total_value
    FROM bookings
    GROUP BY customer_id
),

-- Step 2: Rank customers by booking value
ranked_customers AS (
    SELECT 
        customer_id,
        total_value,
        RANK() OVER (ORDER BY total_value DESC) AS rnk,
        COUNT(*) OVER () AS total_customers
    FROM customer_total
),

-- Step 3: Get top 5% customers
top_5_percent AS (
    SELECT 
        customer_id,
        total_value
    FROM ranked_customers
    WHERE rnk <= total_customers * 0.05
)

-- Step 4: Compare their contribution to total booking value
SELECT 
    SUM(t5.total_value) AS top_5_value,
    (SELECT SUM(booking_value) FROM bookings) AS total_booking_value,
    ROUND(SUM(t5.total_value) * 100.0 / (SELECT SUM(booking_value) FROM bookings), 2) AS percent_contribution
FROM top_5_percent t5;
