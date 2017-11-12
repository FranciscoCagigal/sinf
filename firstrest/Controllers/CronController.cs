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
            //categorias

            IEnumerable<Lib_Primavera.Model.Familia> categoriasModificadas = Lib_Primavera.PriIntegration.CategoriasModificadas();

            string url = "http://localhost:8081/sinf/awesomebookshop/api/publications/primavera_verify_category.php";

            string result = "";

            if (categoriasModificadas.Count()>0)
                using (var client = new WebClient())
                {

                    client.Headers[HttpRequestHeader.ContentType] = "application/json";
                    string json = JsonConvert.SerializeObject(categoriasModificadas);
                    result = client.UploadString(url, "POST", json);
                    if (result == "ok") {
                        Lib_Primavera.PriIntegration.CategoriasReset();
                    }

                }

            //subcategorias

            IEnumerable<Lib_Primavera.Model.SubFamilia> subCategoriasModificadas = Lib_Primavera.PriIntegration.SubCategoriasModificadas();

            url = "http://localhost:8081/sinf/awesomebookshop/api/publications/primavera_verify_subcategory.php";

            result = "";

            if (subCategoriasModificadas.Count() > 0)
                using (var client = new WebClient())
                {

                    client.Headers[HttpRequestHeader.ContentType] = "application/json";

                    string json = JsonConvert.SerializeObject(subCategoriasModificadas);
                    result = client.UploadString(url, "POST", json);
                    if (result == "ok")
                    {
                        //Lib_Primavera.PriIntegration.SubCategoriasReset();
                    }
                }

            //editoras

            IEnumerable<Lib_Primavera.Model.Marca> editorasModificadas = Lib_Primavera.PriIntegration.EditorasModificadas();

            url = "http://localhost:8081/sinf/awesomebookshop/api/publications/primavera_verify_brand.php";

            result = "";

            if (editorasModificadas.Count() > 0)
                using (var client = new WebClient())
                {

                    client.Headers[HttpRequestHeader.ContentType] = "application/json";

                    string json = JsonConvert.SerializeObject(editorasModificadas);
                    result = client.UploadString(url, "POST", json);
                    if (result == "ok")
                    {
                        Lib_Primavera.PriIntegration.EditorasReset();
                    }
                }

            //artigos
            
            IEnumerable<Lib_Primavera.Model.Artigo> artigosModificados = Lib_Primavera.PriIntegration.ArtigosModificados();   

            url = "http://localhost:8081/sinf/awesomebookshop/api/publications/primavera_verify_products.php";

            result = "";

            if (artigosModificados.Count() > 0)
                using (var client = new WebClient())

                {

                    client.Headers[HttpRequestHeader.ContentType] = "application/json";

                    string json = JsonConvert.SerializeObject(artigosModificados);
                    result = client.UploadString(url, "POST", json);
                    if (result == "ok")
                    {
                        Lib_Primavera.PriIntegration.ArtigosReset();
                    }
                }


            //armazem

            IEnumerable<Lib_Primavera.Model.Artigo> stocksModificados = Lib_Primavera.PriIntegration.StocksModificados();

            url = "http://localhost:8081/sinf/awesomebookshop/api/publications/primavera_verify_stocks.php";

            result = "";

            

            using (var client = new WebClient())
            {

                client.Headers[HttpRequestHeader.ContentType] = "application/json";

                string json = JsonConvert.SerializeObject(stocksModificados);
                System.Diagnostics.Debug.WriteLine(json);
                result = client.UploadString(url, "POST", json);
                if (result == "ok")
                {
                    Lib_Primavera.PriIntegration.StocksReset();
                }

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

            Console.WriteLine(result);
           
        }
    }
}
