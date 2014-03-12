fml
==================

fleet-manager-lite
Intended to demonstrate the fleet-manager project is feasible using the selected technology.

Goals
-----
* Create a rails app
* Input and view data for one driver
* no authentication
* no css etc

Models
------
* Cars
* Trips

Relations
---------
* Trips may have a previous trip
* Trips have a driver
* Trips have a car
* Cars have many trips

Views
-----
| path | action |
|------|--------|
| / | list cars |
| /cars/:car_id| list all trips for :car_id |
| /trips | list all trips |
| /trips?car=car_id | list all trips for :car_id |
| /trip/new | log a new trip. Can't do this, must specify a car |
| /trips/new?car=car_id | log new trip for :car_id |

Installing
==========
Tested using Debian 7.4 and rails 4.0.3; installed by gem
To create the initial package, I ran `rails new fml`
I modified `fml/Gemfile` and uncommented therubyracer
Then I ran `bundle update`
