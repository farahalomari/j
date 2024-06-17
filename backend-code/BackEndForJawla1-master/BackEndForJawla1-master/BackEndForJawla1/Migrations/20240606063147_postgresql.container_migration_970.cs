using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace BackEndForJawla1.Migrations
{
    /// <inheritdoc />
    public partial class postgresqlcontainer_migration_970 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropPrimaryKey(
                name: "PK_stopsgeojson",
                schema: "busNetwork",
                table: "stopsgeojson");

            migrationBuilder.EnsureSchema(
                name: "user");

            migrationBuilder.RenameTable(
                name: "stopsgeojson",
                schema: "busNetwork",
                newName: "user",
                newSchema: "user");

            migrationBuilder.AddPrimaryKey(
                name: "PK_user",
                schema: "user",
                table: "user",
                column: "routeID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropPrimaryKey(
                name: "PK_user",
                schema: "user",
                table: "user");

            migrationBuilder.RenameTable(
                name: "user",
                schema: "user",
                newName: "stopsgeojson",
                newSchema: "busNetwork");

            migrationBuilder.AddPrimaryKey(
                name: "PK_stopsgeojson",
                schema: "busNetwork",
                table: "stopsgeojson",
                column: "routeID");
        }
    }
}
