using MongoDB.Driver;
using StoreDbApplication.DataAccess.Abstractions;
using StoreDbApplication.Models.Updates;

namespace StoreDbApplication.DataAccess.Repositories
{
    public sealed class ProductDetailMongoRepository : IProductDetailMongoRepository
    {
        private readonly IMongoCollection<MongoProductDetail> _productsCollection;

        public ProductDetailMongoRepository(string connectionString, string databaseName)
        {
            var client = new MongoClient(connectionString);
            var database = client.GetDatabase(databaseName);
            _productsCollection = database.GetCollection<MongoProductDetail>("ProductDetails");
        }

        public async Task<MongoProductDetail?> GetByIdAsync(int id)
        {
            return await _productsCollection.Find(p => p.Id == id).SingleOrDefaultAsync();
        }

        public async Task<List<MongoProductDetail>> FindByAttributeAsync(string key, object value)
        {
            var filter = Builders<MongoProductDetail>.Filter.Eq($"Properties.{key}", value);
            return await _productsCollection.Find(filter).ToListAsync();
        }

        public async Task SeedDataAsync(IEnumerable<MongoProductDetail> products)
        {
            await _productsCollection.Database.DropCollectionAsync("ProductDetails");
            await _productsCollection.InsertManyAsync(products);
        }

        public async Task<List<MongoProductDetail>> FindByAttributeProjectionAsync(string key, object value)
        {
            var filter = Builders<MongoProductDetail>.Filter.Eq($"Properties.{key}", value);

            var projection = Builders<MongoProductDetail>.Projection
                .Include(p => p.Id)
                .Include(p => p.Name);

            return await _productsCollection.Find(filter).Project<MongoProductDetail>(projection).ToListAsync();
        }

        public async Task<List<MongoProductDetail>> FindByMultipleAttributesAsync(Dictionary<string, object> attributes)
        {
            var filterBuilder = Builders<MongoProductDetail>.Filter;
            var filter = filterBuilder.Empty;

            foreach (var attribute in attributes)
            {
                filter &= filterBuilder.Eq($"Properties.{attribute.Key}", attribute.Value);
            }

            var projection = Builders<MongoProductDetail>.Projection
                .Include(p => p.Id)
                .Include(p => p.Name);

            return await _productsCollection.Find(filter).Project<MongoProductDetail>(projection).ToListAsync();
        }
    }
}
