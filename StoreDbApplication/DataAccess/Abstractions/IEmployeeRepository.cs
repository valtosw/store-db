using StoreDbApplication.Models;

namespace StoreDbApplication.DataAccess.Abstractions
{
    public interface IEmployeeRepository
    {
        Task<Employee?> GetByIdAsync(int id);
        Task AddAsync(Employee employee, int updatedBy);
        Task UpdateAsync(Employee employee, int updatedBy);
        Task SoftDeleteAsync(int id, int updatedBy);
    }
}
