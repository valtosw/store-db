namespace StoreDbApplication.Models.Updates
{
    public class SqlProductDetail
    {
        public int Id { get; set; }
        public string Sku { get; set; } = null!;
        public string Name { get; set; } = null!;
        public Dictionary<string, string> Properties { get; set; } = [];
    }
}
