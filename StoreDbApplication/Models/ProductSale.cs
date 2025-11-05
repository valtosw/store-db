namespace StoreDbApplication.Models
{
    public class ProductSale
    {
        public string Sku { get; set; } = null!;
        public string ProductName { get; set; } = null!;
        public int TotalUnitsSold { get; set; }
        public decimal TotalRevenue { get; set; }
    }
}
