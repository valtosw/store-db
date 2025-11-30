using StoreDbApplication.Models.Updates;

namespace StoreDbApplication.DataAccess.Abstractions
{
    public interface IProductCacheRepository
    {
        Task<SqlProductDetail?> GetProductAsync(int productId);
        Task SetProductAsync(SqlProductDetail product);
    }
}
