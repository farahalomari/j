using BackEndForJawla1.Data;
using System.Collections.Generic;
using System.Drawing;
using System.Reflection.Emit;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using NetTopologySuite.Geometries;


namespace WebApplication1.services
{
    public class shortestCalculatorService
    {
        private readonly BusNetworkContext _context;

        public DistanceCalculatorService(BusNetworkContext context)
        {
            _context = context;
        }

        // Method to find the 3 nearest stops to a given location
        private async Task<List<StopGeoJson>> FindNearestStops(Point location, int numberOfStops = 3)
        {
            var stops = await _context.StopGeoJsons.ToListAsync();
            return stops.OrderBy(s => CalculateEuclideanDistance(location, s.Geom))
                        .Take(numberOfStops)
                        .ToList();
        }

        // Method to calculate Euclidean distance between two points
        private double CalculateEuclideanDistance(Point start, Point end)
        {
            var xDiff = start.X - end.X;
            var yDiff = start.Y - end.Y;
            return Math.Sqrt(xDiff * xDiff + yDiff * yDiff);
        }

        // Method to find the shortest path using Dijkstra's algorithm
        public async Task<List<StopGeoJson>> FindShortestPathAsync(Point currentLocation, Point destination)
        {
            var nearestToStart = await FindNearestStops(currentLocation);
            var nearestToEnd = await FindNearestStops(destination);

            // Combine all nearest stops into a single list
            var allStops = nearestToStart.Concat(nearestToEnd).ToList();

            // Create a graph from stops and calculate shortest path
            var stopGraph = CreateStopGraph(allStops);
            var startStop = nearestToStart.First();
            var endStop = nearestToEnd.First();

            return Dijkstra(stopGraph, startStop, endStop);
        }

        // Method to create a graph from stops
        private Dictionary<StopGeoJson, List<StopGeoJson>> CreateStopGraph(List<StopGeoJson> stops)
        {
            var graph = new Dictionary<StopGeoJson, List<StopGeoJson>>();

            foreach (var stop in stops)
            {
                var nearestNeighbors = FindNearestStops(stop.Geom, numberOfStops: 3).Result;
                graph[stop] = nearestNeighbors;
            }

            return graph;
        }

        // Dijkstra's algorithm to find the shortest path
        private List<StopGeoJson> Dijkstra(Dictionary<StopGeoJson, List<StopGeoJson>> graph, StopGeoJson start, StopGeoJson end)
        {
            var distances = new Dictionary<StopGeoJson, double>();
            var previous = new Dictionary<StopGeoJson, StopGeoJson>();
            var nodes = new List<StopGeoJson>();

            foreach (var stop in graph)
            {
                if (stop.Key == start)
                {
                    distances[stop.Key] = 0;
                }
                else
                {
                    distances[stop.Key] = double.MaxValue;
                }
                nodes.Add(stop.Key);
            }

            while (nodes.Count != 0)
            {
                nodes.Sort((x, y) => distances[x].CompareTo(distances[y]));

                var smallest = nodes[0];
                nodes.Remove(smallest);

                if (smallest == end)
                {
                    var path = new List<StopGeoJson>();
                    while (previous.ContainsKey(smallest))
                    {
                        path.Add(smallest);
                        smallest = previous[smallest];
                    }
                    path.Reverse();
                    return path;
                }

                if (distances[smallest] == double.MaxValue)
                {
                    break;
                }

                foreach (var neighbor in graph[smallest])
                {
                    var alt = distances[smallest] + CalculateEuclideanDistance(smallest.Geom, neighbor.Geom);
                    if (alt < distances[neighbor])
                    {
                        distances[neighbor] = alt;
                        previous[neighbor] = smallest;
                    }
                }
            }

            return new List<StopGeoJson>();
        }
    }

    // Class to store the result of closest bucket calculation
    public class RouteBucketDistance
    {
        public string RouteID { get; set; }
        public int BucketIndex { get; set; }
        public int ClosestBucketIndex { get; set; }
        public double Distance { get; set; }
    }

    // DbContext and other classes
    public class BusNetworkContext : DbContext
    {
        public BusNetworkContext(DbContextOptions<BusNetworkContext> options) : base(options) { }

        public DbSet<Route> Routes { get; set; }
        public DbSet<BucketInfo> BucketInfos { get; set; }
        public DbSet<StopGeoJson> StopGeoJsons { get; set; }

        // Configures the table mappings and schema
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Route>().ToTable("routes", schema: "busNetwork");
            modelBuilder.Entity<BucketInfo>().ToTable("bucketInfo", schema: "busNetwork");
            modelBuilder.Entity<StopGeoJson>().ToTable("stopsgeojson", schema: "busNetwork");
        }
    }

    // Your other models
    public class Route
    {
        public string RouteID { get; set; }
        public string RouteName { get; set; }
    }

    public class BucketInfo
    {
        public string RouteID { get; set; }
        public int NumBuckets { get; set; }
        public List<int> NodesInBucket { get; set; }
    }

    public class StopGeoJson
    {
        public int Id { get; set; }
        public Point Geom { get; set; }
        public string StopID { get; set; }
        public string StopName { get; set; }
    }
  

    }

