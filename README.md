#fml

A Ruby on Rails web app for tracking mileage of a fleet of company cars.

##Bugs
* No way to add a starting location for a car - currently hardcoded

##To do
* Cars can only be edited by owners or admins
* Car life-cycle
  * when added to fleet
  * when to retire
  * when to service

##Features
* Active Directory\LDAP backed authentication.
* Track end location of trips
* Auto-complete when typing locations
* Cars can be marked as fleet cars
* Edit cars
* Cars have owners
* Any user can add a car
* Track trips ending at garage
* Track personal trips
* SQL-based reports

##Dependencies
* devise and devise_ldap_authenticatable for LDAP authentication
* rail-4-autocomplete - my fork
* pundit for authorisation
* rails-settings-cached
* dossier

##Installing
Tested using Ubuntu 14.04 and rails 4.0.3; installed by gem
