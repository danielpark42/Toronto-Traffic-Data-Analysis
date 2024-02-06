# Toronto-Traffic-Data-Analysis
## About Dataset
## Context

This data set is a cleaned version of the Killed or Seriously Injured (KSI) traffic accident reports from the City of Toronto Police Open Data portal.
## Content

Inside is information for all traffic accidents reported between 2006 and 2022. There is data on the time, location, and the type of incident with various attributes about the traffic conditions at the time of the incident.
## Acknowledgements

I do not own the data. The dataset was directly downloaded from the City of Toronto Police's Open Data Portal.
Inspiration

The inspiration for using this dataset came from living in the City of Toronto for many years, wanting to analyze the data to answer many questions that I ask in my daily life.

## Column Definition 
- **X** Latitude
- **Y** Longitude
- **INDEX_** index
- **ACCNUM** Accident Number
- **YEAR Year** of Accident
- **DATE** Date of Accident
- **TIME** Time of Accident
- **STREET1** Street of Accident
- **STREET2** Street of Accident
- **OFFSET** Distance and direction of the accident
- **ROAD_CLASS** Road Classification
- **DISTRICT** City District
- **WARDNUM** City Ward ID
- **LATITUDE** Latitude
- **LONGITUDE** Longitude
- **LOCCOORD** Location Coordinate
- **ACCLOC** Accident Location
- **TRAFFCTL** Traffic Control Type
- **VISIBILITY** Environment Condition
- **LIGHT** Light Condition
- **RDSFCOND** Road Surface Condition
- **ACCLASS** Classification of Accident
- **IMPACTYPE** Initial Impact Type
- **INVTYPE** Involvement Type
- **INVAGE** Age of Involved Party
- **INJURY** Severity of Injury
- **FATAL_NO** Sequential Number
- **INITDIR** Initial Direction of Travel
- **VEHTYPE** Type of Vehicle
- **MANOEUVER** Vehicle Manouever
- **DRIVACT** Apparent Driver Action
- **DRIVCOND** Driver Condition
- **PEDTYPE** Pedestrian Crash Type
- **PEDACT** Pedestrian Action
- **PEDCOND** Condition of Pedestrian
- **CYCLISTYPE** Cyclist Crash Type
- **CYCACT** Cyclist Action
- **CYCCOND** Cyclist Condition
- **PEDESTRIAN** Pedestrian Involved In Collision
- **CYCLIST** Cyclists Involved in Collision
- **AUTOMOBILE** Driver Involved in Collision
- **MOTORCYCLE** Motorcyclist Involved in Collision
- **TRUCK** Truck Driver Involved in Collision
- **TRSN_CITY_VEH** Transit or City Vehicle Involved in Collision
- **EMERG_VEH** Emergency Vehicle Involved in Collision
- **PASSENGER** Passenger Involved in Collision
- **SPEEDING** Speeding Related Collision
- **AG_DRIV** Aggressive and Distracted Driving Collision
- **REDLIGHT** Red Light Related Collision
- **ALCOHOL** Alcohol Related Collision
- **DISABILITY** Medical or Physical Disability Related Collision
- **HOOD_158** Neighbourhood Identificator
- **NEIGHBOURHOOD_158** Neighbourhood Name
- **HOOD_140** Neighbourhood Identificator
- **NEIGHBOURHOOD_140** Neighbourhood Name
- **DIVISION** Police Division
- **ObjectId** Unique Entry Identifier


## Define the new attribute "TIMEOFDAY".

  -  12AM-4AM - [00 to 4 hours]
  -  4AM-8AM - [4 to 8 hours]
  -  8AM-12PM - [8 to 12 hours]
  -  12PM-4PM - [12 to 16 hours]
  -  4PM-8PM - [16 to 20 hours]
  -  8PM-12PM - [20 to Midnight]

