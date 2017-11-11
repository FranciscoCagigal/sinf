﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Interop.ErpBS900;
using Interop.StdPlatBS900;
using Interop.StdBE900;
using Interop.GcpBE900;
using ADODB;
using System.Net;

namespace FirstREST.Lib_Primavera
{
    public class PriIntegration
    {
        

        # region Cliente

        public static List<Model.Cliente> ListaClientes()
        {
            
            
            StdBELista objList;

            List<Model.Cliente> listClientes = new List<Model.Cliente>();

            if (PriEngine.InitializeCompany(FirstREST.Properties.Settings.Default.Company.Trim(), FirstREST.Properties.Settings.Default.User.Trim(), FirstREST.Properties.Settings.Default.Password.Trim()) == true)
            {

                //objList = PriEngine.Engine.Comercial.Clientes.LstClientes();

                objList = PriEngine.Engine.Consulta("SELECT Cliente, Nome, NumContrib as NumContribuinte, Fac_Mor AS campo_exemplo, CDU_Email as Email FROM  CLIENTES");

                
                while (!objList.NoFim())
                {
                    listClientes.Add(new Model.Cliente
                    {
                        CodCliente = objList.Valor("Cliente"),
                        NomeCliente = objList.Valor("Nome"),
                        NumContribuinte = objList.Valor("NumContribuinte"),
                        Morada = objList.Valor("campo_exemplo"),
                        Email = objList.Valor("Email")
                    });
                    objList.Seguinte();

                }

                return listClientes;
            }
            else
                return null;
        }

        public static Lib_Primavera.Model.Cliente GetCliente(string codCliente)
        {
            

            GcpBECliente objCli = new GcpBECliente();


            Model.Cliente myCli = new Model.Cliente();

            if (PriEngine.InitializeCompany(FirstREST.Properties.Settings.Default.Company.Trim(), FirstREST.Properties.Settings.Default.User.Trim(), FirstREST.Properties.Settings.Default.Password.Trim()) == true)
            {

                if (PriEngine.Engine.Comercial.Clientes.Existe(codCliente) == true)
                {
                    
                    objCli = PriEngine.Engine.Comercial.Clientes.Edita(codCliente);
                    myCli.CodCliente = objCli.get_Cliente();
                    myCli.NomeCliente = objCli.get_Nome();
                    myCli.NumContribuinte = objCli.get_NumContribuinte();
                    myCli.Morada = objCli.get_Morada();
                    myCli.Email = PriEngine.Engine.Comercial.Clientes.DaValorAtributo(codCliente, "CDU_Email");

                    
                    return myCli;
                }
                else
                {
                    return null;
                }
            }
            else
                return null;
        }

        public static Lib_Primavera.Model.RespostaErro UpdCliente(Lib_Primavera.Model.Cliente cliente)
        {
            Lib_Primavera.Model.RespostaErro erro = new Model.RespostaErro();
           

            GcpBECliente objCli = new GcpBECliente();

            try
            {

                if (PriEngine.InitializeCompany(FirstREST.Properties.Settings.Default.Company.Trim(), FirstREST.Properties.Settings.Default.User.Trim(), FirstREST.Properties.Settings.Default.Password.Trim()) == true)
                {

                    if (PriEngine.Engine.Comercial.Clientes.Existe(cliente.CodCliente) == false)
                    {
                        erro.Erro = 1;
                        erro.Descricao = "O cliente não existe";
                        return erro;
                    }
                    else
                    {

                        objCli = PriEngine.Engine.Comercial.Clientes.Edita(cliente.CodCliente);
                        objCli.set_EmModoEdicao(true);

                        objCli.set_Nome(cliente.NomeCliente);
                        objCli.set_NumContribuinte(cliente.NumContribuinte);
                        objCli.set_Morada(cliente.Morada);
                        objCli.set_Localidade(cliente.Localidade);
                        objCli.set_LocalidadeCodigoPostal(cliente.Localidade);
                        objCli.set_CodigoPostal(cliente.CodigoPostal);

                        switch (cliente.Localidade.ToLower())
                    {
                        case "ignorado":
                            objCli.set_Distrito("00");
                            break;
                        case "aveiro":
                            objCli.set_Distrito("01");
                            break;
                        case "beja":
                            objCli.set_Distrito("02");
                            break;
                        case "braga":
                            objCli.set_Distrito("03");
                            break;
                        case "bragança":
                            objCli.set_Distrito("04");
                            break;
                        case "castelo branco":
                            objCli.set_Distrito("05");
                            break;
                        case "coimbra":
                            objCli.set_Distrito("06");
                            break;
                        case "évora":
                            objCli.set_Distrito("07");
                            break;
                        case "faro":
                            objCli.set_Distrito("08");
                            break;
                        case "gurada":
                            objCli.set_Distrito("09");
                            break;
                        case "leiria":
                            objCli.set_Distrito("10");
                            break;
                        case "lisboa":
                            objCli.set_Distrito("11");
                            break;
                        case "portalegre":
                            objCli.set_Distrito("12");
                            break;
                        case "porto":
                            objCli.set_Distrito("13");
                            break;
                        case "santarém":
                            objCli.set_Distrito("14");
                            break;
                        case "setubal":
                            objCli.set_Distrito("15");
                            break;
                        case "viana do castelo":
                            objCli.set_Distrito("16");
                            break;
                        case "vila real":
                            objCli.set_Distrito("17");
                            break;
                        case "viseu":
                            objCli.set_Distrito("18");
                            break;
                        case "ilha da madeira":
                            objCli.set_Distrito("31");
                            break;
                    }

                        switch (cliente.Pais.ToLower())
                        {
                            case "angola":
                                objCli.set_Pais("AN");
                                break;
                            case "áustria":
                                objCli.set_Pais("AT");
                                break;
                            case "bélgica":
                                objCli.set_Pais("BE");
                                break;
                            case "brasil":
                                objCli.set_Pais("BR");
                                break;
                            case "alemanha":
                                objCli.set_Pais("DE");
                                break;
                            case "dinamarca":
                                objCli.set_Pais("DK");
                                break;
                            case "espanha":
                                objCli.set_Pais("ES");
                                break;
                            case "finlândia":
                                objCli.set_Pais("FI");
                                break;
                            case "frança":
                                objCli.set_Pais("FR");
                                break;
                            case "inglaterra":
                                objCli.set_Pais("GB");
                                break;
                            case "grécia":
                                objCli.set_Pais("GR");
                                break;
                            case "irlanda":
                                objCli.set_Pais("IE");
                                break;
                            case "itália":
                                objCli.set_Pais("IT");
                                break;
                            case "luxemburgo":
                                objCli.set_Pais("LU");
                                break;
                            case "holanda":
                                objCli.set_Pais("NL");
                                break;
                            case "portugal":
                                objCli.set_Pais("PT");
                                break;
                            case "suécia":
                                objCli.set_Pais("SE");
                                break;
                            case "estados unidos":
                                objCli.set_Pais("US");
                                break;
                        }

                        PriEngine.Engine.Comercial.Clientes.Actualiza(objCli);

                        erro.Erro = 0;
                        erro.Descricao = "Sucesso";
                        return erro;
                    }
                }
                else
                {
                    erro.Erro = 1;
                    erro.Descricao = "Erro ao abrir a empresa";
                    return erro;

                }

            }

            catch (Exception ex)
            {
                erro.Erro = 1;
                erro.Descricao = ex.Message;
                return erro;
            }

        }


        public static Lib_Primavera.Model.RespostaErro DelCliente(string codCliente)
        {

            Lib_Primavera.Model.RespostaErro erro = new Model.RespostaErro();
            GcpBECliente objCli = new GcpBECliente();


            try
            {

                if (PriEngine.InitializeCompany(FirstREST.Properties.Settings.Default.Company.Trim(), FirstREST.Properties.Settings.Default.User.Trim(), FirstREST.Properties.Settings.Default.Password.Trim()) == true)
                {
                    if (PriEngine.Engine.Comercial.Clientes.Existe(codCliente) == false)
                    {
                        erro.Erro = 1;
                        erro.Descricao = "O cliente não existe";
                        return erro;
                    }
                    else
                    {

                        PriEngine.Engine.Comercial.Clientes.Remove(codCliente);
                        erro.Erro = 0;
                        erro.Descricao = "Sucesso";
                        return erro;
                    }
                }

                else
                {
                    erro.Erro = 1;
                    erro.Descricao = "Erro ao abrir a empresa";
                    return erro;
                }
            }

            catch (Exception ex)
            {
                erro.Erro = 1;
                erro.Descricao = ex.Message;
                return erro;
            }

        }



        public static Lib_Primavera.Model.RespostaErro InsereClienteObj(Model.Cliente cli)
        {

            Lib_Primavera.Model.RespostaErro erro = new Model.RespostaErro();
            

            GcpBECliente myCli = new GcpBECliente();

            try
            {
                if (PriEngine.InitializeCompany(FirstREST.Properties.Settings.Default.Company.Trim(), FirstREST.Properties.Settings.Default.User.Trim(), FirstREST.Properties.Settings.Default.Password.Trim()) == true)
                {
                    System.Diagnostics.Debug.WriteLine("Tou aqui");
                    myCli.set_Cliente(cli.CodCliente);
                    myCli.set_Nome(cli.NomeCliente);
                    myCli.set_NumContribuinte(cli.NumContribuinte);
                    myCli.set_Morada(cli.Morada);
                    myCli.set_Localidade(cli.Localidade);
                    myCli.set_LocalidadeCodigoPostal(cli.Localidade);
                    myCli.set_CodigoPostal(cli.CodigoPostal);
                    myCli.set_Moeda("EUR");
                    System.Diagnostics.Debug.WriteLine("Tou aqui2");

                    switch (cli.Localidade.ToLower())
                    {
                        case "ignorado":
                            myCli.set_Distrito("00");
                            break;
                        case "aveiro":
                            myCli.set_Distrito("01");
                            break;
                        case "beja":
                            myCli.set_Distrito("02");
                            break;
                        case "braga":
                            myCli.set_Distrito("03");
                            break;
                        case "bragança":
                            myCli.set_Distrito("04");
                            break;
                        case "castelo branco":
                            myCli.set_Distrito("05");
                            break;
                        case "coimbra":
                            myCli.set_Distrito("06");
                            break;
                        case "évora":
                            myCli.set_Distrito("07");
                            break;
                        case "faro":
                            myCli.set_Distrito("08");
                            break;
                        case "gurada":
                            myCli.set_Distrito("09");
                            break;
                        case "leiria":
                            myCli.set_Distrito("10");
                            break;
                        case "lisboa":
                            myCli.set_Distrito("11");
                            break;
                        case "portalegre":
                            myCli.set_Distrito("12");
                            break;
                        case "porto":
                            myCli.set_Distrito("13");
                            break;
                        case "santarém":
                            myCli.set_Distrito("14");
                            break;
                        case "setubal":
                            myCli.set_Distrito("15");
                            break;
                        case "viana do castelo":
                            myCli.set_Distrito("16");
                            break;
                        case "vila real":
                            myCli.set_Distrito("17");
                            break;
                        case "viseu":
                            myCli.set_Distrito("18");
                            break;
                        case "ilha da madeira":
                            myCli.set_Distrito("31");
                            break;
                    }

                    switch (cli.Pais.ToLower())
                    {
                        case "angola": 
                            myCli.set_Pais("AN");
                            break;
                        case "áustria":
                            myCli.set_Pais("AT");
                            break;
                        case "bélgica":
                            myCli.set_Pais("BE");
                            break;
                        case "brasil":
                            myCli.set_Pais("BR");
                            break;
                        case "alemanha":
                            myCli.set_Pais("DE");
                            break;
                        case "dinamarca":
                            myCli.set_Pais("DK");
                            break;
                        case "espanha":
                            myCli.set_Pais("ES");
                            break;
                        case "finlândia":
                            myCli.set_Pais("FI");
                            break;
                        case "frança":
                            myCli.set_Pais("FR");
                            break;
                        case "inglaterra":
                            myCli.set_Pais("GB");
                            break;
                        case "grécia":
                            myCli.set_Pais("GR");
                            break;
                        case "irlanda":
                            myCli.set_Pais("IE");
                            break;
                        case "itália":
                            myCli.set_Pais("IT");
                            break;
                        case "luxemburgo":
                            myCli.set_Pais("LU");
                            break;
                        case "holanda":
                            myCli.set_Pais("NL");
                            break;
                        case "portugal":
                            myCli.set_Pais("PT");
                            break;
                        case "suécia":
                            myCli.set_Pais("SE");
                            break;
                        case "estados unidos":
                            myCli.set_Pais("US");
                            break;
                    }
                    System.Diagnostics.Debug.WriteLine("Tou aqui3");

                    PriEngine.Engine.Comercial.Clientes.Actualiza(myCli);
                    System.Diagnostics.Debug.WriteLine("Tou aqui4");
                    erro.Erro = 0;
                    erro.Descricao = "Sucesso";
                    return erro;
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("Tou a falhar no cliente");
                    System.Diagnostics.Debug.WriteLine(erro);
                    erro.Erro = 1;
                    erro.Descricao = "Erro ao abrir empresa";
                    return erro;
                }
            }

            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("excepçao");
                System.Diagnostics.Debug.WriteLine(ex.Message);
                erro.Erro = 1;
                erro.Descricao = ex.Message;

                return erro;
            }


        }

       

        #endregion Cliente;   // -----------------------------  END   CLIENTE    -----------------------


        #region Artigo

        public static Lib_Primavera.Model.Artigo GetArtigo(string codArtigo)
        {
            
            GcpBEArtigo objArtigo = new GcpBEArtigo();
            Model.Artigo myArt = new Model.Artigo();
            StdBECampos camposUtilizador = new StdBECampos();

            if (PriEngine.InitializeCompany(FirstREST.Properties.Settings.Default.Company.Trim(), FirstREST.Properties.Settings.Default.User.Trim(), FirstREST.Properties.Settings.Default.Password.Trim()) == true)
            {

                if (PriEngine.Engine.Comercial.Artigos.Existe(codArtigo) == false)
                {
                    return null;
                }
                else
                {
                    objArtigo = PriEngine.Engine.Comercial.Artigos.Edita(codArtigo);
                    myArt.CodArtigo = objArtigo.get_Artigo();
                    myArt.Nome = objArtigo.get_DescricaoComercial();
                    myArt.DescArtigo = objArtigo.get_Observacoes();
                    myArt.Categoria = objArtigo.get_Familia();
                    myArt.SubCategoria = objArtigo.get_SubFamilia();
                    myArt.Autor = objArtigo.get_Caracteristicas();
                    myArt.Editora = objArtigo.get_Marca();
                    
                    return myArt;
                }
                
            }
            else
            {
                return null;
            }

        }

        public static List<Model.Artigo> ListaArtigos()
        {
                        
            StdBELista objList;

            Model.Artigo art = new Model.Artigo();
            List<Model.Artigo> listArts = new List<Model.Artigo>();

            if (PriEngine.InitializeCompany(FirstREST.Properties.Settings.Default.Company.Trim(), FirstREST.Properties.Settings.Default.User.Trim(), FirstREST.Properties.Settings.Default.Password.Trim()) == true)
            {

                objList = PriEngine.Engine.Comercial.Artigos.LstArtigos();

                while (!objList.NoFim())
                {
                    art = new Model.Artigo();
                    art.CodArtigo = objList.Valor("artigo");
                    art.DescArtigo = objList.Valor("descricao");
  //                  art.STKAtual = objList.Valor("stkatual");
                  
                    
                    listArts.Add(art);
                    objList.Seguinte();
                }

                return listArts;

            }
            else
            {
                return null;

            }

        }

        public static List<Model.Artigo> StocksModificados()
        {

            StdBELista objList;

            Model.Artigo art = new Model.Artigo();

            objList = PriEngine.Engine.Consulta("SELECT Artigo, Armazem, StkActual From ArtigoArmazem where Alterado = 1");

            List<Model.Artigo> listArts = new List<Model.Artigo>();

            while (!objList.NoFim())
            {
                art.CodArtigo = objList.Valor("Artigo");

                string armazem = objList.Valor("Armazem");
                switch (armazem)
                {
                    case "ACOIM":
                        art.StockCoimbra = objList.Valor("StkActual");
                        break;
                    case "ALIS":
                        art.StockLisboa = objList.Valor("StkActual");
                        break;
                    case "AONL":
                        art.StockOnline = objList.Valor("StkActual");
                        break;
                    case "APOR":
                        art.StockPorto = objList.Valor("StkActual");
                        break;
                }

                listArts.Add(art);
                objList.Seguinte();
            }

            return listArts;
        }

        public static List<Model.Artigo> ArtigosModificados()
        {

            StdBELista objList;

            Model.Artigo art = new Model.Artigo();

            if (PriEngine.InitializeCompany(FirstREST.Properties.Settings.Default.Company.Trim(), FirstREST.Properties.Settings.Default.User.Trim(), FirstREST.Properties.Settings.Default.Password.Trim()) == true)
            {

                objList = PriEngine.Engine.Consulta("SELECT Artigo.Artigo, Familias.Descricao as Familia, SubFamilias.Descricao as SubFamilia, Marcas.Descricao as Marca, Artigo.Iva, Artigo.Observacoes, ArtigoIdioma.DescricaoComercial, ArtigoIdioma.Caracteristicas, ArtigoMoeda.PVP1, ArtigoMoeda.PVP2 From Artigo JOIN ArtigoIdioma ON Artigo.Artigo = ArtigoIdioma.Artigo JOIN ArtigoMoeda ON Artigo.Artigo = ArtigoMoeda.Artigo JOIN Familias ON Artigo.Familia = Familias.Familia JOIN SubFamilias ON Artigo.SubFamilia = SubFamilias.SubFamilia AND SubFamilias.Familia = Artigo.Familia JOIN Marcas ON Marcas.Marca = Artigo.Marca where Artigo.Alterado = 1");

                List<Model.Artigo> listArts = new List<Model.Artigo>();

                System.Diagnostics.Debug.WriteLine(objList.NumLinhas());

                while (!objList.NoFim())
                {
                    art = new Model.Artigo();
                    art.CodArtigo = objList.Valor("Artigo");
                    art.Nome = objList.Valor("DescricaoComercial");
                    art.Categoria = objList.Valor("Familia");
                    art.SubCategoria = objList.Valor("SubFamilia");
                    art.Editora = objList.Valor("Marca");
                    art.Iva = objList.Valor("Iva");
                    art.DescArtigo = objList.Valor("Observacoes");
                    art.Autor = objList.Valor("Caracteristicas");
                    art.Preco = objList.Valor("PVP1");
                    art.PrecoPromocional = objList.Valor("PVP2");

                    listArts.Add(art);
                    objList.Seguinte();
                }

                return listArts;

            }
            else
            {
                return null;

            }

        }

        #endregion Artigo

   

        #region DocCompra
        

        public static List<Model.DocCompra> VGR_List()
        {
                
            StdBELista objListCab;
            StdBELista objListLin;
            Model.DocCompra dc = new Model.DocCompra();
            List<Model.DocCompra> listdc = new List<Model.DocCompra>();
            Model.LinhaDocCompra lindc = new Model.LinhaDocCompra();
            List<Model.LinhaDocCompra> listlindc = new List<Model.LinhaDocCompra>();

            if (PriEngine.InitializeCompany(FirstREST.Properties.Settings.Default.Company.Trim(), FirstREST.Properties.Settings.Default.User.Trim(), FirstREST.Properties.Settings.Default.Password.Trim()) == true)
            {
                objListCab = PriEngine.Engine.Consulta("SELECT id, NumDocExterno, Entidade, DataDoc, NumDoc, TotalMerc, Serie From CabecCompras where TipoDoc='VGR'");
                while (!objListCab.NoFim())
                {
                    dc = new Model.DocCompra();
                    dc.id = objListCab.Valor("id");
                    dc.NumDocExterno = objListCab.Valor("NumDocExterno");
                    dc.Entidade = objListCab.Valor("Entidade");
                    dc.NumDoc = objListCab.Valor("NumDoc");
                    dc.Data = objListCab.Valor("DataDoc");
                    dc.TotalMerc = objListCab.Valor("TotalMerc");
                    dc.Serie = objListCab.Valor("Serie");
                    objListLin = PriEngine.Engine.Consulta("SELECT idCabecCompras, Artigo, Descricao, Quantidade, Unidade, PrecUnit, Desconto1, TotalILiquido, PrecoLiquido, Armazem, Lote from LinhasCompras where IdCabecCompras='" + dc.id + "' order By NumLinha");
                    listlindc = new List<Model.LinhaDocCompra>();

                    while (!objListLin.NoFim())
                    {
                        lindc = new Model.LinhaDocCompra();
                        lindc.IdCabecDoc = objListLin.Valor("idCabecCompras");
                        lindc.CodArtigo = objListLin.Valor("Artigo");
                        lindc.DescArtigo = objListLin.Valor("Descricao");
                        lindc.Quantidade = objListLin.Valor("Quantidade");
                        lindc.Unidade = objListLin.Valor("Unidade");
                        lindc.Desconto = objListLin.Valor("Desconto1");
                        lindc.PrecoUnitario = objListLin.Valor("PrecUnit");
                        lindc.TotalILiquido = objListLin.Valor("TotalILiquido");
                        lindc.TotalLiquido = objListLin.Valor("PrecoLiquido");
                        lindc.Armazem = objListLin.Valor("Armazem");
                        lindc.Lote = objListLin.Valor("Lote");

                        listlindc.Add(lindc);
                        objListLin.Seguinte();
                    }

                    dc.LinhasDoc = listlindc;
                    
                    listdc.Add(dc);
                    objListCab.Seguinte();
                }
            }
            return listdc;
        }

                
        public static Model.RespostaErro VGR_New(Model.DocCompra dc)
        {
            Lib_Primavera.Model.RespostaErro erro = new Model.RespostaErro();
            

            GcpBEDocumentoCompra myGR = new GcpBEDocumentoCompra();
            GcpBELinhaDocumentoCompra myLin = new GcpBELinhaDocumentoCompra();
            GcpBELinhasDocumentoCompra myLinhas = new GcpBELinhasDocumentoCompra();

            PreencheRelacaoCompras rl = new PreencheRelacaoCompras();
            List<Model.LinhaDocCompra> lstlindv = new List<Model.LinhaDocCompra>();

            try
            {
                if (PriEngine.InitializeCompany(FirstREST.Properties.Settings.Default.Company.Trim(), FirstREST.Properties.Settings.Default.User.Trim(), FirstREST.Properties.Settings.Default.Password.Trim()) == true)
                {
                    // Atribui valores ao cabecalho do doc
                    //myEnc.set_DataDoc(dv.Data);
                    myGR.set_Entidade(dc.Entidade);
                    myGR.set_NumDocExterno(dc.NumDocExterno);
                    myGR.set_Serie(dc.Serie);
                    myGR.set_Tipodoc("VGR");
                    myGR.set_TipoEntidade("F");
                    // Linhas do documento para a lista de linhas
                    lstlindv = dc.LinhasDoc;
                    //PriEngine.Engine.Comercial.Compras.PreencheDadosRelacionados(myGR,rl);
                    PriEngine.Engine.Comercial.Compras.PreencheDadosRelacionados(myGR);
                    foreach (Model.LinhaDocCompra lin in lstlindv)
                    {
                        PriEngine.Engine.Comercial.Compras.AdicionaLinha(myGR, lin.CodArtigo, lin.Quantidade, lin.Armazem, "", lin.PrecoUnitario, lin.Desconto);
                    }


                    PriEngine.Engine.IniciaTransaccao();
                    PriEngine.Engine.Comercial.Compras.Actualiza(myGR, "Teste");
                    PriEngine.Engine.TerminaTransaccao();
                    erro.Erro = 0;
                    erro.Descricao = "Sucesso";
                    return erro;
                }
                else
                {
                    erro.Erro = 1;
                    erro.Descricao = "Erro ao abrir empresa";
                    return erro;

                }

            }
            catch (Exception ex)
            {
                PriEngine.Engine.DesfazTransaccao();
                erro.Erro = 1;
                erro.Descricao = ex.Message;
                return erro;
            }
        }


        #endregion DocCompra


        #region DocsVenda

        public static Model.RespostaErro Encomendas_New(Model.DocVenda dv)
        {
            Lib_Primavera.Model.RespostaErro erro = new Model.RespostaErro();
            GcpBEDocumentoVenda myEnc = new GcpBEDocumentoVenda();
             
            GcpBELinhaDocumentoVenda myLin = new GcpBELinhaDocumentoVenda();

            GcpBELinhasDocumentoVenda myLinhas = new GcpBELinhasDocumentoVenda();
             
            PreencheRelacaoVendas rl = new PreencheRelacaoVendas();
            List<Model.LinhaDocVenda> lstlindv = new List<Model.LinhaDocVenda>();

            GcpBEArtigoMoeda objArtigoMoeda = new GcpBEArtigoMoeda();

            try
            {
                if (PriEngine.InitializeCompany(FirstREST.Properties.Settings.Default.Company.Trim(), FirstREST.Properties.Settings.Default.User.Trim(), FirstREST.Properties.Settings.Default.Password.Trim()) == true)
                {
                    // Atribui valores ao cabecalho do doc
                    //myEnc.set_DataDoc(dv.Data);
                    myEnc.set_Entidade(dv.Entidade);
                    myEnc.set_Serie(dv.Serie);
                    myEnc.set_Tipodoc("ECL");
                    myEnc.set_TipoEntidade("C");
                    myEnc.set_CondPag("1");
                    // Linhas do documento para a lista de linhas
                    lstlindv = dv.LinhasDoc;
                    //PriEngine.Engine.Comercial.Vendas.PreencheDadosRelacionados(myEnc, rl);
                    PriEngine.Engine.Comercial.Vendas.PreencheDadosRelacionados(myEnc);
                    myEnc.set_ModoPag("TRA");
                    foreach (Model.LinhaDocVenda lin in lstlindv)
                    {
                        objArtigoMoeda = PriEngine.Engine.Comercial.ArtigosPrecos.Edita(lin.CodArtigo, "EUR", "UN");
                        PriEngine.Engine.Comercial.Vendas.AdicionaLinha(myEnc, lin.CodArtigo, lin.Quantidade, "", "", objArtigoMoeda.get_PVP1(), 0);
                    }


                   // PriEngine.Engine.Comercial.Compras.TransformaDocumento(
                    PriEngine.Engine.IniciaTransaccao();
                    //PriEngine.Engine.Comercial.Vendas.Edita Actualiza(myEnc, "Teste");
                    PriEngine.Engine.Comercial.Vendas.Actualiza(myEnc);
                    PriEngine.Engine.TerminaTransaccao();
                    erro.Erro = 0;
                    erro.Descricao = "Sucesso";
                    return erro;
                }
                else
                {
                    erro.Erro = 1;
                    erro.Descricao = "Erro ao abrir empresa";
                    return erro;

                }

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
                PriEngine.Engine.DesfazTransaccao();
                erro.Erro = 1;
                erro.Descricao = ex.Message;
                return erro;
            }
        }

     

        public static List<Model.DocVenda> Encomendas_List(string numcliente)
        {
            
            StdBELista objListCab;
            StdBELista objListLin;
            Model.DocVenda dv = new Model.DocVenda();
            List<Model.DocVenda> listdv = new List<Model.DocVenda>();
            Model.LinhaDocVenda lindv = new Model.LinhaDocVenda();
            List<Model.LinhaDocVenda> listlindv = new
            List<Model.LinhaDocVenda>();

            try {
            if (PriEngine.InitializeCompany(FirstREST.Properties.Settings.Default.Company.Trim(), FirstREST.Properties.Settings.Default.User.Trim(), FirstREST.Properties.Settings.Default.Password.Trim()) == true)
            {
                objListCab = PriEngine.Engine.Consulta("SELECT id, Estado, NumDoc From CabecDoc JOIN CabecDocStatus ON CabecDoc.Id = CabecDocStatus.IdCabecDoc where TipoDoc='ECL' and Entidade='" + numcliente + "'");
                while (!objListCab.NoFim())
                {
                    dv = new Model.DocVenda();
                    dv.id = objListCab.Valor("id");
                   // dv.Entidade = objListCab.Valor("Entidade");
                    dv.NumDoc = objListCab.Valor("NumDoc");
                    //dv.Data = objListCab.Valor("Data");
                    //dv.TotalMerc = objListCab.Valor("TotalMerc");
                    //dv.Serie = objListCab.Valor("Serie");
                    dv.Estado = objListCab.Valor("Estado");
                    //objListLin = PriEngine.Engine.Consulta("SELECT idCabecDoc, Artigo, Descricao, Quantidade, Unidade, PrecUnit, Desconto1, TotalILiquido, PrecoLiquido from LinhasDoc where IdCabecDoc='" + dv.id + "' order By NumLinha");
                    //listlindv = new List<Model.LinhaDocVenda>();

                    /*while (!objListLin.NoFim())
                    {
                        lindv = new Model.LinhaDocVenda();
                        lindv.IdCabecDoc = objListLin.Valor("idCabecDoc");
                        lindv.CodArtigo = objListLin.Valor("Artigo");
                        lindv.DescArtigo = objListLin.Valor("Descricao");
                        lindv.Quantidade = objListLin.Valor("Quantidade");
                        lindv.Unidade = objListLin.Valor("Unidade");
                        lindv.Desconto = objListLin.Valor("Desconto1");
                        lindv.PrecoUnitario = objListLin.Valor("PrecUnit");
                        lindv.TotalILiquido = objListLin.Valor("TotalILiquido");
                        lindv.TotalLiquido = objListLin.Valor("PrecoLiquido");

                        listlindv.Add(lindv);
                        objListLin.Seguinte();
                    }*/

                    //dv.LinhasDoc = listlindv;
                    listdv.Add(dv);
                    objListCab.Seguinte();
                }
            }
            return listdv;
        }
        catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
                List<Model.DocVenda> ret = new List<Model.DocVenda>();
                return ret;
            }
        }

       

        public static Model.DocVenda Encomenda_Get(string numdoc)
        {
            
            
            StdBELista objListCab;
            StdBELista objListLin;
            Model.DocVenda dv = new Model.DocVenda();
            Model.LinhaDocVenda lindv = new Model.LinhaDocVenda();
            List<Model.LinhaDocVenda> listlindv = new List<Model.LinhaDocVenda>();

            if (PriEngine.InitializeCompany(FirstREST.Properties.Settings.Default.Company.Trim(), FirstREST.Properties.Settings.Default.User.Trim(), FirstREST.Properties.Settings.Default.Password.Trim()) == true)
            {
                

                string st = "SELECT id, Entidade, Data, NumDoc, TotalMerc, Serie, Estado From CabecDoc JOIN CabecDocStatus where TipoDoc='ECL' and NumDoc='" + numdoc + "'";
                objListCab = PriEngine.Engine.Consulta(st);
                dv = new Model.DocVenda();
                dv.id = objListCab.Valor("id");
                dv.Entidade = objListCab.Valor("Entidade");
                dv.NumDoc = objListCab.Valor("NumDoc");
                dv.Data = objListCab.Valor("Data");
                dv.TotalMerc = objListCab.Valor("TotalMerc");
                dv.Serie = objListCab.Valor("Serie");
                dv.Estado = objListCab.Valor("Estado");
                objListLin = PriEngine.Engine.Consulta("SELECT idCabecDoc, Artigo, Descricao, Quantidade, Unidade, PrecUnit, Desconto1, TotalILiquido, PrecoLiquido from LinhasDoc where IdCabecDoc='" + dv.id + "' order By NumLinha");
                listlindv = new List<Model.LinhaDocVenda>();

                while (!objListLin.NoFim())
                {
                    lindv = new Model.LinhaDocVenda();
                    lindv.IdCabecDoc = objListLin.Valor("idCabecDoc");
                    lindv.CodArtigo = objListLin.Valor("Artigo");
                    lindv.DescArtigo = objListLin.Valor("Descricao");
                    lindv.Quantidade = objListLin.Valor("Quantidade");
                    lindv.Unidade = objListLin.Valor("Unidade");
                    lindv.Desconto = objListLin.Valor("Desconto1");
                    lindv.PrecoUnitario = objListLin.Valor("PrecUnit");
                    lindv.TotalILiquido = objListLin.Valor("TotalILiquido");
                    lindv.TotalLiquido = objListLin.Valor("PrecoLiquido");
                    listlindv.Add(lindv);
                    objListLin.Seguinte();
                }

                dv.LinhasDoc = listlindv;
                return dv;
            }
            return null;
        }

        public static List<Model.DocVenda> DocumentsModificados()
        {

            StdBELista objList;

            Model.DocVenda doc = new Model.DocVenda();

            objList = PriEngine.Engine.Consulta("SELECT Artigo, Armazem, StkActual From ArtigoArmazem where Alterado = 1");

            List<Model.DocVenda> listDocs = new List<Model.DocVenda>();

         

                listDocs.Add(doc);
                objList.Seguinte();
            

            return listDocs;
        }

        #endregion DocsVenda

        #region Ficheiros

        public static void ImprimeDocumento(string tipoDoc, string serie, int numDoc, string destino)
        {
            PriEngine.Engine.Comercial.Vendas.ImprimeDocumento(tipoDoc, serie, numDoc, "000", 2, null, false, destino, 1);
        }

        #endregion Ficheiros
    }
}