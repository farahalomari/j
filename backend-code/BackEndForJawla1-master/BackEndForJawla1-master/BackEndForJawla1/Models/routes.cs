using System.ComponentModel.DataAnnotations;

namespace BackEndForJawla1.Models
{
    public class routes
    {
        [Key]
        [StringLength(100)]
       
        public string routeID { get; set; }
        [StringLength(100)]
        
        public string routeName { get; set; }
    }
}
