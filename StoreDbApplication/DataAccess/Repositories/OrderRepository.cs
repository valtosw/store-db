using Dapper;
using StoreDbApplication.DataAccess.Abstractions;
using StoreDbApplication.Models;
using System.Data;
using System.Data.Common;
using System.Transactions;

namespace StoreDbApplication.DataAccess.Repositories
{
    public sealed class OrderRepository(IDbTransaction transaction) : IOrderRepository
    {
        private IDbConnection Connection => transaction?.Connection!;

        public async Task<int> CreateAsync(int customerId, int employeeId, int updatedBy)
        {
            var parameters = new
            {
                p_customer_id = customerId,
                p_employee_id = employeeId,
                p_updated_by = updatedBy
            };

            return await Connection.ExecuteScalarAsync<int>(
                "sp_order_create", 
                parameters, 
                transaction: transaction, 
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task AddItemAsync(OrderItem item)
        {
            var parameters = new
            {
                p_order_id = item.OrderId,
                p_product_id = item.ProductId,
                p_quantity = item.Quantity,
                p_unit_price = item.UnitPrice,
                p_discount = item.Discount
            };

            await Connection.ExecuteAsync(
                "sp_order_add_item", 
                parameters, 
                transaction: transaction, 
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task UpdateStatusAsync(int orderId, string newStatus, int updatedBy)
        {
            var parameters = new
            {
                p_order_id = orderId,
                p_new_status = newStatus,
                p_updated_by = updatedBy
            };

            await Connection.ExecuteAsync(
                "sp_order_update_status", 
                parameters, 
                transaction: transaction, 
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task UpdateOrderTotalAsync(int orderId, int updatedBy)
        {
            await Connection.ExecuteAsync(
                "sp_order_update_total",
                new { p_order_id = orderId, p_updated_by = updatedBy },
                transaction: transaction,
                commandType: CommandType.StoredProcedure
            );
        }
    }
}
