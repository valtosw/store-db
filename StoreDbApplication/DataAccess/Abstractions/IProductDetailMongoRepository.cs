using StoreDbApplication.Models.Updates;

namespace StoreDbApplication.DataAccess.Abstractions
{
    public interface IProductDetailMongoRepository
    {
        Task<MongoProductDetail?> GetByIdAsync(int id);
        Task<List<MongoProductDetail>> FindByAttributeAsync(string key, object value);
        Task SeedDataAsync(IEnumerable<MongoProductDetail> products);
        Task<List<MongoProductDetail>> FindByAttributeProjectionAsync(string key, object value);
        Task<List<MongoProductDetail>> FindByMultipleAttributesAsync(Dictionary<string, object> attributes);
    }
}
