using BackEndForJawla1.Models;

namespace BackEndForJawla1.services
{
    public interface IRouteService
    {
        Task<routes> CreateRouteAsync(routes route);
        Task<routes> GetRouteByIdAsync(string id);
        Task<routes> UpdateRouteAsync(routes routes);
        Task<bool> DeleteRouteAsync(string id);
    }
}
