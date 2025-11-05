using StoreDbApplication.Models;

namespace StoreDbApplication.DataAccess.Abstractions
{
    public interface IOrderRepository
    {
        Task<int> CreateAsync(int customerId, int employeeId, int updatedBy);
        Task AddItemAsync(OrderItem item);
        Task UpdateStatusAsync(int orderId, string newStatus, int updatedBy);
        Task UpdateOrderTotalAsync(int orderId, int updatedBy);
    }
}
