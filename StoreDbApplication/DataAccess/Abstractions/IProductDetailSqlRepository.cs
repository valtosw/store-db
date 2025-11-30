using StoreDbApplication.Models.Updates;

namespace StoreDbApplication.DataAccess.Abstractions
{
    public interface IProductDetailSqlRepository
    {
        Task<SqlProductDetail?> GetByIdAsync(int id);
        Task<List<SqlProductDetail>> FindByAttributeAsync(string key, string value);
        Task<List<SqlProductDetail>> FindByMultipleAttributesAsync(Dictionary<string, string> attributes);
    }
}
