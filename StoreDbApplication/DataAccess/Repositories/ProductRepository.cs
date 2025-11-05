using Dapper;
using StoreDbApplication.DataAccess.Abstractions;
using StoreDbApplication.Models;
using System.Data;

namespace StoreDbApplication.DataAccess.Repositories
{
    public sealed class ProductRepository(IDbTransaction transaction) : IProductRepository
    {
        private IDbConnection Connection => transaction?.Connection!;

        public async Task<ProductDetail?> GetProductDetailByIdAsync(int id)
        {
            return await Connection.QuerySingleOrDefaultAsync<ProductDetail>(
                "SELECT * FROM view_product_details WHERE id = @Id",
                new { Id = id },
                transaction: transaction
            );
        }

        public async Task AddAsync(Product product, int updatedBy)
        {
            var parameters = new
            {
                p_name = product.Name,
                p_sku = product.Sku,
                p_description = product.Description,
                p_price = product.Price,
                p_category_id = product.CategoryId,
                p_brand_id = product.BrandId,
                p_updated_by = updatedBy
            };

            await Connection.ExecuteAsync(
                "sp_product_insert",
                parameters, 
                transaction: transaction, 
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task UpdatePriceAsync(int productId, decimal newPrice, int updatedBy)
        {
            var parameters = new
            {
                p_id = productId,
                p_new_price = newPrice,
                p_updated_by = updatedBy
            };

            await Connection.ExecuteAsync(
                "sp_product_update_price", 
                parameters, 
                transaction: transaction, 
                commandType: CommandType.StoredProcedure
            );
        }
    }
}
