namespace StoreDbApplication.Models
{
    public class ActiveEmployee
    {
        public int Id { get; set; }
        public string FirstName { get; set; } = null!;
        public string LastName { get; set; } = null!;
        public string Email { get; set; } = null!;
        public string? PhoneNumber { get; set; }
        public DateTime HireDate { get; set; }
        public string DepartmentName { get; set; } = null!;
    }
}
