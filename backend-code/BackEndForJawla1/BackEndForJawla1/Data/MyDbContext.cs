using BackEndForJawla1.Models;
using Microsoft.EntityFrameworkCore;

namespace BackEndForJawla1.Data
{
    public class MyDbContext : DbContext
    {
        public MyDbContext(DbContextOptions<MyDbContext> options) : base(options)
        {

        }

        //

        public DbSet<busStops> busStops { get; set; }
        public DbSet<routes> routes { get; set; }
        public DbSet<busRouteStop> routeStops { get; set; }
        public DbSet<bucketInfo> bucketInfo { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            /* base.OnConfiguring(optionsBuilder);*/

            if (!optionsBuilder.IsConfigured)
            {
                //optionsBuilder.UseNpgsql(connectionString);
                var configuration = new ConfigurationBuilder()
                    .SetBasePath(Directory.GetCurrentDirectory())
                    .AddJsonFile("appsettings.json")
                    .Build();

                var connectionString = configuration.GetConnectionString("MyPostgresConnection");

                optionsBuilder.UseNpgsql(connectionString,
                    c => c.MigrationsHistoryTable("__EFMigrationsHistory", "busNetwork")
                    );
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasDefaultSchema("busNetwork");

            modelBuilder.Entity<busStops>().ToTable("busStops", "busNetwork");
            modelBuilder.Entity<routes>().ToTable("routes", "busNetwork");
            modelBuilder.Entity<bucketInfo>().ToTable("bucketInfo", "busNetwork");
            modelBuilder.Entity<busRouteStop>().ToTable("busRouteStop", "busNetwork");
        }
    }
}
