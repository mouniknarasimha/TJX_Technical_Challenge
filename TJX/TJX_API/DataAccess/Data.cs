using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using TJX_API.Model;

namespace TJX_API.DataAccess
{
    public class Data
    {
        private string ConnString = null;
        
        
        public Data(string ConnectionString)
        {            
            ConnString = ConnectionString;
        }

        public List<Product> GetProducts(string CountryCode = "USA")
        {
            List<Product> products = new List<Product>();
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand("GetProductsWithCountryCode", connection))
                    {
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        command.Parameters.Add(new SqlParameter("@CountryCode", SqlDbType.NVarChar) { Value = CountryCode });
                        using (SqlDataReader reader = command.ExecuteReader())
                        {

                            while (reader.Read())
                            {
                                Product employee = new Product
                                {
                                    Id = (int)reader["Id"],
                                    Name = reader["Name"].ToString(),
                                    Description = reader["Description"].ToString(),
                                    Price = (Decimal)reader["ConvertedPrice"]
                                };

                                products.Add(employee);
                            }
                        }

                    }
                }
            }
            catch(Exception ex)
            {
                products = null;
                throw ex;
            }

             return products;
        }

        public List<string> CountriesList()
        {
            List<string> countries = new List<string>();
            string query = "select Distinct CountryCode from Country";
            using (SqlConnection connection = new SqlConnection(ConnString))
            {
                connection.Open();

                // Create a SqlCommand
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        // Check if the SqlDataReader has rows
                        if (reader.HasRows)
                        {
                            // Iterate through the result set
                            while (reader.Read())
                            {
                                countries.Add(reader["CountryCode"].ToString());
                            }
                        }
                    }
                }
            }

            return countries;

        }
    }
}
