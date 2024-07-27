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
        private IData db;   

        public ProductController(ILogger<ProductController> logger, IConfiguration configuration, IData db2)
        {
            _logger = logger;
            _configuration = configuration;
            this.db = db2;
        }

        [HttpGet]
        public List<Product> GetProducts(string CountryCode="USA")
        {

            //Data Db = new Data(_configuration.GetConnectionString("TJX"));
            Data Db = new Data();
            return Db.GetProducts(CountryCode);
            
        }
    }
}
