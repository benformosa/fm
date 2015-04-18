class DistancePerCarReport < Dossier::Report
  def sql
    "
    SELECT cars.name as 'car',
      count(trips.id) AS 'trip count',
      sum(CASE WHEN trips.personal = 'f' THEN trips.distance ELSE 0 END) AS business,
      sum(CASE WHEN trips.personal = 't' THEN trips.distance ELSE 0 END) AS personal,
      sum(trips.distance) AS total
    FROM trips
    JOIN cars ON trips.car_id = cars.id
    GROUP BY trips.car_id
    union all
    SELECT 'All cars',
      count(trips.id) AS 'trip count',
      sum(CASE WHEN trips.personal = 'f' THEN trips.distance ELSE 0 END) AS business,
      sum(CASE WHEN trips.personal = 't' THEN trips.distance ELSE 0 END) AS personal,
      sum(trips.distance) AS total
    FROM trips;
    "
  end
end
