namespace StoreDbApplication
{
    public partial class Program
    {
        private const string connectionString = "server=localhost;database=storedb;user=root;password=;Allow User Variables=True;";
        private const string mongoConnectionString = "mongodb://localhost:27017";
        private const string mongoDatabaseName = "StoreDbMongo";
        private const string redisConnectionString = "localhost:6379";
    }
}
