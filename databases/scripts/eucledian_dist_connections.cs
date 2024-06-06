using System;
using System.Collections.Generic;
using Npgsql;
using Newtonsoft.Json;
using GeoJSON.Net.Geometry;
using System.Linq;

public class Stop
{
    public int StopId { get; set; }
    public string Name { get; set; }
    public double Latitude { get; set; }
    public double Longitude { get; set; }
    public string RouteId { get; set; }
}

public class Bucket
{
    public string RouteId { get; set; }
    public int BucketIndex { get; set; }
    public Stop RepresentativeStop { get; set; }
}

public class BucketConnection
{
    public string SourceRouteId { get; set; }
    public int SourceBucketIndex { get; set; }
    public string TargetRouteId { get; set; }
    public int TargetBucketIndex { get; set; }
    public double Distance { get; set; }
}

public class Program
{
    private static string connectionString = "Host=your_host;Username=your_username;Password=your_password;Database=your_database";

    public static List<Stop> GetStopsFromDatabase()
    {
        var stops = new List<Stop>();
        using (var conn = new NpgsqlConnection(connectionString))
        {
            conn.Open();
            using (var cmd = new NpgsqlCommand("SELECT stopID, stopName, ST_AsGeoJSON(geom) AS geom, routeID FROM busNetwork.stopsgeojson", conn))
            {
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        var geoJson = reader.GetString(reader.GetOrdinal("geom"));
                        var point = JsonConvert.DeserializeObject<Point>(geoJson);
                        var coordinates = (GeographicPosition)point.Coordinates;

                        stops.Add(new Stop
                        {
                            StopId = reader.GetInt32(reader.GetOrdinal("stopID")),
                            Name = reader.GetString(reader.GetOrdinal("stopName")),
                            Latitude = coordinates.Latitude,
                            Longitude = coordinates.Longitude,
                            RouteId = reader.GetString(reader.GetOrdinal("routeID"))
                        });
                    }
                }
            }
        }
        return stops;
    }

    public static Dictionary<string, List<int>> GetBucketInfo()
    {
        var bucketInfo = new Dictionary<string, List<int>>();
        using (var conn = new NpgsqlConnection(connectionString))
        {
            conn.Open();
            using (var cmd = new NpgsqlCommand("SELECT routeID, nodesInBucket FROM busNetwork.bucketInfo", conn))
            {
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        var routeId = reader.GetString(reader.GetOrdinal("routeID"));
                        var nodesInBucket = reader.GetFieldValue<int[]>(reader.GetOrdinal("nodesInBucket")).ToList();
                        bucketInfo[routeId] = nodesInBucket;
                    }
                }
            }
        }
        return bucketInfo;
    }

    public static double CalculateEuclideanDistance(Stop s1, Stop s2)
    {
        double latDiff = s1.Latitude - s2.Latitude;
        double lonDiff = s1.Longitude - s2.Longitude;
        return Math.Sqrt(latDiff * latDiff + lonDiff * lonDiff);
    }

    public static List<BucketConnection> ConnectBuckets(List<Bucket> buckets)
    {
        List<BucketConnection> connections = new List<BucketConnection>();

        foreach (var routeBuckets in buckets.GroupBy(b => b.RouteId))
        {
            foreach (var bucket in routeBuckets)
            {
                foreach (var otherRouteBuckets in buckets.GroupBy(b => b.RouteId).Where(g => g.Key != bucket.RouteId))
                {
                    Bucket closestBucket = null;
                    double closestDistance = double.MaxValue;

                    foreach (var otherBucket in otherRouteBuckets)
                    {
                        double distance = CalculateEuclideanDistance(bucket.RepresentativeStop, otherBucket.RepresentativeStop);
                        if (distance < closestDistance)
                        {
                            closestDistance = distance;
                            closestBucket = otherBucket;
                        }
                    }

                    if (closestBucket != null)
                    {
                        connections.Add(new BucketConnection
                        {
                            SourceRouteId = bucket.RouteId,
                            SourceBucketIndex = bucket.BucketIndex,
                            TargetRouteId = closestBucket.RouteId,
                            TargetBucketIndex = closestBucket.BucketIndex,
                            Distance = closestDistance
                        });
                    }
                }
            }
        }

        return connections;
    }

    public static void Main(string[] args)
    {
        // Fetch stops and bucket information from the database
        List<Stop> stops = GetStopsFromDatabase();
        Dictionary<string, List<int>> bucketInfo = GetBucketInfo();

        // Create buckets based on bucketInfo
        List<Bucket> buckets = new List<Bucket>();
        foreach (var route in bucketInfo)
        {
            string routeId = route.Key;
            List<int> nodesInBucket = route.Value;
            int startIndex = 0;

            for (int i = 0; i < nodesInBucket.Count; i++)
            {
                int nodesCount = nodesInBucket[i];
                var bucketStops = stops
                    .Where(s => s.RouteId == routeId)
                    .Skip(startIndex)
                    .Take(nodesCount)
                    .ToList();

                if (bucketStops.Count > 0)
                {
                    buckets.Add(new Bucket
                    {
                        RouteId = routeId,
                        BucketIndex = i,
                        RepresentativeStop = bucketStops.First()
                    });
                }

                startIndex += nodesCount;
            }
        }

        // Connect buckets
        List<BucketConnection> connections = ConnectBuckets(buckets);

        // Display connections
        foreach (var connection in connections)
        {
            Console.WriteLine($"Route {connection.SourceRouteId} Bucket {connection.SourceBucketIndex} is connected to Route {connection.TargetRouteId} Bucket {connection.TargetBucketIndex} with distance {connection.Distance}");
        }
    }
}
