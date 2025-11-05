using StoreDbApplication.Models;

namespace StoreDbApplication.DataAccess.Abstractions
{
    public interface IProductRepository
    {
        Task<ProductDetail?> GetProductDetailByIdAsync(int id);
        Task AddAsync(Product product, int updatedBy);
        Task UpdatePriceAsync(int productId, decimal newPrice, int updatedBy);
    }
}
