{include file='admin/common/header.tpl'}
<!-- page content -->
<div class="right_col" role="main">
  <div class="">
    <div class="page-title">
      <div class="title_left">
        <h3>Gestão de Comentários</h3>
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
            <form class="form-horizontal form-label-left input_mask">

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-0 col-xs-12">Nome do Cliente:</label>
                <div class="col-md-9 col-sm-9 col-xs-12">
                  <input type="text" class="form-control" id="nome_cliente" placeholder="Nome do Cliente">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-0 col-xs-12">Email do Cliente:</label>
                <div class="col-md-9 col-sm-9 col-xs-12">
                  <input type="text" class="form-control" id="email_cliente" placeholder="Email do Cliente">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-0 col-xs-12">Nome da Publicação:</label>
                <div class="col-md-9 col-sm-9 col-xs-12">
                  <input type="text" class="form-control" id="nome_publicacao" placeholder="Nome da Publicação">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-0 col-xs-12">Comentário:</label>
                <div class="col-md-9 col-sm-9 col-xs-12">
                  <input type="text" class="form-control" id="comments" placeholder="Comentário">
                </div>
              </div>

              <div class="ln_solid"></div>
              <div class="form-group">
                <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset">
                  <button class="btn btn-primary" id="clean" type="button">Limpar</button>
                  <button id="search" type="button" type=submit class="btn btn-success">Submeter</button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
    <!-- end of Filters -->

    <!-- Content -->
    <div class="row">
      <div class="col-md-12">
        <div class="x_panel">
          <div class="x_title">
            <h2>Comentários e Classificações</h2>
            <ul class="nav navbar-right panel_toolbox">
              <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
              </li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="comment_content x_content">
            <p>Comentários das publicações na loja</p>
            <!-- start of list -->
            {if $allcomments}
            <table class="table table-striped projects" id="myTable">
              <thead>
                <tr>
                  <th style="width: 6%" id="orderById">ID <span class="glyphicon glyphicon-sort"></span></th>
                  <th style="width: 14%" id="orderByPublicationName">Nome da Publicação <span class="glyphicon glyphicon-sort"></span></th>
                  <th style="width: 14%" id="orderByCLientName">Nome do Cliente <span class="glyphicon glyphicon-sort"></span></th>
                  <th style="width: 10%" id="orderByClassification">Classificação <span class="glyphicon glyphicon-sort"></span></th>
                  <th style="width: 19%">Comentário</th>
                  <th style="width: 14%">Ações </th>
                </tr>
              </thead>
              <tbody>
                {foreach $allcomments as $comment}
                <tr>
                  <td>{$comment.comentarioid}</td>
                  <td>
                    <a>{$comment.titulo}</a>
                  </td>
                  <td>
                    <a>{$comment.nome}</a>
                  </td>
                  <td>
                    <a class="fa fa-star"> {$comment.classificacao}</a>
                  </td>
                  <td>
                    <a>{$comment.texto}</a>
                  </td>
                  <td>
                    <a href="{$BASE_URL}pages/publications/publication.php?id={$comment.publicacaoid}" class="btn btn-primary btn-xs"><i class="fa fa-folder"></i> Ver </a>
                    <a href="{$BASE_URL}actions/admin/comment_remove.php?id={$comment.comentarioid}" class="btn btn-danger btn-xs"><i class="fa fa-trash-o"></i> Eleminar </a>
                  </td>
                </tr>
                {/foreach}
              </tbody>
            </table>
            {/if}
            <!-- end list -->
          </div>
        </div>
      </div>
    </div>
    <!-- end of Content -->
  </div>
</div>
<!-- /page content -->

{include file='admin/common/footer.tpl'}
<script src="{$BASE_URL}javascript/admin/comment_search.js"></script>
<script src="{$BASE_URL}javascript/utilities.js"></script>