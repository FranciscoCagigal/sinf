{include file='owner/common/header.tpl'}
<!-- page content -->
<div class="right_col" role="main">
  <div class="">
    <div class="page-title">
      <div class="title_left">
        <h3>Gestão de Publicações</h3>
      </div>
    </div>

    <div class="clearfix"></div>

    <!-- Filters -->
    <div class="row">
      <div class="col-md-12 col-sm-12 col-xs-12">
        <div class="x_panel">
          <div class="x_title">
            <h2>Filtros de pesquisa</h2>
            <ul class="nav navbar-right panel_toolbox">
              <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
              </li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="x_content">
            <br />
            <form class="form-horizontal form-label-left input_mask">

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-0 col-xs-12">Nome:</label>
                <div class="col-md-9 col-sm-9 col-xs-12">
                  <input type="text" class="form-control" id="nome_livro" placeholder="Nome do livro">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-0 col-xs-12">Autor:</label>
                <div class="col-md-9 col-sm-9 col-xs-12">
                  <input type="text" class="form-control" id="nome_autor" placeholder="Nome do Autor">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-0 col-xs-12">Editora:</label>
                <div class="col-md-9 col-sm-9 col-xs-12">
                  <input type="text" class="form-control" id="nome_editora" placeholder="Nome da Editora">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-0 col-xs-12">Categoria:</label>
                <div class="col-md-9 col-sm-9 col-xs-15">
                  <select class="form-control" required="required" name="categoria" id="categoria">
                    <option>Escolha uma opção</option>
                    {foreach $allCategorys as $category}
                    <option value="{$category.categoriaid}">{$category.nome}</option>
                    {/foreach}
                  </select>
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-0 col-xs-12">Sub-Categoria:</label>
                <div class="col-md-9 col-sm-9 col-xs-12">
                  <select class="form-control" name="subcategoria" id="subcategoria">
                    <option>Escolha uma opção</option>
                  </select>
                </div>
              </div>
              
              <div class="ln_solid"></div>
              <div class="form-group">
                <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset">
                  <button type="button" id="clean" class="btn btn-primary" type="reset">Limpar</button>
                  <button type="button" id="search" class="btn btn-success">Submeter</button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
    <!-- end of Filters -->

    <!-- Books -->
    <div class="row">
      <div class="col-md-12">
        <div class="x_panel">
          <div class="x_title">
            <h2>Publicações</h2>
            <ul class="nav navbar-right panel_toolbox">
              <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
              </li>
              <li><div class="x_content">
                <a href="{$BASE_URL}pages/owner/publication_add.php"type="button" class="btn btn-round btn-success btn-xs">Adicionar</a>
              </div>
            </li>
          </ul>
          <div class="clearfix"></div>
        </div>
        <div class="publications_content x_content">
          <p>Todos as publicações presentes na loja</p>
          <!-- start of books list -->
          {if $allPublications}
          <table class="table table-striped projects" id="myTable">
            <thead>
              <tr>
                <th style="width: 6%" id="orderByID" >ID <span class="glyphicon glyphicon-sort"></span></th>
                <th style="width: 30%" id="orderByBookName">Nome do livro <span class="glyphicon glyphicon-sort"></span></th>
                <th id="orderByAuthorName">Nome do Autor <span class="glyphicon glyphicon-sort"></span></th>
                <th id="orderByPrice">Preço <span class="glyphicon glyphicon-sort"></span></th>
                <th style="width: 20%" id="orderByPromotionalPrice">Preço Promocional <span class="glyphicon glyphicon-sort"></span></th>
                <th>Ações</th>
              </tr>
            </thead>
            <tbody>
              {foreach $allPublications as $publication}
              <tr>
                <td>{$publication.publicacaoid}</td>
                <td>
                  <a>{$publication.titulo}</a>
                </td>
                <td>
                  {if $publication.nome_autor}
                  <a>{$publication.nome_autor}</a>
                  {else}
                  <a>Sem Autor</a>
                  {/if}
                </td>
                <td>
                  <a>{$publication.preco|string_format:"%.2f"}€</a>
                </td>
                <td>
                  <a>{$publication.precopromocional|string_format:"%.2f"}€</a>
                </td>
                <td>
                  <a href="{$BASE_URL}pages/publications/publication.php?id={$publication.publicacaoid}" class="btn btn-primary btn-xs"><i class="fa fa-folder"></i> Ver </a>
                  <a href="{$BASE_URL}pages/owner/publication_edit.php?id={$publication.publicacaoid}" class="btn btn-info btn-xs"><i class="fa fa-pencil"></i> Editar </a>
                </td>
              </tr>
              {/foreach}
            </tbody>
          </table>
          {else}
          <span>Não existem Publicações</span>
          {/if}
          <!-- end of books list -->
        </div>
      </div>
    </div>
  </div>
  <!-- end of Books -->
</div>
</div>
<!-- /page content -->
{include file='owner/common/footer.tpl'}
<script src="{$BASE_URL}javascript/owner/publications_search.js"></script>
<script src="{$BASE_URL}javascript/utilities.js"></script>