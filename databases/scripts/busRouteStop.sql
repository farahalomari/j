-- Define schema
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.schemata WHERE schema_name = 'busNetwork'
    ) THEN
        CREATE SCHEMA "busNetwork";
    END IF;
END $$;

-- Table: busNetwork.busRouteStop

-- DROP TABLE IF EXISTS "busNetwork"."busRouteStop";

CREATE TABLE IF NOT EXISTS "busNetwork"."busRouteStop" (
    "routeID" character varying(100) COLLATE "C" NOT NULL,
    "stopID" character varying(100) COLLATE "C" NOT NULL,
    "stopOrder" integer,
    CONSTRAINT "busRouteStop_pkey" PRIMARY KEY ("routeID", "stopID"),
    CONSTRAINT "fk_route" FOREIGN KEY ("routeID")
        REFERENCES "busNetwork"."routes" ("routeID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "fk_stop" FOREIGN KEY ("stopID")
        REFERENCES "busNetwork"."busStops" ("stopID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);


INSERT INTO "busNetwork"."busRouteStop" ("routeID", "stopID", "stopOrder") VALUES
	('40IN', '10074', 6),
	('40IN', '10111', 1),
	('40IN', '10400', 12),
	('40IN', '10402', 10),
	('40IN', '10489', 13),
	('40IN', '10523', 9),
	('40IN', '10607', 7),
	('40IN', '11670', 14),
	('40IN', '11808', 2),
	('40IN', '11809', 3),
	('40IN', '11810', 4),
	('40IN', '11811', 5),
	('40IN', '11812', 8),
	('40IN', '11813', 11),
	('40OUT', '10066', 2),
	('40OUT', '10078', 5),
	('40OUT', '10111', 6),
	('40OUT', '10118', 4),
	('40OUT', '10434', 3),
	('40OUT', '11670', 1),
	('50IN', '10288', 1),
	('50IN', '10572', 6),
	('50IN', '10589', 4),
	('50IN', '11684', 8),
	('50IN', '11711', 5),
	('50IN', '11769', 7),
	('50IN', '11774', 3),
	('50IN', '11776', 2),
	('50OUT', '10288', 8),
	('50OUT', '10572', 3),
	('50OUT', '10589', 5),
	('50OUT', '11684', 1),
	('50OUT', '11711', 4),
	('50OUT', '11769', 2),
	('50OUT', '11774', 6),
	('50OUT', '11776', 7),
	('53IN', '10637', 1),
	('53IN', '10641', 2),
	('53IN', '11691', 5),
	('53IN', '11701', 4),
	('53IN', '11777', 3),
	('53OUT', '10288', 8),
	('53OUT', '10572', 3),
	('53OUT', '10589', 5),
	('53OUT', '11684', 1),
	('53OUT', '11711', 4),
	('53OUT', '11769', 2),
	('53OUT', '11774', 6),
	('53OUT', '11776', 7),
	('54IN', '10334', 2),
	('54IN', '10637', 7),
	('54IN', '10641', 6),
	('54IN', '11689', 3),
	('54IN', '11699', 1),
	('54IN', '11701', 4),
	('54IN', '11777', 5),
	('54OUT', '10637', 1),
	('54OUT', '10641', 2),
	('54OUT', '11691', 5),
	('54OUT', '11701', 4),
	('54OUT', '11777', 3),
	('55IN', '10008', 6),
	('55IN', '10625', 7),
	('55IN', '11678', 1),
	('55IN', '11681', 2),
	('55IN', '11691', 5),
	('55IN', '11701', 4),
	('55IN', '11777', 3),
	('55OUT', '10625', 1),
	('55OUT', '10626', 2),
	('55OUT', '10640', 5),
	('55OUT', '11678', 8),
	('55OUT', '11681', 7),
	('55OUT', '11714', 4),
	('55OUT', '11777', 6),
	('55OUT', '11778', 3),
	('59IN', '10001', 1),
	('59IN', '10002', 2),
	('59IN', '10003', 3),
	('59IN', '10288', 8),
	('59IN', '10305', 4),
	('59IN', '10570', 5),
	('59IN', '10622', 10),
	('59IN', '10623', 9),
	('59IN', '11691', 7),
	('59IN', '11699', 6),
	('59OUT', '10001', 6),
	('59OUT', '10288', 3),
	('59OUT', '10622', 1),
	('59OUT', '10623', 2),
	('59OUT', '11691', 4),
	('59OUT', '11699', 5),
	('60IN', '11681', 1),
	('60IN', '11767', 4),
	('60IN', '11768', 5),
	('60IN', '11769', 6),
	('60IN', '11777', 2),
	('60IN', '11781', 3),
	('60IN', '11782', 7),
	('60IN', '11784', 8),
	('60OUT', '11681', 7),
	('60OUT', '11767', 4),
	('60OUT', '11768', 3),
	('60OUT', '11769', 2),
	('60OUT', '11777', 6),
	('60OUT', '11781', 5),
	('60OUT', '11784', 1);
	
--Select all stops in all routes in order
SELECT * FROM "busNetwork"."busRouteStop"
ORDER BY "routeID" ASC, "stopID" ASC 