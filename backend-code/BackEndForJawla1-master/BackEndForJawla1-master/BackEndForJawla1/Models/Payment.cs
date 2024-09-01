using System.ComponentModel.DataAnnotations;


namespace BackEndForJawla1.Models
{
    public class Payment
    {

        [Key]
        public int paymentId { get; set; }

        public double amount {  get; set; }

        public DateTime? Date { get; set; }

    }
}
