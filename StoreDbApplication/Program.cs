using StoreDbApplication.DataAccess;
using StoreDbApplication.DataAccess.Repositories;
using StoreDbApplication.Models;
using StoreDbApplication.Models.Updates;
using System.Diagnostics;

namespace StoreDbApplication
{
    public partial class Program
    {
        private static async Task Main()
        {
            var currentEmployeeId = 4;

            Console.WriteLine("Store DB Application started.");
            Console.WriteLine("=========================================\n");

            //await RunReportingScenario(connectionString);
            //await RunTransactionalScenario(connectionString, currentEmployeeId);

            //await RunPerformanceTestScenario();
            await RunCachePerformanceScenario();

            Console.WriteLine("\nStore DB Application finished.");
        }

        private static async Task RunCachePerformanceScenario()
        {
            Console.WriteLine("\n\n--- SCENARIO 4: Key-Value Store (Redis) Caching Performance ---");

            var cacheRepo = new ProductCacheRepository(redisConnectionString);
            using var unitOfWork = new UnitOfWork(connectionString);
            var sqlProductRepo = unitOfWork.ProductDetailSqlRepository;

            var stopwatch = new Stopwatch();
            const int productIdToTest = 500;

            Console.WriteLine($"\n[1] Requesting Product ID {productIdToTest} for the FIRST time...");
            stopwatch.Start();

            var product = await cacheRepo.GetProductAsync(productIdToTest);

            if (product is null)
            {
                Console.WriteLine("  -> Cache MISS. Fetching from primary database (MySQL)...");

                product = await sqlProductRepo.GetByIdAsync(productIdToTest);

                if (product is not null)
                {
                    await cacheRepo.SetProductAsync(product);
                    Console.WriteLine("  -> Stored product in Redis cache for 5 minutes.");
                }
            }
            stopwatch.Stop();
            Console.WriteLine($"  -> Total time for FIRST request (Cache Miss): {stopwatch.ElapsedMilliseconds} ms");

            Console.WriteLine($"\n[2] Requesting Product ID {productIdToTest} for the SECOND time...");
            stopwatch.Restart();

            product = await cacheRepo.GetProductAsync(productIdToTest);

            if (product is not null)
            {
                Console.WriteLine("  -> Cache HIT. Fetched directly from Redis in-memory.");
            }
            else
            {
                Console.WriteLine("  -> Something went wrong, expected a cache hit but got a miss.");
            }
            stopwatch.Stop();
            Console.WriteLine($"  -> Total time for SECOND request (Cache Hit): {stopwatch.ElapsedMilliseconds} ms");
        }

        private static async Task RunPerformanceTestScenario()
        {
            Console.WriteLine("--- SCENARIO 3: SQL vs. NoSQL Performance Test ---");

            var mongoRepo = new ProductDetailMongoRepository(mongoConnectionString, mongoDatabaseName);
            using var unitOfWork = new UnitOfWork(connectionString);
            var sqlRepo = unitOfWork.ProductDetailSqlRepository;

            await SeedMongoDbAsync(mongoRepo);

            var stopwatch = new Stopwatch();

            Console.WriteLine("\n--- Test Case 1: Fetching a single product by ID ---");
            const int productIdToFetch = 5000;
            _ = await sqlRepo.GetByIdAsync(productIdToFetch);
            _ = await mongoRepo.GetByIdAsync(productIdToFetch);

            stopwatch.Restart();
            await sqlRepo.GetByIdAsync(productIdToFetch);
            stopwatch.Stop();
            Console.WriteLine($"SQL Execution Time: {stopwatch.ElapsedMilliseconds} ms");

            stopwatch.Restart();
            await mongoRepo.GetByIdAsync(productIdToFetch);
            stopwatch.Stop();
            Console.WriteLine($"MongoDB Execution Time:  {stopwatch.ElapsedMilliseconds} ms");

            Console.WriteLine("\n--- Test Case 2: Finding products by MULTIPLE attributes ---");
            var sqlAttributes = new Dictionary<string, string>
            {
                { "RAM", "16GB DDR4" },
                { "Storage", "1TB NVMe SSD" }
            };
            var mongoAttributes = new Dictionary<string, object>
            {
                { "RAM", "16GB DDR4" },
                { "Storage", "1TB NVMe SSD" }
            };

            // Warm-up
            _ = await sqlRepo.FindByMultipleAttributesAsync(sqlAttributes);
            _ = await mongoRepo.FindByMultipleAttributesAsync(mongoAttributes);

            stopwatch.Restart();
            var sqlResults = await sqlRepo.FindByMultipleAttributesAsync(sqlAttributes);
            stopwatch.Stop();
            Console.WriteLine($"SQL (2 Attributes) Execution Time: {stopwatch.ElapsedMilliseconds} ms | Found: {sqlResults.Count} products");

            stopwatch.Restart();
            var mongoResults = await mongoRepo.FindByMultipleAttributesAsync(mongoAttributes);
            stopwatch.Stop();
            Console.WriteLine($"MongoDB (2 Attributes) Execution Time:  {stopwatch.ElapsedMilliseconds} ms | Found: {mongoResults.Count} products");
        }

        private static async Task SeedMongoDbAsync(ProductDetailMongoRepository repo)
        {
            Console.WriteLine("\nSeeding MongoDB with 10,000 product documents...");
            var productsToSeed = new List<MongoProductDetail>();
            for (int i = 1; i <= 10000; i++)
            {
                var product = new MongoProductDetail
                {
                    Id = i,
                    Sku = $"SKU-{i:D6}",
                    Name = $"Product Name {i}"
                };

                if (i % 3 == 1)
                {
                    product.Properties.Add("Screen Size", "15.6 inches");
                    product.Properties.Add("RAM", "16GB DDR4");
                    product.Properties.Add("CPU", "Quad-Core i9");
                    product.Properties.Add("Storage", "1TB NVMe SSD");
                }
                else if (i % 3 == 2) 
                {
                    product.Properties.Add("Material", "100% Cotton");
                    product.Properties.Add("Color", "Blue");
                    product.Properties.Add("Size", "Large");
                }
                else
                {
                    product.Properties.Add("Author", "Frank Herbert");
                    product.Properties.Add("Genre", "Science Fiction");
                }
                productsToSeed.Add(product);
            }

            await repo.SeedDataAsync(productsToSeed);
            Console.WriteLine("MongoDB seeding complete.");
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
