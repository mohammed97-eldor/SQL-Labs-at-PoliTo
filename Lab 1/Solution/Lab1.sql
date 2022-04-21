Lab1.sql

Select Sum(Price) As SumRateYear, DateYear, PhoneRateType, Sum(Sum(Price)) Over (Partition By DateYear) As SumYear, Sum(Sum(Price)) Over (Partition By PhoneRateType) As SumRate, Sum(Sum(Price)) Over () As TotSum 
From Facts, TimeDim, PhoneRate 
Where Facts.ID_PhoneRate = PhoneRate.ID_PhoneRate And Facts.ID_Time = TimeDim.ID_Time 
Group By  PhoneRateType, DateYear;

Select Sum(Price), DateYear, PhoneRateType  
From Facts, TimeDim, PhoneRate 
Where Facts.ID_PhoneRate = PhoneRate.ID_PhoneRate And Facts.ID_Time = TimeDim.ID_Time 
Group By Cube(PhoneRateType, DateYear);



Select Sum(Price) as TotPrice, Sum(NumberOfCalls) as TotNumCalls, DateMonth, Rank() Over (Order By Sum(Price) Desc) As RankMonth
From Facts, TimeDim
Where Facts.ID_Time = TimeDim.ID_Time
Group By DateMonth
Order By Sum(Price) Desc;



Select DateYear, DateMonth, Sum(NumberOfCalls) as TotCalls, Rank() Over (Order By Sum(NumberOfCalls) Desc) As Ranking
From Facts, TimeDim
Where DateYear = 2003 And Facts.ID_Time = TimeDim.ID_Time
Group By DateMonth, DateYear
Order By Sum(NumberOfCalls) Desc;



Select DayDate, Sum(Price) as TotalIncome, Avg(Sum(Price)) Over (Order By DayDate RANGE BETWEEN INTERVAL '2' day preceding and current row) As MovingAvg 
From Facts, TimeDim
Where DateMonth = '7-2003' And Facts.ID_time = TimeDim.ID_time
Group By DayDate;


Select DateMonth, DateYear, Sum(Price) As MonthlyIncome, Sum(Sum(Price)) Over (Partition By DateYear Order By DateMonth Rows Unbounded Preceding) As ComulativeSum
From Facts, TimeDim
Where Facts.ID_time = TimeDim.ID_time
Group By DateMonth, DateYear
Order By DateMonth;