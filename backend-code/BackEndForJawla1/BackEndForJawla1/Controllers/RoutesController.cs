using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using BackEndForJawla1.Models;
using BackEndForJawla1.Data;
using BackEndForJawla1.services;
using System.Reflection.Metadata.Ecma335;

namespace BackEndForJawla1.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RoutesController : ControllerBase
    {
        
        private readonly RoutesService _routesService;

        public RoutesController(RoutesService routesService) {
            _routesService = routesService;
        }


        //Post : api/routes
        [HttpPost]
        public IActionResult AddRoute(routes routes)
        {
            _routesService.CreateRouteAsync(routes);
            return Ok();
        }

        //get: api/routes
        [HttpGet]
        public IActionResult GetRoute(string id) {
            return Ok() ;
        }
          
      
    }
}
