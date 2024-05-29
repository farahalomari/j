CREATE TABLE IF NOT EXISTS "busNetwork".stopsgeojson
(
    id integer NOT NULL DEFAULT nextval('"busNetwork".stopsgeojson_id_seq'::regclass),
    geom geometry(Point,4326),
    "stopID" character varying COLLATE pg_catalog."default",
    "stopName" character varying COLLATE pg_catalog."default",
    CONSTRAINT stopsgeojson_pkey PRIMARY KEY (id)
)