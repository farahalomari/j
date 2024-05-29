-- FUNCTION: busNetwork.calculate_buckets_for_route(character varying)

-- DROP FUNCTION IF EXISTS "busNetwork".calculate_buckets_for_route(character varying);

--function to calculate buckets for a route

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

CREATE TABLE IF NOT EXISTS "busNetwork"."bucketInfo"
(
    "routeID" character varying COLLATE pg_catalog."default" NOT NULL,
    "nodesInBucket" integer[],
    "numBuckets" integer,
    CONSTRAINT uq_route_id UNIQUE ("routeID"),
    CONSTRAINT fk_bucket_info_route FOREIGN KEY ("routeID")
        REFERENCES "busNetwork".routes ("routeID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);



CREATE OR REPLACE FUNCTION "busNetwork".calculate_buckets_for_route(
	"routeID" character varying)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    numNodes INTEGER;
    numBuckets INTEGER;
    remNodes INTEGER;
    nodesInBucket INTEGER[];
BEGIN
-- Get the total number of nodes for the route
    SELECT COUNT(*) INTO numNodes
    FROM "busNetwork"."busRouteStop"
    WHERE "busNetwork"."busRouteStop"."routeID" = calculate_buckets_for_route."routeID";

    -- Calculate the number of buckets (floor(sqrt(n)))
    numBuckets := FLOOR(SQRT(numNodes));

    -- Calculate the remainder (n % floor(sqrt(n)))
    remNodes := numNodes % numBuckets;

    -- Calculate the number of nodes per bucket without remainder nodes
    nodesInBucket := ARRAY[numBuckets];
		FOR i IN 1..numBuckets LOOP
    		nodesInBucket[i] := (numNodes - remNodes) / numBuckets;
		END LOOP;
    -- Print variable values to PostgreSQL log
    RAISE NOTICE 'number of nodes in route: %', numNodes;
    RAISE NOTICE 'number of buckets in route: %', numBuckets;
    RAISE NOTICE 'number of remainder nodes: %', remNodes;
    RAISE NOTICE 'base number of nodes in each bucket: %', nodesInBucket;

   
    -- Loop through each bucket
    --counter := remNodes;
	    -- Distribute the base number of nodes to all buckets
        -- If counter is not 0, give the bucket an extra node (remainder node)
        -- Decrease counter by 1
    FOR i IN 1..remNodes LOOP
        --EXIT WHEN counter = 0; -- Exit loop if no remaining nodes
        nodesInBucket[i] := nodesInBucket[i] + 1;
        --counter := counter - 1;
    END LOOP;

        -- Insert the bucket_id and nodes_per_bucket into the bucket_info table
        -- Handle the case where the route ID already exists (e.g., update existing row or skip insertion)

		--IF EXISTS (SELECT 1 FROM "busNetwork"."bucketInfo" WHERE "busNetwork"."bucketInfo"."routeID" = calculate_buckets_for_route."routeID") THEN
		--ELSE
		    -- Delete existing data in the bucket_info table for this route
    DELETE FROM "busNetwork"."bucketInfo" WHERE "busNetwork"."bucketInfo"."routeID" = calculate_buckets_for_route."routeID";

    -- Loop through each bucket
    FOR i IN 1..numBuckets LOOP
        -- Insert the bucket_id and nodes_per_bucket into the bucket_info table
        -- Use exception handling to handle duplicate key violation
        BEGIN
            INSERT INTO "busNetwork"."bucketInfo" ("routeID", "nodesInBucket", "numBuckets")
            VALUES (calculate_buckets_for_route."routeID", nodesInBucket, numBuckets);
        EXCEPTION WHEN unique_violation THEN
            -- Handle duplicate key violation (optional)
            -- You can log the error or take any necessary action
            -- In this example, we're simply skipping the insertion
            CONTINUE;
        END;
    END LOOP;
		
    -- Check if the sum of nodes in buckets equals the total number of nodes
    IF numNodes != (SELECT SUM(nodes) FROM unnest(nodesInBucket) nodes) THEN
        RAISE EXCEPTION 'Sum of nodes in buckets does not match total number of nodes';
    END IF;

END;
$BODY$;


--populate table bucketInfo
SELECT "busNetwork".calculate_buckets_for_route('53IN')

--select table bucketInfo
SELECT * FROM "busNetwork"."bucketInfo"
ORDER BY "routeID";
