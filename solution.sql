SELECT city_name, 
       PERCENTILE_CONT(0.9) WITHIN GROUP(ORDER BY actual_eta - predicted_eta) AS 90th_percentile
FROM trips LEFT JOIN cities ON trips.city_id = cities.city_id
WHERE city_name IN ('Qarth', 'Meereen') AND 
      status = 'completed' AND
      DATE_PART('day', CURRENT_TIMESTAMP - INTERVAL '30 days') <= 30
GROUP BY city_name




      
