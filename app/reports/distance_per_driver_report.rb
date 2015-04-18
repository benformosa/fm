class DistancePerDriverReport < Dossier::Report
  def sql
    "
    SELECT users.name as 'driver',
      count(trips.id) AS 'trip count',
      sum(CASE WHEN trips.personal = 'f' THEN trips.distance ELSE 0 END) AS business,
      sum(CASE WHEN trips.personal = 't' THEN trips.distance ELSE 0 END) AS personal,
      sum(trips.distance) AS total
    FROM trips
    JOIN users ON trips.user_id = users.id
    GROUP BY trips.user_id
    union all
    SELECT 'All drivers',
      count(trips.id) AS 'trip count',
      sum(CASE WHEN trips.personal = 'f' THEN trips.distance ELSE 0 END) AS business,
      sum(CASE WHEN trips.personal = 't' THEN trips.distance ELSE 0 END) AS personal,
      sum(trips.distance) AS total
    FROM trips;
    "
  end
end
