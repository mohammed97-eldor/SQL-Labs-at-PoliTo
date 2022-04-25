Queries.sql

SELECT DateMonth, phoneRateType, SUM(Price)/COUNT(DISTINCT DayDate), SUM(Price)/SUM(NumberOfCalls)
FROM Facts, TimeDim, PhoneRate 
WHERE Facts.Id_time = TimeDim.Id_time and Facts.Id_phoneRate = PhoneRate.Id_phoneRate AND DateYear=2003 
GROUP BY cube(phoneRateType, DateMonth);




SELECT Region, Province, SUM(SUM(NumberOfCalls)) OVER (PARTITION BY Region)/COUNT(DISTINCT DayDate), SUM(NumberOfCalls)/COUNT(DISTINCT DayDate)
FROM Facts, TimeDim, Location
WHERE Facts.Id_time = TimeDim.Id_time and Facts.id_location_caller = Location.id_location
GROUP BY Region, Province;




SELECT DateMonth, phoneRateType, SUM(Price), SUM(Price)/SUM(SUM(Price)) OVER (PARTITION BY DateMonth), SUM(Price)/SUM(SUM(Price)) OVER (PARTITION BY phoneRateType) 
FROM Facts , TimeDim ,PhoneRate 
WHERE Facts.Id_time = TimeDim.Id_time and Facts.Id_phoneRate = PhoneRate.Id_phoneRate AND DateYear=2003
GROUP BY phoneRateType, DateMonth;





SELECT Region, Province, SUM(NumberOfCalls), SUM(NumberOfCalls)/SUM(SUM(NumberOfCalls)) OVER (PARTITION BY Region)
FROM Facts, Location 
WHERE Facts.id_location_caller = Location.id_location
GROUP BY Region, Province;





SELECT DateYear, DateMonth, SUM(NumberOfCalls) AS TOTCALLS, SUM(SUM(NumberOfCalls)) OVER( PARTITION BY DateYear, Region ORDER BY DateMonth ROWS UNBOUNDED PRECEDING) AS CUMULATIVECALLS_YEARs
FROM FACTS, TIMEDIM, Location 
WHERE FACTS.ID_time=TIMEDIM.ID_time and FACTS.id_location_receiver = Location.id_location
GROUP BY DateMonth, DateYear, Region;