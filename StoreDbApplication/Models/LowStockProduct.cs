namespace StoreDbApplication.Models
{
    public class LowStockProduct
    {
        public int ProductId { get; set; }
        public string Sku { get; set; } = null!;
        public string ProductName { get; set; } = null!;
        public string WarehouseName { get; set; } = null!;
        public int CurrentQuantity { get; set; }
        public int ReorderLevel { get; set; }
    }
}
