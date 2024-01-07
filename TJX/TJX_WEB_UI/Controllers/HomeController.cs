using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using TJX_WEB_UI.Models;

namespace TJX_WEB_UI.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly IConfiguration _configuration;

        public HomeController(ILogger<HomeController> logger, IConfiguration configuration)
        {
            _logger = logger;
            _configuration = configuration;
        }

        public IActionResult Index(string CountryCode = "USA")
        {
            List<ProductViewModel> products = new List<ProductViewModel>();

            //Countries Drop Down List
            List<string> CountriesList = new List<string>() { "USA", "IND", "UK" };
            SelectList countries = new SelectList(CountriesList);
            ViewBag.ddlCountryCodes = countries;

            
            Uri baseUrl = new Uri(_configuration.GetValue<string>("TJX_API"));
            HttpClient client = new HttpClient();
            client.BaseAddress = baseUrl;
            string ApiUrl = client.BaseAddress +"Product/GetProducts?CountryCode="+CountryCode;
            HttpResponseMessage response = client.GetAsync(ApiUrl).Result;
            if (response.IsSuccessStatusCode)
            {
                string data = response.Content.ReadAsStringAsync().Result;
                products = JsonConvert.DeserializeObject<List<ProductViewModel>>(data);

            }

            return View(products);
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
