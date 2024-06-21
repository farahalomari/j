using System.Drawing;
using WebApplication1.Data;
using WebApplication1.services;

namespace WebApplication1.services
{
    public class DistanceCalculatorService
    {
        
        
            private readonly BusNetworkContext _context;

            public DistanceCalculatorService(BusNetworkContext context)
            {
                _context = context;
            }

            public async Task<List<RouteBucketDistance>> CalculateDistancesAsync()
            {
                // List to store the results
                var routeBucketDistances = new List<RouteBucketDistance>();

                // Fetch all routes from the database
                var routes = await _context.Routes.ToListAsync();

                foreach (var route in routes)
                {
                    // Fetch bucket information for the current route
                    var bucketInfo = await _context.BucketInfos
                                                   .Where(b => b.RouteID == route.RouteID)
                                                   .FirstOrDefaultAsync();
                    if (bucketInfo == null) continue;

                    // Fetch stops for the current route's buckets
                    var stops = await _context.StopGeoJsons
                                              .Where(s => bucketInfo.NodesInBucket.Contains(s.StopID))
                                              .OrderBy(s => s.Id) // Ensure stops are ordered
                                              .ToListAsync();

                    // Iterate through the buckets to calculate the closest distances
                    for (int i = 0; i < bucketInfo.NumBuckets; i++)
                    {
                        var currentStop = stops.FirstOrDefault(s => s.StopID == bucketInfo.NodesInBucket[i].ToString());

                        if (currentStop == null) continue;

                        double closestDistance = double.MaxValue;
                        int closestBucketIndex = -1;

                        // Compare with all other buckets to find the closest one
                        for (int j = 0; j < bucketInfo.NumBuckets; j++)
                        {
                            if (i == j) continue;

                            var compareStop = stops.FirstOrDefault(s => s.StopID == bucketInfo.NodesInBucket[j].ToString());

                            if (compareStop == null) continue;

                            double distance = CalculateEuclideanDistance(currentStop.Geom, compareStop.Geom);

                            if (distance < closestDistance)
                            {
                                closestDistance = distance;
                                closestBucketIndex = j;
                            }
                        }

                        // Add the result to the list
                        routeBucketDistances.Add(new RouteBucketDistance
                        {
                            RouteID = route.RouteID,
                            BucketIndex = i,
                            ClosestBucketIndex = closestBucketIndex,
                            Distance = closestDistance
                        });
                    }
                }

                return routeBucketDistances;
            }

            // Helper method to calculate Euclidean distance between two points
            private double CalculateEuclideanDistance(Point start, Point end)
            {
                var xDiff = start.X - end.X;
                var yDiff = start.Y - end.Y;
                return Math.Sqrt(xDiff * xDiff + yDiff * yDiff);
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
    }


