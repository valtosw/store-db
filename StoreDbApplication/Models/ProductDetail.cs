namespace StoreDbApplication.Models
{
    public class ProductDetail
    {
        public int Id { get; set; }
        public string Sku { get; set; } = null!;
        public string product_name { get; set; } = null!;
        public string? Description { get; set; }
        public decimal Price { get; set; }
        public string category_name { get; set; } = null!;
        public string brand_name { get; set; } = null!;
    }
}
