using System.ComponentModel.DataAnnotations;

namespace BackEndForJawla1.Models
{
    public class busStops
    {

        [Key]
        
        [StringLength(100)]
        public string stopID { get; set; }

        
        [StringLength(100)]
        public string stopName { get; set; }
    }
}
