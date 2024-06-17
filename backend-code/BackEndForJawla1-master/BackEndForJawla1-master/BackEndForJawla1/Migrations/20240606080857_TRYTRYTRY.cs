using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace BackEndForJawla1.Migrations
{
    /// <inheritdoc />
    public partial class TRYTRYTRY : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "user",
                schema: "busNetwork");

            migrationBuilder.DropPrimaryKey(
                name: "PK_user",
                schema: "user",
                table: "user");

            migrationBuilder.DropColumn(
                name: "routeID",
                schema: "user",
                table: "user");

            migrationBuilder.DropColumn(
                name: "StopID",
                schema: "user",
                table: "user");

            migrationBuilder.RenameColumn(
                name: "StopOrder",
                schema: "user",
                table: "user",
                newName: "userId");

            migrationBuilder.AlterColumn<int>(
                name: "userId",
                schema: "user",
                table: "user",
                type: "integer",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "integer")
                .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn);

            migrationBuilder.AddColumn<string>(
                name: "password",
                schema: "user",
                table: "user",
                type: "text",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "phoneNumber",
                schema: "user",
                table: "user",
                type: "text",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddPrimaryKey(
                name: "PK_user",
                schema: "user",
                table: "user",
                column: "userId");

            migrationBuilder.CreateTable(
                name: "busRouteStop",
                schema: "busNetwork",
                columns: table => new
                {
                    routeID = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    StopID = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    StopOrder = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_busRouteStop", x => x.routeID);
                });

            migrationBuilder.CreateTable(
                name: "stopsgeojson",
                schema: "busNetwork",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    geom = table.Column<string>(type: "geometry(Point, 4326)", nullable: false),
                    StopID = table.Column<string>(type: "text", nullable: false),
                    StopName = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_stopsgeojson", x => x.Id);
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "busRouteStop",
                schema: "busNetwork");

            migrationBuilder.DropTable(
                name: "stopsgeojson",
                schema: "busNetwork");

            migrationBuilder.DropPrimaryKey(
                name: "PK_user",
                schema: "user",
                table: "user");

            migrationBuilder.DropColumn(
                name: "password",
                schema: "user",
                table: "user");

            migrationBuilder.DropColumn(
                name: "phoneNumber",
                schema: "user",
                table: "user");

            migrationBuilder.RenameColumn(
                name: "userId",
                schema: "user",
                table: "user",
                newName: "StopOrder");

            migrationBuilder.AlterColumn<int>(
                name: "StopOrder",
                schema: "user",
                table: "user",
                type: "integer",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "integer")
                .OldAnnotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn);

            migrationBuilder.AddColumn<string>(
                name: "routeID",
                schema: "user",
                table: "user",
                type: "character varying(100)",
                maxLength: 100,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "StopID",
                schema: "user",
                table: "user",
                type: "character varying(100)",
                maxLength: 100,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddPrimaryKey(
                name: "PK_user",
                schema: "user",
                table: "user",
                column: "routeID");

            migrationBuilder.CreateTable(
                name: "user",
                schema: "busNetwork",
                columns: table => new
                {
                    userId = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    password = table.Column<string>(type: "text", nullable: false),
                    phoneNumber = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_user", x => x.userId);
                });
        }
    }
}
