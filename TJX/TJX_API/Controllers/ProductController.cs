using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using TJX_API.Model;
using TJX_API.DataAccess;

namespace TJX_API.Controllers
{
    [ApiController]
    [Route("api/[controller]/[action]")]
    public class ProductController : ControllerBase
    {        
        private readonly ILogger<ProductController> _logger;
        private readonly IConfiguration _configuration;


        public ProductController(ILogger<ProductController> logger, IConfiguration configuration)
        {
            _logger = logger;
            _configuration = configuration;
        }

        [HttpGet]
        public List<Product> GetProducts(string CountryCode="USA")
        {
                        
            Data Db = new Data(_configuration.GetConnectionString("TJX"));
            return Db.GetProducts(CountryCode);
            
        }
    }
}
