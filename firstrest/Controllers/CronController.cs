using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Interop.ErpBS900;
using Interop.StdPlatBS900;
using Interop.StdBE900;
using Interop.GcpBE900;
using System.Runtime.Serialization;
using System.Web.Mvc;
using Newtonsoft.Json;

namespace FirstREST.Controllers
{
    public class CronController : ApiController
    {

        public void Get()
        {

            //artigos

            IEnumerable<Lib_Primavera.Model.Artigo> artigosModificados = Lib_Primavera.PriIntegration.ArtigosModificados();   

            string url = "http://localhost:8081/sinf/awesomebookshop/api/users/primavera_verify_products.php";

            string result = "";

            using (var client = new WebClient())

            {

                client.Headers[HttpRequestHeader.ContentType] = "application/json";

                string json = JsonConvert.SerializeObject(artigosModificados);
                System.Diagnostics.Debug.WriteLine(json);
                result = client.UploadString(url, "POST", json);

            }

            Console.WriteLine(result);


            /*//armazem

            IEnumerable<Lib_Primavera.Model.Artigo> stocksModificados = Lib_Primavera.PriIntegration.StocksModificados();

            url = "http://localhost:8081/sinf/awesomebookshop/api/users/primavera_verify_stocks.php";

            result = "";

            using (var client = new WebClient())
            {

                client.Headers[HttpRequestHeader.ContentType] = "application/json";

                string json = JsonConvert.SerializeObject(stocksModificados);
                System.Diagnostics.Debug.WriteLine(json);
                result = client.UploadString(url, "POST", json);

            }

            //documentos

            IEnumerable<Lib_Primavera.Model.DocVenda> documentosModificados = Lib_Primavera.PriIntegration.DocumentsModificados();

            url = "http://localhost:8081/sinf/awesomebookshop/api/users/primavera_verify_documents.php";

            result = "";

            using (var client = new WebClient())
            {

                client.Headers[HttpRequestHeader.ContentType] = "application/json";

                string json = JsonConvert.SerializeObject(documentosModificados);
                System.Diagnostics.Debug.WriteLine(json);
                result = client.UploadString(url, "POST", json);

            }

            Console.WriteLine(result);*/
           
        }
    }
}
