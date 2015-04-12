#fml

A Ruby on Rails web app for tracking mileage of a fleet of company cars.

##To do
* Cars can only be edited by owners or admins
* Car show action
* Disable Car
* Archive view showing disabled cars
* Reporting
* Car life-cycle
  * when added to fleet
  * when to retire
  * when to service
* Personal miles
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

##Dependencies
* devise and devise_ldap_authenticatable for LDAP authentication
* rail-4-autocomplete
* pundit for authorisation

##Installing
Tested using Ubuntu 14.04 and rails 4.0.3; installed by gem
