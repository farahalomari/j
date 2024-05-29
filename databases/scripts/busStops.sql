-- Define schema
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.schemata WHERE schema_name = 'busNetwork'
    ) THEN
        CREATE SCHEMA "busNetwork";
    END IF;
END $$;

-- Table: busNetwork.busStops

-- DROP TABLE IF EXISTS "busNetwork"."busStops";

CREATE TABLE IF NOT EXISTS "busNetwork"."busStops"
(
    "stopID" character varying(100) COLLATE "C" NOT NULL,
    "stopName" character varying(100) COLLATE "C",
    CONSTRAINT "busStops_pkey" PRIMARY KEY ("stopID")
);


INSERT INTO "busNetwork"."busStops" ("stopID", "stopName") VALUES
  ('10001', 'Faisal Square'),
  ('10002', 'Fuhais Complex'),
  ('10003', 'Central Bank'),
  ('10008', 'Queen Alia St 417'),
  ('10066', 'Faculty of Education'),
  ('10074', 'Abu Nseir Garden'),
  ('10078', 'Applied Science University'),
  ('10111', 'Shafa Badran'),
  ('10118', 'Higher Education'),
  ('10288', 'Sport City Circle'),
  ('10305', 'Jordan Customs'),
  ('10334', 'Omaya Ben Abedshams'),
  ('10400', 'An Aldeen Khateeb'),
  ('10402', 'Alnoor New School'),
  ('10434', 'Ahmad Tarawneh Str. 277'),
  ('10489', 'Ahmad Tarawneh Str. 311'),
  ('10523', 'Jawhar Saqali 365'),
  ('10570', 'King Husain St 478'),
  ('10572', 'Zahran ST 424'),
  ('10589', 'Madena Munawara ST 399'),
  ('10607', 'AlUrdon ST 490'),
  ('10622', 'Alsahafeh Tunnel'),
  ('10623', 'Mukhtar Mall'),
  ('10625', 'Sport City Terminal'),
  ('10626', 'Abd Alhameed Sharaf St'),
  ('10637', 'Jordan Museum Terminal'),
  ('10640', 'Wadi Saqra Int.'),
  ('10641', 'Al-Muhajireen'),
  ('11670', 'JU Mosque'),
  ('11677', 'Business Park'),
  ('11678', 'First Circle'),
  ('11681', '2nd Circle'),
  ('11684', '8th Circle'),
  ('11689', 'Palace of Justice'),
  ('11691', 'Al Dakhlyeh Circle'),
  ('11699', 'Firas Traffic Lights'),
  ('11701', 'Abdali Interchange'),
  ('11711', 'Alharamayn Circle'),
  ('11712', 'Social Security Co'),
  ('11714', 'Haya Cultural Center'),
  ('11715', 'Alshab Circle'),
  ('11767', '5th Circle'),
  ('11768', '6th Circle'),
  ('11769', '7th Circle'),
  ('11774', 'Al-Waha Circle'),
  ('11776', 'Sameh Mall'),
  ('11777', '3rd Circle'),
  ('11778', 'Associations Complex'),
  ('11781', '4th Circle'),
  ('11782', 'AlJazeera Schools'),
  ('11784', 'City Mall'),
  ('11808', 'Seasons Fitness Center'),
  ('11809', 'Masjid Al Shaheed'),
  ('11810', 'Al-Bahriah Circle'),
  ('11811', 'ASU Circle'),
  ('11812', 'Abu Nusayr Circle'),
  ('11813', 'Al-Manhal Traffic');
  
-- List stops in route 60OUT ascending order of stopOrder
SELECT "busStops".*, "busRouteStop"."stopOrder"
FROM "busNetwork"."busStops"
JOIN "busNetwork"."busRouteStop" ON "busStops"."stopID" = "busRouteStop"."stopID"
WHERE "busRouteStop"."routeID" = '60OUT'
ORDER BY "busRouteStop"."stopOrder" ASC;

-- List routes that pass by stop 11711
SELECT "busNetwork"."routes".*
FROM "busNetwork"."routes"
JOIN "busNetwork"."busRouteStop" ON "busNetwork"."routes"."routeID" = "busNetwork"."busRouteStop"."routeID"
WHERE "busNetwork"."busRouteStop"."stopID" = '11711'; 

