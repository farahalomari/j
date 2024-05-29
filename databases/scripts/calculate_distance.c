#include <math.h>
#include <postgres.h>
#include <fmgr.h>
#include <utils/geo_decls.h>

PG_FUNCTION_INFO_V1(calculate_distance);

Datum calculate_distance(PG_FUNCTION_ARGS) {
    GSERIALIZED *node_a_geom = PG_GETARG_GSERIALIZED_P(0);
    GSERIALIZED *node_b_geom = PG_GETARG_GSERIALIZED_P(1);

    POINT2D *node_a_point = (POINT2D *) GS_POINT_GET_POINT2D_P(node_a_geom);
    POINT2D *node_b_point = (POINT2D *) GS_POINT_GET_POINT2D_P(node_b_geom);

    double node_a_x = node_a_point->x;
    double node_a_y = node_a_point->y;
    double node_b_x = node_b_point->x;
    double node_b_y = node_b_point->y;

    double distance = sqrt(pow(node_b_x - node_a_x, 2) + pow(node_b_y - node_a_y, 2));

    PG_RETURN_FLOAT8(distance);
}
