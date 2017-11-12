using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FirstREST.Lib_Primavera.Model
{
    public class Artigo
    {
        public string CodArtigo
        {
            get;
            set;
        }

        public string Nome
        {
            get;
            set;
        }

        public string DescArtigo
        {
            get;
            set;
        }

        public double Stock
        {
            get;
            set;
        }

        public string Armazem
        {
            get;
            set;
        }

        public double Preco
        {
            get;
            set;
        }

        public double PrecoPromocional
        {
            get;
            set;
        }

        public string Iva
        {
            get;
            set;
        }

        public string Categoria
        {
            get;
            set;
        }

        public string SubCategoria
        {
            get;
            set;
        }

        public string Autor
        {
            get;
            set;
        }

        public string Editora
        {
            get;
            set;
        }

        public char Alterado
        {
            get;
            set;
        }
    }
}