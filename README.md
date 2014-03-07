fleet-manager-lite
==================

Intended to demonstrate the fleet-manager project is feasible using the selected technology.

Goals
-----
* Create a rails app
* Input and view data for one car
* no authentication
* no css etc

Models
------
* Cars
  * Show action
* Drivers
* Trips

Relations
---------
* Trips have a car
* Cars have many trips
* Trips have a driver
* Drivers have many trips
* Cars may have a primary driver
* A driver may have a primary car

Views
-----
/ => link to log trip, link to see all trips  
/car/:car_id => all trips for :car_id  
/car/:car_id/log => log new trip for :car_id  
/trip/new => log a new trip  
/trip/:trip_id => view details of trip  

Installing
==========
On Debian 7.4, I installed ruby and rubygems, then ran `gem install rails`
To create the initial package, I ran `rails new fleet-manager-lite`
I modified `fleet-manager-lite/Gemfile` and uncommented therubyracer
Then I ran `bundle update`

