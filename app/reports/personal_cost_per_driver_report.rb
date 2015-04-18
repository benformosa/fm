class PersonalCostPerDriverReport < Dossier::Report
  def sql
    "
    SELECT users.name AS 'driver',
           sum(trips.distance) AS 'personal',
           (sum(trips.distance) * :globalcost) AS 'cost'
    FROM trips
    JOIN users ON trips.user_id = users.id
    WHERE trips.personal = 't'
    GROUP BY trips.user_id
    UNION ALL
    SELECT 'All personal distance',
           sum(CASE WHEN trips.personal = 't' THEN trips.distance ELSE 0 END) AS personal,
           (sum(CASE WHEN trips.personal = 't' THEN trips.distance ELSE 0 END) * :globalcost) AS personal
    FROM trips;
    "
  end

  def globalcost
    Settings.globalcost
  end

  def format_cost(value)
    formatter.number_to_currency(value)
  end
end
