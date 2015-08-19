---
title: Fleet Manager User Acceptance Testing Guide
author: Ben Formosa 11429074
header-includes:
    - \usepackage{fancyhdr}
    - \pagestyle{fancy}
    - \fancyfoot[L]{Ben Formosa 11429074}
    - \fancyfoot[C]{\thepage}
geometry: margin=2.5cm
---

<!---

pandoc fm-uat-guide.md -f markdown+auto_identifiers+definition_lists --smart -V papersize:"a4paper" --standalone --highlight-style tango --number-sections --table-of-contents --toc-depth=2 -o fm-uat-guide.pdf

-->

# Introduction
This document outline the User Acceptance Testing procedure and test cases for the Fleet Manager project.

## Project overview
Fleet Manager (FM) is a web-based system for recording travel in company vehicles.

## Scope
Tests should cover all end-user and system administrator activities.

## Testers
Most tests can be carried out by anyone with basic computer skills.  
Tests of the system procedures should be carried out by someone with system administration skills, who is familiar with GNU/Linux, LDAP, HTTPS, and TCP/IP networking.

## Assumptions
* An LDAP directory server is available.
* Each tester has details for at least one account on the directory server.
* Each tester has access to the Fleet Manager User Guide.

# Test cases

## Scripted installation
### Preconditions
* The tester has systems administration skills.
* A computer is prepared with a Debian or Ubuntu operating system.
* An LDAP server is prepared with required users and groups.

### Actions
1. Follow the instructions in the *Installing Fleet Manager with the installer* section of the FM User Guide.
2. Confirm FM is running by following *Checking if Fleet Manager is running* from the FM User Guide.
3. Connect to FM in a web browser.

### Postconditions
* FM is installed and running.
* FM's Sign in page is displayed.

- - -

## Manual installation
### Preconditions
* The tester has systems administration skills.
* A computer is prepared with a Debian or Ubuntu operating system.
* An LDAP server is prepared with required users and groups.

### Actions
1. Follow the instructions in the *Installing Fleet Manager manually* section of the FM User Guide.
2. Confirm FM is running by following *Checking if Fleet Manager is running* from the FM User Guide.
3. Connect to FM in a web browser.

### Postconditions
* FM is installed and running.
* FM's Sign in page is displayed.

- - -

<!--## Scripted uninstallation
### Preconditions
### Actions
### Postconditions

- - -

## Manual uninstallation
### Preconditions
### Actions
### Postconditions

- - --->

## Change SSL certificate
### Preconditions
* The tester has systems administration skills.
* FM is installed and running correctly.

### Actions
1. Connect to FM in a web browser and confirm the serial number  of the SSL certificate.
2. Obtain a new SSL certificate and private key.  
E.g.
```bash
openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -days 365 -nodes
```
3. Confirm the serial number of the new SSL certificate.
E.g.
```bash
openssl x509 -in cert.pem -serial -noout
```
3. Follow the instructions in the *Using your own SSL certificate* section of the FM User Guide.
4. Connect to FM in a web browser and confirm the serial number of the SSL certificate.

### Postconditions
* The serial number of the SSL certificate used in the web browser matches that of the new SSL certificate.

- - -

## HTTP
### Preconditions
* The tester has systems administration skills.
* FM is installed and running correctly.

### Actions
1. Connect to FM in a web browser using HTTP and confirm that it does not load.
1. Connect to FM in a web browser using HTTPS and confirm that it loads.
2. Follow the instructions in the *Disabling HTTPS* section of the FM User Guide.
1. Connect to FM in a web browser using HTTP and confirm that it loads.
1. Connect to FM in a web browser using HTTPS and confirm that it does not load.

### Postconditions
* FM can only be accessed via HTTP.

- - -

## Sign in user
### Preconditions
* FM is installed and running correctly.
* Tester has an account in the FM user group.

### Actions
1. Connect to FM in a web browser.
2. Sign in using a directory account.

### Postconditions
* The user is signed in.
* The message *"Signed in successfully"* is displayed.

- - -

## Add car
### Preconditions
* The tester is signed in to FM.

### Actions
1. Follow the instructions in the *Adding a car* section of the FM User Guide, using the values:

Field|Value
---|---
Name|Test car
Enable|Checked
Fleet|Checked
Make|Test
Model|Test
Rego|ABC 123
State|Test
Initial Odometer reading|100

2. Click *Test car* and confirm the details.

### Postconditions
* The new car is listed on the **Cars** page.
* The Rego displayed on the **Car details** page is *ABC·123*.

- - -

## Add car with invalid data
### Preconditions
* The tester is signed in to FM.
* A car has been created as per the [Add car](#add-car) test.

### Actions
1. Follow the instructions in the *Adding a car* section of the FM User Guide, using the values:

Field|Value
---|---
Name|Test car
Enable|Checked
Fleet|Checked
Make|Test
Model|Test
Rego|ABC 123
State|Test
Initial Odometer reading|100

### Postconditions
* Creating the car does not complete.
* The message *"Name has already been taken"* is displayed.

- - -

## Edit car
### Preconditions
* The tester is signed in to FM.
* A car has been created as per the [Add car](#add-car) test.

### Actions
1. Confirm that the car is listed on the **Cars** page.
1. Follow the instructions in the *Editing a car* section of the FM User Guide to update the values:

Field|Value
---|---
Name|Test truck

1. Confirm that the car is listed on the **Cars** page.

### Postconditions
* The car's name is displayed as *"Test truck"*'

- - -

## Disable car
### Preconditions
* The tester is signed in to FM.
* A car has been created as per the [Add car](#add-car) test.

### Actions
1. Confirm that the car is listed on the **Cars** page.
3. Follow the instructions in the *Disabling a car* section of the FM User Guide.
4. Confirm that the car is not listed on the **Cars** page.
5. Click *Show inactive cars*.
6. Confirm that the car is listed on the **Cars** page.

### Postconditions
* The disabled car is listed on the **Cars** page only after clicking *Show inactive cars*.

- - -

## Log trip
### Preconditions
* The tester is signed in to FM.
* A car has been created as per the [Add car](#add-car) test.

### Actions
1. Follow the instructions in the *Logging travel* section of the FM User Guide, for the Car *Test car*, using the values:

Field|Value
---|---
End location|Here
End odometer reading|200

### Postconditions
* The trip is displayed with a distance of 100.

- - -

## Log personal trip
### Preconditions
* The tester is signed in to FM.
* A car has been created as per the [Add car](#add-car) test.

### Actions
1. Follow the instructions in the *Logging personal travel* section of the FM User Guide, for the Car *Test car*, using the values:

Field|Value
---|---
End location|There
End odometer reading|250
Personal|Checked

### Postconditions
* The trip is displayed with a distance of 50.

- - -

## View report
### Preconditions
* The tester is signed in to FM.
* A car has been created as per the [Add car](#add-car) test.
* A trip has been logged as per the [Log trip](#log-trip) test.
* A personal trip has been logged as per the [Log personal trip](#log-personal-trip) test.

### Actions
1. View the *Distance per car* report, by following the instructions in the *Reports* section of the FM User Guide.
2. Confirm the data in the report.
3. Click *Download CSV*
4. Open the CSV and confirm that the data matches that displayed in the report web page.

### Postconditions
* The report and CSV show the following:

Car|Trip Count|Business|Personal|Total
---|---|---|---|---
Test car|2|100|50|150
