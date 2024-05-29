-- Define schema
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.schemata WHERE schema_name = 'user'
    ) THEN
        CREATE SCHEMA "busNetwork";
    END IF;
END $$;

-- Table: user.card

-- DROP TABLE IF EXISTS "user".card;

CREATE TABLE IF NOT EXISTS "user".card
(
    "cardID" character varying COLLATE pg_catalog."default" NOT NULL,
    amount money,
    CONSTRAINT card_pkey PRIMARY KEY ("cardID")
);