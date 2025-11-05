using StoreDbApplication.DataAccess.Abstractions;

namespace StoreDbApplication.DataAccess
{
    public interface IUnitOfWork : IDisposable
    {
        IEmployeeRepository EmployeeRepository { get; }
        IReportingRepository ReportingRepository { get; }
        ICustomerRepository CustomerRepository { get; }
        IOrderRepository OrderRepository { get; }
        IProductRepository ProductRepository { get; }

        void Commit();
        void Rollback();
    }
}
