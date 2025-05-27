CREATE DATABASE customer_feedback;
USE customer_feedback;

CREATE TABLE customer_survey (
	 CustomerID INT PRIMARY KEY,
     DeliverySatisfaction INT,
     FoodAqualitySatisfaction INT,
     DeliverySpeedSatisfaction INT,
     OrderAccuracy VARCHAR(3)
     );
     
SELECT * FROM customer_survey LIMIT 10;


-- Average satisfaction in each category --
SELECT 
    AVG(DeliverySatisfaction) AS AvgDelivery,
    AVG(FoodAqualitySatisfaction) AS AvgFoodAquality,
    AVG(DeliverySpeedSatisfaction) AS AvgDeliverySpeed
FROM customer_survey;



-- Distribution of qualifications --
SELECT
    DeliverySatisfaction,
    COUNT(*) AS Count
FROM customer_survey
GROUP BY DeliverySatisfaction
ORDER BY DeliverySatisfaction;



-- Percentage of accurate vs. inaccurate orders --
SELECT
    OrderAccuracy,
    COUNT(*) AS Count,
    ROUND(COUNT(*) * 100 / (SELECT COUNT(*) FROM customer_survey),
2) AS Percentage
FROM customer_survey
GROUP BY OrderAccuracy;



-- Correlation between satisfaction with delivery and quality of food --
SELECT
    (AVG(DeliverySatisfaction * FoodAqualitySatisfaction) - AVG(DeliverySatisfaction)
* AVG(FoodAqualitySatisfaction)) /
    (STDDEV(DeliverySatisfaction) * STDDEV(FoodAqualitySatisfaction))
AS Correlation_Delivery_FoodAquality
FROM customer_survey;


-- Satisfied vs. dissatisfied customers --
SELECT
	CASE
        WHEN DeliverySatisfaction >= 4 THEN 'Satisfied'
        WHEN DeliverySatisfaction = 3 THEN 'Neutral'
        ELSE 'Dissatisfied'
	END as SatisfactionLevel,
    COUNT(*) AS Count
FROM customer_survey
GROUP BY SatisfactionLevel;
