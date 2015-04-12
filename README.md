#fml

A Ruby on Rails web app for tracking mileage of a fleet of company cars.

##Bugs
* Adding a car with a 0 odometer does not create an initial trip, which will cause the new trip form to fail
* No way to add a starting location for a car

##To do
* Cars can only be edited by owners or admins
* Car show action
* Disable Car
* Archive view showing disabled cars
* Car life-cycle
  * when added to fleet
  * when to retire
  * when to service
* Personal mile costs
  * Global
  * Per car

##Features
* Active Directory\LDAP backed authentication.
* Track end location of trips
* Auto-complete when typing locations
* Edit cars
* Cars have owners
* Any user can add a car
* Track trips ending at garage
* Track personal trips
* Hard-coded reports

##Dependencies
* devise and devise_ldap_authenticatable for LDAP authentication
* rail-4-autocomplete
* pundit for authorisation

##Installing
Tested using Ubuntu 14.04 and rails 4.0.3; installed by gem
