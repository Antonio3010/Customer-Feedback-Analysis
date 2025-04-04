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



-- Promedio de satisfacción en cada categoría --
SELECT 
    AVG(DeliverySatisfaction) AS AvgDelivery,
    AVG(FoodAqualitySatisfaction) AS AvgFoodAquality,
    AVG(DeliverySpeedSatisfaction) AS AvgDeliverySpeed
FROM customer_survey;



-- Distribucuón de las calificaciones --
SELECT
    DeliverySatisfaction,
    COUNT(*) AS Count
FROM customer_survey
GROUP BY DeliverySatisfaction
ORDER BY DeliverySatisfaction;



-- Porcentaje de pedidos precisos vs. imprecisos --
SELECT
    OrderAccuracy,
    COUNT(*) AS Count,
    ROUND(COUNT(*) * 100 / (SELECT COUNT(*) FROM customer_survey),
2) AS Percentage
FROM customer_survey
GROUP BY OrderAccuracy;



-- Correlación entre satisfacción con la entrega y calidad de la comida --
SELECT
    (AVG(DeliverySatisfaction * FoodAqualitySatisfaction) - AVG(DeliverySatisfaction)
* AVG(FoodAqualitySatisfaction)) /
    (STDDEV(DeliverySatisfaction) * STDDEV(FoodAqualitySatisfaction))
AS Correlation_Delivery_FoodAquality
FROM customer_survey;



-- Clientes satisfechos vs insatisfechos --
SELECT
	CASE
        WHEN DeliverySatisfaction >= 4 THEN 'Satisfecho'
        WHEN DeliverySatisfaction = 3 THEN 'Neutral'
        ELSE 'Insatisfecho'
	END as SatisfactionLevel,
    COUNT(*) AS Count
FROM customer_survey
GROUP BY SatisfactionLevel;