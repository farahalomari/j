using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;
using NetTopologySuite.Geometries;



namespace BackEndForJawla1.Models
{
    public class stopsgeojson
    {

        [Key]
        public int Id { get; set; }


        private string geomWKT;

        [NotMapped]
        public Point geom
        {
            get
            {
                if (string.IsNullOrEmpty(geomWKT))
                    return null;
                else
                    return new NetTopologySuite.IO.WKTReader().Read(geomWKT) as Point;
            }
            set
            {
                if (value == null)
                    geomWKT = null;
                else
                    geomWKT = value.AsText();
            }
        }


        public string StopID { get; set; }

        public int StopName { get; set; }



        
    }



}
