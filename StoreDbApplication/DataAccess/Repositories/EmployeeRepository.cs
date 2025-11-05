using Dapper;
using StoreDbApplication.DataAccess.Abstractions;
using StoreDbApplication.Models;
using System.Data;

namespace StoreDbApplication.DataAccess.Repositories
{
    public sealed class EmployeeRepository(IDbTransaction transaction) : IEmployeeRepository
    {
        private IDbConnection Connection => transaction?.Connection!;

        public async Task<Employee?> GetByIdAsync(int id)
        {
            return await Connection.QuerySingleOrDefaultAsync<Employee>(
                "sp_employee_get_by_id",
                new { p_id = id },
                transaction: transaction,
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task AddAsync(Employee employee, int updatedBy)
        {
            var parameters = new
            {
                p_first_name = employee.FirstName,
                p_last_name = employee.LastName,
                p_email = employee.Email,
                p_phone_number = employee.PhoneNumber,
                p_hire_date = employee.HireDate,
                p_salary = employee.Salary,
                p_department_id = employee.DepartmentId,
                p_manager_id = employee.ManagerId,
                p_updated_by = updatedBy
            };

            await Connection.ExecuteAsync(
                "sp_employee_insert",
                parameters,
                transaction: transaction,
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task UpdateAsync(Employee employee, int updatedBy)
        {
            var parameters = new
            {
                p_id = employee.Id,
                p_first_name = employee.FirstName,
                p_last_name = employee.LastName,
                p_email = employee.Email,
                p_phone_number = employee.PhoneNumber,
                p_salary = employee.Salary,
                p_department_id = employee.DepartmentId,
                p_manager_id = employee.ManagerId,
                p_updated_by = updatedBy
            };

            await Connection.ExecuteAsync(
                "sp_employee_update",
                parameters,
                transaction: transaction,
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task SoftDeleteAsync(int id, int updatedBy)
        {
            await Connection.ExecuteAsync(
                "sp_employee_soft_delete",
                new { p_id = id, p_updated_by = updatedBy },
                transaction: transaction,
                commandType: CommandType.StoredProcedure
            );
        }
    }
}
