class GaragingDriversReport < Dossier::Report
def sql
    "
    SELECT cars.name as 'car',
       users.name as 'driver'
    FROM trips 
    INNER JOIN users on trips.user_id = users.id
    JOIN cars on trips.car_id = cars.id
    WHERE trips.garage = 't'
    GROUP BY trips.user_id, trips.car_id
    ORDER BY cars.id;
    "
  end
end
