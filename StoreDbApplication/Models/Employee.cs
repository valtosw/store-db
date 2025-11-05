namespace StoreDbApplication.Models
{
    public class Employee
    {
        public int Id { get; set; }
        public string FirstName { get; set; } = null!;
        public string LastName { get; set; } = null!;
        public string Email { get; set; } = null!;
        public string? PhoneNumber { get; set; } 
        public DateTime HireDate { get; set; }
        public decimal? Salary { get; set; }
        public int DepartmentId { get; set; }
        public int? ManagerId { get; set; }
    }
}
