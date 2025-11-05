using StoreDbApplication.Models;

namespace StoreDbApplication.DataAccess.Abstractions
{
    public interface IReportingRepository
    {
        Task<IEnumerable<ActiveEmployee>> GetActiveEmployeesAsync();
        Task<IEnumerable<ActiveCustomer>> GetActiveCustomersAsync();
        Task<IEnumerable<OrderSummary>> GetOrderSummariesAsync();
        Task<IEnumerable<LowStockProduct>> GetLowStockProductsAsync();
        Task<IEnumerable<ProductSale>> GetProductSalesAsync(DateTime startDate, DateTime endDate);
    }
}
