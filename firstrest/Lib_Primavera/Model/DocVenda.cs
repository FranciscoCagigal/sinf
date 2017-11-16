using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FirstREST.Lib_Primavera.Model
{
    public class DocVenda
    {

        public int id
        {
            get;
            set;
        }

        public string Entidade
        {
            get;
            set;
        }

        public string TipoDoc
        {
            get;
            set;
        }

        public int NumDoc
        {
            get;
            set;
        }

        public int NumDocOrigem
        {
            get;
            set;
        }

        public string Filial
        {
            get;
            set;
        }

        public string FilialOrigem
        {
            get;
            set;
        }

        public DateTime Data
        {
            get;
            set;
        }

        public double TotalMerc
        {
            get;
            set;
        }

        public string Serie
        {
            get;
            set;
        }

        public string SerieOrigem
        {
            get;
            set;
        }

        public string Estado
        {
            get;
            set;
        }

        public List<Model.LinhaDocVenda> LinhasDoc

        {
            get;
            set;
        }

        public byte[] Ficheiro
        {
            get;
            set;
        }

    }
}