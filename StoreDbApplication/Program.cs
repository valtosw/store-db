using StoreDbApplication.DataAccess;
using StoreDbApplication.Models;

namespace StoreDbApplication
{
    public static class Program
    {
        private static async Task Main()
        {
            var connectionString = "";
            var currentEmployeeId = 4;

            Console.WriteLine("Store DB Application started.");
            Console.WriteLine("=========================================\n");

            await RunReportingScenario(connectionString);
            await RunTransactionalScenario(connectionString, currentEmployeeId);

            Console.WriteLine("\nStore DB Application finished.");
        }

        private static async Task RunReportingScenario(string connectionString)
        {
            Console.WriteLine("--- SCENARIO 1: READING & REPORTING ---");

            using var unitOfWork = new UnitOfWork(connectionString);
            try
            {
                Console.WriteLine("\n[1] Fetching active customers (from view_active_customers)...");
                var activeCustomers = await unitOfWork.ReportingRepository.GetActiveCustomersAsync();
                Console.WriteLine($"  -> Found {activeCustomers.Count()} active customers.");

                Console.WriteLine("\n[2] Fetching product details (from view_product_details)...");
                var products = await unitOfWork.ProductRepository.GetProductDetailByIdAsync(1);
                Console.WriteLine($"  -> Details for Product ID 1: {products?.product_name} ({products?.brand_name}) - ${products?.Price}");

                Console.WriteLine("\n[3] Fetching recent order summaries (from view_order_summary)...");
                var orderSummaries = await unitOfWork.ReportingRepository.GetOrderSummariesAsync();
                foreach (var summary in orderSummaries.Take(10))
                {
                    Console.WriteLine($"  -> Order #{summary.order_id} by {summary.customer_name} on {summary.order_date:yyyy-MM-dd}, Status: {summary.Status}");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"\nERROR during reporting scenario: {ex.Message}");
            }
        }

        private static async Task RunTransactionalScenario(string connectionString, int currentEmployeeId)
        {
            Console.WriteLine("\n\n--- SCENARIO 2: CREATE NEW CUSTOMER AND FIRST ORDER ---");

            using var unitOfWork = new UnitOfWork(connectionString);
            var newCustomerId = 0; 
            var newOrderId = 0;

            try
            {
                Console.WriteLine("\n[1] Creating a new customer: 'Don Draper'...");
                var newCustomer = new Customer
                {
                    FirstName = "Don",
                    LastName = "Draper",
                    Email = $"don.draper.{DateTime.Now.Ticks}@example.com",
                    PhoneNumber = "212-555-0142",
                    Address = "100 Park Avenue, New York, NY"
                };
                newCustomerId = await unitOfWork.CustomerRepository.AddAsync(newCustomer, currentEmployeeId);
                Console.WriteLine($"  -> SUCCESS: Customer 'Don Draper' created with ID: {newCustomerId}.");

                Console.WriteLine("\n[2] Creating an order header for the new customer...");
                newOrderId = await unitOfWork.OrderRepository.CreateAsync(newCustomerId, currentEmployeeId, currentEmployeeId);
                Console.WriteLine($"  -> SUCCESS: Order header created with ID: {newOrderId}.");

                Console.WriteLine("\n[3] Adding items to the order...");

                // Item 1: ProBook X1 (ID=1)
                var product1 = await unitOfWork.ProductRepository.GetProductDetailByIdAsync(1);
                var item1 = new OrderItem 
                { 
                    OrderId = newOrderId, 
                    ProductId = product1!.Id, 
                    Quantity = 1, 
                    UnitPrice = product1.Price, 
                    Discount = 0 
                };
                await unitOfWork.OrderRepository.AddItemAsync(item1);
                Console.WriteLine($"  -> Added: {product1.product_name} (1x at ${product1.Price})");

                // Item 2: StoreBrand Pen Pack (ID=21)
                var product2 = await unitOfWork.ProductRepository.GetProductDetailByIdAsync(21);
                var item2 = new OrderItem 
                { 
                    OrderId = newOrderId, 
                    ProductId = product2!.Id, 
                    Quantity = 5, 
                    UnitPrice = product2.Price, 
                    Discount = 0 
                };
                await unitOfWork.OrderRepository.AddItemAsync(item2);
                Console.WriteLine($"  -> Added: {product2.product_name} (5x at ${product2.Price})");

                Console.WriteLine("\n[4] Finalizing order total...");
                await unitOfWork.OrderRepository.UpdateOrderTotalAsync(newOrderId, currentEmployeeId);
                Console.WriteLine("  -> SUCCESS: Order total has been calculated and updated.");

                unitOfWork.Commit();
                Console.WriteLine("\n===================================================================");
                Console.WriteLine("SUCCESS: Transaction committed. Customer and order are now saved.");
                Console.WriteLine("===================================================================");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"\nERROR: An operation failed. Transaction will be rolled back. Details: {ex.Message}");
                unitOfWork.Rollback();
                Console.WriteLine("  -> Rollback complete. Database state is unchanged.");
            }
        }
    }
}
