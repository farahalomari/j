using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace BackEndForJawla1.Migrations
{
    /// <inheritdoc />
    public partial class trytry : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "busStops");

            migrationBuilder.DropPrimaryKey(
                name: "PK_routeStops",
                table: "routeStops");

            migrationBuilder.EnsureSchema(
                name: "busNetwork");

            migrationBuilder.RenameTable(
                name: "routes",
                newName: "routes",
                newSchema: "busNetwork");

            migrationBuilder.RenameTable(
                name: "bucketInfo",
                newName: "bucketInfo",
                newSchema: "busNetwork");

            migrationBuilder.RenameTable(
                name: "routeStops",
                newName: "stopsgeojson",
                newSchema: "busNetwork");

            migrationBuilder.AddPrimaryKey(
                name: "PK_stopsgeojson",
                schema: "busNetwork",
                table: "stopsgeojson",
                column: "routeID");

            migrationBuilder.CreateTable(
                name: "user",
                schema: "busNetwork",
                columns: table => new
                {
                    userId = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    phoneNumber = table.Column<string>(type: "text", nullable: false),
                    password = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_user", x => x.userId);
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "user",
                schema: "busNetwork");

            migrationBuilder.DropPrimaryKey(
                name: "PK_stopsgeojson",
                schema: "busNetwork",
                table: "stopsgeojson");

            migrationBuilder.RenameTable(
                name: "routes",
                schema: "busNetwork",
                newName: "routes");

            migrationBuilder.RenameTable(
                name: "bucketInfo",
                schema: "busNetwork",
                newName: "bucketInfo");

            migrationBuilder.RenameTable(
                name: "stopsgeojson",
                schema: "busNetwork",
                newName: "routeStops");

            migrationBuilder.AddPrimaryKey(
                name: "PK_routeStops",
                table: "routeStops",
                column: "routeID");

            migrationBuilder.CreateTable(
                name: "busStops",
                columns: table => new
                {
                    stopID = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    stopName = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_busStops", x => x.stopID);
                });
        }
    }
}
