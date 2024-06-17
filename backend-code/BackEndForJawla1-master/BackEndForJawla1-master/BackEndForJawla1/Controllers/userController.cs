using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using BackEndForJawla1.Data;
using BackEndForJawla1.Models;
using BCrypt.Net;

namespace BackEndForJawla1.Controllers
{
    public class userController : Controller
    {
        private readonly MyDbContext _context;
        public IActionResult Index()
        {
            return View();
        }
        public userController(MyDbContext context)
        {
            _context = context;
        }


        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] user User)
        {
            if (await _context.user.AnyAsync(u => u.phoneNumber == User.phoneNumber))
            {
                return BadRequest(new { message = "Phone number already exists" });
            }

            User.password = BCrypt.Net.BCrypt.HashPassword(User.password);
            _context.user.Add(User);
            await _context.SaveChangesAsync();

            return Ok(new { message = "user created successfully" });
        }



        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginRequest request)
        {
            var user = await _context.user.SingleOrDefaultAsync(u => u.phoneNumber == request.PhoneNumber);
            if (user == null || !BCrypt.Net.BCrypt.Verify(request.Password, user.password))
            {
                return Unauthorized(new { message = "Invalid phone number or password" });
            }

            return Ok(new { message = "Valid credentials" });
        }
    }

    public class LoginRequest
    {
        public string PhoneNumber { get; set; }
        public string Password { get; set; }
    }

}

