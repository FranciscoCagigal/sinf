using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Mvc;
using System.IO;
using Microsoft.Office.Core;
using System.Web;

namespace FirstREST.Controllers
{
    public class FicheirosController : ApiController
    {

        public byte[] Get(int id)
        {
            string tipoDoc = "FA";
            string serie = "2017";
            int numDoc = id;
            string destino = "C:\\xampp\\htdocs\\sinf\\firstrest\\documentos\\faturas\\fa2017_" + id + ".pdf";
            string ficheiro = "C:\\xampp\\htdocs\\sinf\\firstrest\\documentos\\faturas\\fa2017_" + id + "_1.pdf";

            if (!File.Exists(ficheiro))
            {
                Lib_Primavera.PriIntegration.ImprimeDocumento(tipoDoc, serie, numDoc, destino);
            }

            
            
            byte[] byteArray = File.ReadAllBytes(ficheiro);
            return byteArray;
        }
    }
}