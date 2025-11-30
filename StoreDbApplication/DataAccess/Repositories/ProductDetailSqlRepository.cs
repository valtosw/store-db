using Dapper;
using StoreDbApplication.DataAccess.Abstractions;
using StoreDbApplication.Models.Updates;
using System.Data;

namespace StoreDbApplication.DataAccess.Repositories
{
    public sealed class ProductDetailSqlRepository(IDbTransaction transaction) : IProductDetailSqlRepository
    {
        private IDbConnection Connection => transaction.Connection!;

        public async Task<SqlProductDetail?> GetByIdAsync(int id)
        {
            const string sql = @"
                SELECT 
                    p.id, p.sku, p.name,
                    at.name AS AttributeKey,
                    pav.value AS AttributeValue
                FROM product p
                LEFT JOIN product_attribute_value pav ON p.id = pav.product_id
                LEFT JOIN attribute_type at ON pav.attribute_type_id = at.id
                WHERE p.id = @Id;";

            var productData = await Connection.QueryAsync<dynamic>(sql, new { Id = id }, transaction);
            if (!productData.Any()) return null;

            var firstRow = productData.First();
            var productDetail = new SqlProductDetail
            {
                Id = firstRow.id,
                Sku = firstRow.sku,
                Name = firstRow.name
            };

            foreach (var row in productData.Where(row => row.AttributeKey is not null))
            {
                productDetail.Properties[row.AttributeKey] = row.AttributeValue;
            }
            return productDetail;
        }

        public async Task<List<SqlProductDetail>> FindByAttributeAsync(string key, string value)
        {
            const string sql = @"
                SELECT p.id, p.sku, p.name
                FROM product p
                WHERE p.id IN (
                    SELECT pav.product_id
                    FROM product_attribute_value pav
                    JOIN attribute_type at ON pav.attribute_type_id = at.id
                    WHERE at.name = @Key AND pav.value = @Value
                );";

            return [.. (await Connection.QueryAsync<SqlProductDetail>(sql, new { Key = key, Value = value }, transaction))];
        }

        public async Task<List<SqlProductDetail>> FindByMultipleAttributesAsync(Dictionary<string, string> attributes)
        {
            var sqlBuilder = new System.Text.StringBuilder("SELECT p.id, p.sku, p.name FROM product p WHERE 1=1 ");
            var parameters = new DynamicParameters();
            int i = 0;

            foreach (var attribute in attributes)
            {
                string keyParam = $"@Key{i}";
                string valParam = $"@Value{i}";
                sqlBuilder.Append($"AND EXISTS (SELECT 1 FROM product_attribute_value pav JOIN attribute_type at ON pav.attribute_type_id = at.id WHERE pav.product_id = p.id AND at.name = {keyParam} AND pav.value = {valParam}) ");
                parameters.Add(keyParam, attribute.Key);
                parameters.Add(valParam, attribute.Value);
                i++;
            }

            return [.. (await Connection.QueryAsync<SqlProductDetail>(sqlBuilder.ToString(), parameters, transaction))];
        }
    }
}
