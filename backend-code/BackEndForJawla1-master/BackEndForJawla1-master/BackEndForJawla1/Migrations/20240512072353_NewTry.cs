using System.Collections.Generic;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace BackEndForJawla1.Migrations
{
    /// <inheritdoc />
    public partial class NewTry : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "bucketInfo",
                columns: table => new
                {
                    routeID = table.Column<string>(type: "text", nullable: false),
                    nodesInBucket = table.Column<List<int>>(type: "integer[]", nullable: false),
                    numBuckets = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_bucketInfo", x => x.routeID);
                });

           /* migrationBuilder.CreateTable(
                name: "busStops",
                columns: table => new
                {
                    stopID = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    stopName = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_busStops", x => x.stopID);
                });*/

            migrationBuilder.CreateTable(
                name: "routes",
                columns: table => new
                {
                    routeID = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    routeName = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_routes", x => x.routeID);
                });

            migrationBuilder.CreateTable(
                name: "routeStops",
                columns: table => new
                {
                    routeID = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    StopID = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    StopOrder = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_routeStops", x => x.routeID);
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "bucketInfo");

            //migrationBuilder.DropTable(
             //   name: "busStops");

            migrationBuilder.DropTable(
                name: "routes");

            migrationBuilder.DropTable(
                name: "routeStops");
        }
    }
}
