--geom values for each stop grouped by route in order
SELECT "routeID", ARRAY_AGG("stopsgeojson"."geom" ORDER BY "stopOrder") AS route_stops
FROM "busNetwork"."busRouteStop"
JOIN "busNetwork"."stopsgeojson" ON "busNetwork"."busRouteStop"."stopID" = "busNetwork"."stopsgeojson"."stopID"
GROUP BY "routeID";


