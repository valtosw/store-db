using Dapper;
using StoreDbApplication.DataAccess.Abstractions;
using StoreDbApplication.Models;
using System.Data;

namespace StoreDbApplication.DataAccess.Repositories
{
    public sealed class CustomerRepository(IDbTransaction transaction) : ICustomerRepository
    {
        private IDbConnection Connection => transaction?.Connection!;

        public async Task<int> AddAsync(Customer customer, int updatedBy)
        {
            var parameters = new
            {
                p_first_name = customer.FirstName,
                p_last_name = customer.LastName,
                p_email = customer.Email,
                p_phone_number = customer.PhoneNumber,
                p_address = customer.Address,
                p_updated_by = updatedBy
            };

            return await Connection.ExecuteScalarAsync<int>(
                "sp_customer_insert", 
                parameters, 
                transaction: transaction, 
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task UpdateAsync(Customer customer, int updatedBy)
        {
            var parameters = new
            {
                p_id = customer.Id,
                p_first_name = customer.FirstName,
                p_last_name = customer.LastName,
                p_email = customer.Email,
                p_phone_number = customer.PhoneNumber,
                p_address = customer.Address,
                p_updated_by = updatedBy
            };

            await Connection.ExecuteAsync(
                "sp_customer_update", 
                parameters, 
                transaction: transaction, 
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task SoftDeleteAsync(int id, int updatedBy)
        {
            await Connection.ExecuteAsync(
                "sp_customer_soft_delete", 
                new { p_id = id, p_updated_by = updatedBy }, 
                transaction: transaction, 
                commandType: CommandType.StoredProcedure
            );
        }
    }
}
