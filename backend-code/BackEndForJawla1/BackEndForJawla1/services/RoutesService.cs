using BackEndForJawla1.Models;
using BackEndForJawla1.Controllers;
using BackEndForJawla1.Data;
using Microsoft.EntityFrameworkCore;

namespace BackEndForJawla1.services
{
    public class RoutesService : IRouteService
    {
        private readonly MyDbContext _context;

        public RoutesService(MyDbContext context) {
            _context = context;
        }

        public async Task<routes> CreateRouteAsync(routes route)
        {
            _context.routes.Add(route);
            await _context.SaveChangesAsync();
            return route;
        }

        public async Task<routes> GetRouteByIdAsync(string id)
        {
        return await _context.routes.FindAsync(id);
        }

        public async Task<routes> UpdateRouteAsync(routes routes)
        {
            _context.Entry(routes).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
            await _context.SaveChangesAsync();
            return routes;
        }

        public async Task<bool> DeleteRouteAsync(string id)
        {
        var route = await _context.routes.FindAsync(id);
        if (route == null)
        {
                 return false;
        }
        _context.routes.Remove(route);
        await _context.SaveChangesAsync();
        return true;
        }

        public async Task<IEnumerable<routes>> GetAllRoutesAsync()
        {
            return await _context.routes.ToListAsync();
        }
    }

        /*//create a new route
        public async Task<routes> CreateRoute(routes routes)
        {
            _context.routes.Add(routes);
            await _context.SaveChangesAsync();
            return routes;
        }
        */
    
}
