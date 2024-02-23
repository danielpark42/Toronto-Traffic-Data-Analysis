--Create new table

CREATE TABLE ksi(
  X VARCHAR(50) NOT NULL,
  Y VARCHAR(50) NOT NULL,
  INDEX_ VARCHAR(50) UNIQUE NOT NULL,
  ACCNUM VARCHAR(50),
  YEAR VARCHAR(50),
  DATE TIMESTAMP NOT NULL,
  TIME VARCHAR(50) NOT NULL,
  STREET1 VARCHAR(200) NOT NULL,
  STREET2 VARCHAR(200),
  OFF_SET VARCHAR(200),
  ROAD_CLASS VARCHAR(200),
  DISTRICT VARCHAR(200),
  WARDNUM INTEGER,
  LATITUDE VARCHAR(50) NOT NULL,
  LONGITUDE VARCHAR(50) NOT NULL,
  LOCCOORD VARCHAR(200),
  ACCLOC VARCHAR(200),
  TRAFFCTL VARCHAR(200),
  VISIBILITY VARCHAR(200),
  LIGHT VARCHAR(200),
  RDSFCOND VARCHAR(200),
  ACCLASS VARCHAR(200),
  IMPACTYPE VARCHAR(200),
  INVTYPE VARCHAR(200),
  INVAGE VARCHAR(200),
  INJURY VARCHAR(200),
  FATAL_NO INTEGER,
  INITDIR VARCHAR(200),
  VEHTYPE VARCHAR(200),
  MANOEUVER VARCHAR(200),
  DRIVACT VARCHAR(200),
  DRIVCOND VARCHAR(200),
  PEDTYPE VARCHAR(200),
  PEDACT VARCHAR(200),
  PEDCOND VARCHAR(200),
  CYCLISTYPE VARCHAR(200),
  CYCACT VARCHAR(200),
  CYCCOND VARCHAR(200),
  PEDESTRIAN VARCHAR(50),
  CYCLIST VARCHAR(50),
  AUTOMOBILE VARCHAR(50),
  MOTORCYCLE VARCHAR(50),
  TRUCK VARCHAR(50),
  TRSN_CITY_VEH VARCHAR(50),
  EMERG_VEH VARCHAR(50),
  PASSENGER VARCHAR(50),
  SPEEDING VARCHAR(50),
  AG_DRIV VARCHAR(50),
  REDLIGHT VARCHAR(50),
  ALCOHOL VARCHAR(50),
  DISABILITY VARCHAR(50),
  HOOD_158 VARCHAR(50),
  NEIGHBOURHOOD_158 VARCHAR(50),
  HOOD_140 VARCHAR(50),
  NEIGHBOURHOOD_140 VARCHAR(50),
  DIVISION VARCHAR(50),
  ObjectId SERIAL UNIQUE NOT NULL
)


--Data Cleaning: 
  --converting time string to a timestamp showing hours and minutes

ALTER TABLE ksi
ADD time_hour_min TIMESTAMP,

UPDATE ksi
SET time = CONCAT('0',time)
WHERE
	length(time) < 4;

UPDATE ksi
SET 
  	time_hour_min = TO_TIMESTAMP(SUBSTRING(TIME, 1, 2) || ':' || SUBSTRING(TIME, 3, 2), 'HH24:MI');

-- Adding a new column to count the sum of vehicles involved in the accident
ALTER TABLE ksi
ADD Sum_of_Vehicles INT;

UPDATE ksi
SET
	Sum_of_Vehicles = 
		CASE WHEN pedestrian IS NOT NULL AND pedestrian != '' THEN 1 
		ELSE 0 
		END +
	
		CASE WHEN cyclist IS NOT NULL AND cyclist != '' THEN 1 
		ELSE 0 
		END +
		
		CASE WHEN automobile IS NOT NULL AND automobile != '' THEN 1 
		ELSE 0 
		END +
		
		CASE WHEN motorcycle IS NOT NULL AND motorcycle != '' THEN 1 
		ELSE 0 
		END +
		
		CASE WHEN truck IS NOT NULL AND truck != '' THEN 1 
		ELSE 0 
		END +
		
		CASE WHEN TRSN_CITY_VEH IS NOT NULL AND TRSN_CITY_VEH != '' THEN 1 
		ELSE 0 
		END +
		
		CASE WHEN EMERG_VEH IS NOT NULL AND EMERG_VEH != '' THEN 1 
		ELSE 0 
		END +
		
		CASE WHEN PASSENGER IS NOT NULL AND PASSENGER != '' THEN 1 
		ELSE 0 
		END
		;


--A pivot table showing the total number of accidents per year, grouped by the causes of the accidents and the vehicles/parties involved

SELECT DISTINCT date_year,
  SUM(ag_driv) AS Total_ag_driver,
  SUM(alcohol) AS Total_alcohol,
  SUM(redlight) AS Total_redlight,
  SUM(disability) AS Total_disability,
  SUM(pedestrian) AS Total_pedestrian,
  SUM(cyclist) AS Total_cyclist,
  SUM(automobile) AS Total_automobile,
  SUM(motorcycle) AS Total_motorcycle,
  SUM(truck) AS Total_truck,
  SUM(trsn_city_veh) AS Total_Transit_City_Vehicle,
  SUM(emerg_veh) AS Total_Emerg_Veh,
  SUM(passenger) AS Total_Passenger,
  SUM(speeding) AS Total_Speeding,
  SUM(fatal) AS Total_fatal,
  SUM(sum_of_causes) AS Total_Causes,
  SUM(sum_of_vehicles) AS Total_Involved
  
FROM ksi
GROUP BY date_year
ORDER BY date_year ASC


--breaking down by percent of the causes and involved vehicles/parties for accidents per year.

SELECT DISTINCT date_year,
  100*SUM(ag_driv)/SUM(sum_of_causes) AS percent_ag_driver,
  100*SUM(alcohol)/SUM(sum_of_causes) AS percent_alcohol,
  100*SUM(redlight)/SUM(sum_of_causes) AS percent_redlight,
  100*SUM(disability)/SUM(sum_of_causes) AS percent_disability,
  100*SUM(speeding)/SUM(sum_of_causes) AS percent_Speeding,
  100*SUM(pedestrian)/SUM(sum_of_vehicles) AS percent_pedestrian,
  100*SUM(cyclist)/SUM(sum_of_vehicles) AS percent_cyclist,
  100*SUM(automobile)/SUM(sum_of_vehicles) AS percent_automobile,
  100*SUM(motorcycle)/SUM(sum_of_vehicles) AS percent_motorcycle,
  100*SUM(truck)/SUM(sum_of_vehicles) AS percent_truck,
  100*SUM(trsn_city_veh)/SUM(sum_of_vehicles) AS percent_Transit_City_Vehicle,
  100*SUM(emerg_veh)/SUM(sum_of_vehicles) AS percent_Emerg_Veh,
  100*SUM(passenger)/SUM(sum_of_vehicles) AS percent_Passenger

  
FROM ksi
GROUP BY date_year
ORDER BY date_year ASC
--We can see from this percent breakdown, that aggressive driving and distracted driving by far the biggest cause
--Automobiles and pedestrians were the most common accident vehicle type

-- We are interested in the the yearly cyclist accidents to spot trends
SELECT "year", COUNT(cyclist)
FROM ksi
GROUP BY "year"
ORDER BY "year" ASC;

-- Query total accidents in each neighbourhood
SELECT neighbourhood_140,COUNT(objectid)
FROM ksi
GROUP BY neighbourhood_140
ORDER BY neighbourhood_140;

-- Query accidents in each neighbourhood, by year
SELECT neighbourhood_140,"year",COUNT(objectid)
FROM ksi
GROUP BY "year", neighbourhood_140
ORDER BY neighbourhood_140, "year";


