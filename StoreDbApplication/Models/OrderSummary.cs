namespace StoreDbApplication.Models
{
    public class OrderSummary
    {
        public int order_id { get; set; }
        public DateTime order_date { get; set; }
        public int customer_id { get; set; }
        public string customer_name { get; set; } = null!;
        public string employee_name { get; set; } = null!;
        public string Status { get; set; } = null!;
        public decimal total_amount { get; set; }
    }
}
