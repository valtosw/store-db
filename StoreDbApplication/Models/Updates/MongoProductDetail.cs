using MongoDB.Bson.Serialization.Attributes;

namespace StoreDbApplication.Models.Updates
{
    public class MongoProductDetail
    {
        [BsonId] 
        public int Id { get; set; }

        [BsonElement("sku")]
        public string Sku { get; set; } = null!;

        [BsonElement("name")]
        public string Name { get; set; } = null!;

        [BsonElement("properties")]
        public Dictionary<string, object> Properties { get; set; } = [];
    }
}
