-- Define schema
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.schemata WHERE schema_name = 'user'
    ) THEN
        CREATE SCHEMA "user";
    END IF;
END $$;

-- Table: busNetwork.busStops

-- DROP TABLE IF EXISTS "busNetwork"."busStops";
CREATE TABLE IF NOT EXISTS "user"."user"
(
    "userID" character varying COLLATE pg_catalog."default" NOT NULL,
    "phoneNumber" character varying(10) COLLATE pg_catalog."default" NOT NULL CHECK (phoneNumber LIKE '07________'),
    password character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT uid_pkey PRIMARY KEY ("userID")
);