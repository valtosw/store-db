using Dapper;
using StoreDbApplication.DataAccess.Abstractions;
using StoreDbApplication.Models;
using System.Data;
using System.Data.Common;
using System.Transactions;

namespace StoreDbApplication.DataAccess.Repositories
{
    public sealed class ReportingRepository(IDbTransaction transaction) : IReportingRepository
    {
        private IDbConnection Connection => transaction?.Connection!;

        public async Task<IEnumerable<ActiveEmployee>> GetActiveEmployeesAsync()
        {
            return await Connection.QueryAsync<ActiveEmployee>(
                "SELECT * FROM view_active_employees",
                transaction: transaction
            );
        }

        public async Task<IEnumerable<ActiveCustomer>> GetActiveCustomersAsync()
        {
            return await Connection.QueryAsync<ActiveCustomer>(
                "SELECT id, first_name, last_name, email FROM view_active_customers",
                transaction: transaction
            );
        }

        public async Task<IEnumerable<OrderSummary>> GetOrderSummariesAsync()
        {
            return await Connection.QueryAsync<OrderSummary>(
                "SELECT * FROM view_order_summary",
                transaction: transaction
            );
        }

        public async Task<IEnumerable<LowStockProduct>> GetLowStockProductsAsync()
        {
            return await Connection.QueryAsync<LowStockProduct>(
                "SELECT * FROM view_low_stock_products",
                transaction: transaction
            );
        }

        public async Task<IEnumerable<ProductSale>> GetProductSalesAsync(DateTime startDate, DateTime endDate)
        {
            var parameters = new
            {
                p_start_date = startDate,
                p_end_date = endDate
            };

            return await Connection.QueryAsync<ProductSale>(
                "sp_report_product_sales",
                parameters,
                transaction: transaction,
                commandType: CommandType.StoredProcedure
            );
        }
    }
}
