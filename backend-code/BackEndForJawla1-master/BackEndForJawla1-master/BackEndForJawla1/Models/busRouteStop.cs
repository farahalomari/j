using System.ComponentModel.DataAnnotations;

namespace BackEndForJawla1.Models
{
    public class busRouteStop
    {
        [Key]
        
        [StringLength(100)]
        public string routeID { get; set; }

        
        [StringLength(100)]
        public string StopID { get; set; }
        
        public int StopOrder { get; set; }

    }
}
