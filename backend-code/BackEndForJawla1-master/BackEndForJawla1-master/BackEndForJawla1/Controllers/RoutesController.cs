using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using BackEndForJawla1.Models;
using BackEndForJawla1.Data;

namespace BackEndForJawla1.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RoutesController : ControllerBase
    {
        private readonly MyDbContext _context;

        public RoutesController(MyDbContext context) {
            _context = context;
        }


        /*//create
        public async Task<routes> CreateRoutesAsync(routes routes)
        { 
            _context.routes.Add(routes);
            await _context.SaveChangesAsync();
            return routes;
        }*/

        //[HttpPost]
        //public async Task<ActionResult<routes>> CreateRoutes(routes routes) {
          //  var createdRoute = await _;
     //   }

    }
}
