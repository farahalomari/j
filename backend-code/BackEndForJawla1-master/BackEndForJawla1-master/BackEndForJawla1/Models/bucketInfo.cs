using System.ComponentModel.DataAnnotations;

namespace BackEndForJawla1.Models
{
    public class bucketInfo
    {
        [Key]
        
        public string routeID { get; set; }
        
        public List<int> nodesInBucket { get; set; }
       
        public int numBuckets { get; set; }

    }
}
