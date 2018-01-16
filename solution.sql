SELECT city_name, 
       PERCENTILE_CONT(0.9) WITHIN GROUP(ORDER BY actual_eta - predicted_eta) AS 90th_percentile
FROM trips LEFT JOIN cities ON trips.city_id = cities.city_id
WHERE city_name IN ('Qarth', 'Meereen') AND 
      status = 'completed' AND
      DATE_PART('day', CURRENT_TIMESTAMP - INTERVAL '30 days') <= 30
GROUP BY city_name





SELECT city_name, dayOfWeek, SUM(CASE WHEN status = 'completed' AND
                                           DATE_PART('day', request_at - _ts)*24 + DATE_PART('hour', request_at - _ts) <= 168 THEN 1
                                      ELSE 0
                                 END)/COUNT(*)*100 AS percentOfSignup

FROM (SELECT *, (CASE WHEN EXTRACT(DOW FROM _ts) = 1 THEN 'Mon'
                      WHEN EXTRACT(DOW FROM _ts) = 2 THEN 'TUE'
                      WHEN EXTRACT(DOW FROM _ts) = 3 THEN 'WED'
                      WHEN EXTRACT(DOW FROM _ts) = 4 THEN 'THU'
                      WHEN EXTRACT(DOW FROM _ts) = 5 THEN 'FRI'
                      WHEN EXTRACT(DOW FROM _ts) = 6 THEN 'SAT'
                      WHEN EXTRACT(DOW FROM _ts) = 0 THEN 'SUN'
                 END) AS dayOfWeek
      FROM trips LEFT JOIN cities on trips.city_id = cities.city_id
                 LEFT JOIN events on trips.client_id = events.rider_id
      WHERE DATE_PART('year', _ts) = 2016 AND
            DATE_PART('week', _ts) = 1 AND
            city_name IN ('Qarth', 'Meereen') AND
            event_name = 'sign_up_success'
      )
      
GROUP BY city_name, dayOfWeek
     
     
     
     
     
     
     
     
    


      
