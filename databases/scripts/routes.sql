-- Define schema
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.schemata WHERE schema_name = 'busNetwork'
    ) THEN
        CREATE SCHEMA "busNetwork";
    END IF;
END $$;

-- Table: busNetwork.routes

-- DROP TABLE IF EXISTS "busNetwork"."routes";

CREATE TABLE IF NOT EXISTS "busNetwork"."routes"
(
    "routeID" character varying(100) COLLATE "C" NOT NULL,
    "routeName" character varying(100) COLLATE "C",
    CONSTRAINT "routes_pkey" PRIMARY KEY ("routeID")
);


INSERT INTO "busNetwork"."routes" ("routeID", "routeName") VALUES
    ('40IN', '40'),
    ('40OUT', '40'),
    ('50IN', '50'),
    ('50OUT', '50'),
    ('53IN', '53'),
    ('53OUT', '53'),
    ('54IN', '54'),
    ('54OUT', '54'),
    ('55IN', '55'),
    ('55OUT', '55'),
    ('59IN', '59'),
    ('59OUT', '59'),
    ('60IN', '60'),
    ('60OUT', '60');



--Testing if the schema or table will be created it already exists
CREATE TABLE IF NOT EXISTS "busNetwork".routes (
    "routeID" character varying(100) COLLATE pg_catalog."default" NOT NULL,
    "routeName" character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT routes_pkey PRIMARY KEY ("routeID")
);

--Testing if the schema will be created if it already exists
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.schemata WHERE schema_name = 'busNetwork'
    ) THEN
        CREATE SCHEMA "busNetwork";
    END IF;
END $$;

SELECT schema_name
FROM information_schema.schemata;

--Select table routes
SELECT *
FROM "busNetwork".routes;

--Select schema
SELECT schema_name
FROM information_schema.schemata;

