using StoreDbApplication.Models;

namespace StoreDbApplication.DataAccess.Abstractions
{
    public interface ICustomerRepository
    {
        Task<int> AddAsync(Customer customer, int updatedBy);
        Task UpdateAsync(Customer customer, int updatedBy);
        Task SoftDeleteAsync(int id, int updatedBy);
    }
}
