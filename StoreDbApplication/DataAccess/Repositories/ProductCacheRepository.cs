using StackExchange.Redis;
using StoreDbApplication.DataAccess.Abstractions;
using StoreDbApplication.Models.Updates;
using System.Text.Json;

namespace StoreDbApplication.DataAccess.Repositories
{
    public sealed class ProductCacheRepository : IProductCacheRepository
    {
        private readonly IDatabase _redisDb;

        public ProductCacheRepository(string connectionString)
        {
            var redisConnection = ConnectionMultiplexer.Connect(connectionString);
            _redisDb = redisConnection.GetDatabase();
        }

        public async Task<SqlProductDetail?> GetProductAsync(int productId)
        {
            var key = $"product:{productId}";
            var cachedProductJson = await _redisDb.StringGetAsync(key);

            if (cachedProductJson.IsNullOrEmpty)
                return null; 

            return JsonSerializer.Deserialize<SqlProductDetail>(cachedProductJson!);
        }

        public async Task SetProductAsync(SqlProductDetail product)
        {
            var key = $"product:{product.Id}";
            var productJson = JsonSerializer.Serialize(product);
            await _redisDb.StringSetAsync(key, productJson, TimeSpan.FromMinutes(5));
        }
    }
}
