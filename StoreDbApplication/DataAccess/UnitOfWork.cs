using MySql.Data.MySqlClient;
using StoreDbApplication.DataAccess.Abstractions;
using StoreDbApplication.DataAccess.Repositories;
using System.Data;

namespace StoreDbApplication.DataAccess
{
    public class UnitOfWork : IUnitOfWork
    {
        private readonly IDbConnection _connection;
        private IDbTransaction _transaction;
        private bool _disposed;

        public UnitOfWork(string connectionString)
        {
            _connection = new MySqlConnection(connectionString);
            _connection.Open();
            _transaction = _connection.BeginTransaction();

            EmployeeRepository = new EmployeeRepository(_transaction);
            ReportingRepository = new ReportingRepository(_transaction);
            CustomerRepository = new CustomerRepository(_transaction);
            OrderRepository = new OrderRepository(_transaction);
            ProductRepository = new ProductRepository(_transaction);
        }

        public IEmployeeRepository EmployeeRepository { get; private set; }
        public IReportingRepository ReportingRepository { get; private set; }
        public ICustomerRepository CustomerRepository { get; private set; }
        public IOrderRepository OrderRepository { get; private set; }
        public IProductRepository ProductRepository { get; private set; }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        public void Commit()
        {
            try
            {
                _transaction.Commit();
            }
            catch
            {
                _transaction.Rollback();
                throw;
            }
            finally
            {
                _transaction.Dispose();
                _transaction = _connection.BeginTransaction();
            }
        }

        public void Rollback()
        {
            try
            {
                _transaction.Rollback();
            }
            finally
            {
                _transaction.Dispose();
            }
        }

        protected virtual void Dispose(bool disposing)
        {
            if (!_disposed)
            {
                if (disposing)
                {
                    _transaction.Dispose();
                    _connection.Dispose();
                }

                _disposed = true;
            }
        }
    }
}
