{include file='owner/common/header.tpl'}
<!-- page content -->
<div class="right_col" role="main">
  <div class="">
    <div class="page-title">
      <div class="title_left">
        <h3>Gestão de Perguntas</h3>
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
                <label class="control-label col-md-2 col-sm-0 col-xs-12">Nome Utilizador:</label>
                <div class="col-md-9 col-sm-9 col-xs-12">
                  <input type="text" class="form-control" id="nome_utilizador" placeholder="Nome do Utilizador">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-0 col-xs-12">Email Utilizador:</label>
                <div class="col-md-9 col-sm-9 col-xs-12">
                  <input type="text" class="form-control" id="email_utilizador" placeholder="Email do Utilizador">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-0 col-xs-12">Estado:</label>
                <div class="col-md-9 col-sm-9 col-xs-12">
                  <select id="estadoPergunta" class="form-control">
                    <option>Escolha uma opção</option>
                    <option value="true">Respondida</option>
                    <option value="false">Não respondida</option>
                  </select>
                </div>
              </div>

              <div class="clearfix"></div>
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

    <!-- Orders -->
    <div class="row">
      <div class="col-md-12">
        <div class="x_panel">
          <div class="x_title">
            <h2>Perguntas</h2>
            <ul class="nav navbar-right panel_toolbox">
              <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
              </li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="question_content x_content">
            <p>Perguntas listadas da loja</p>
            <!-- start of orders list -->
            {if $allQuestions}
            <table class="table table-striped projects" id="myTable">
              <thead>
                <tr>
                  <th id="questionByName">Nome Utilizador <span class="glyphicon glyphicon-sort"></span></th>
                  <th id="questionByDate">Data <span class="glyphicon glyphicon-sort"></span></th>
                  <th id="questionByStatus">Estado <span class="glyphicon glyphicon-sort"></span></th>
                  <th>Mensagem</th>
                  <th>Ações</th>
                </tr>
              </thead>
              <tbody>
                {foreach $allQuestions as $question}
                <tr>
                  <td>{$question.nome}</td>
                  <td>{$question.data|date_format:$parsedata.fulldata}</td>
                  <td>
                    {if $question.respondido == TRUE}
                    <button class="btn btn-success btn-xs">Respondido</button>
                    {else}
                    <button class="btn btn-warning btn-xs">Não respondido</button>
                    {/if}
                  </td>
                  <td>{$question.mensagem}</td>
                  <td>
                    <a href="{$BASE_URL}actions/owner/question_status.php?id={$question.perguntautilizadorid}" class="btn btn-info btn-xs"><i class="fa fa-pencil"></i> Mudar Estado </a>
                    <!-- <a value="{$question.perguntautilizadorid}" class="btn btn-info btn-xs" id="updateStatus"><i class="fa fa-pencil"></i> Mudar Estado </a> -->
                  </td>
                </tr>
                {/foreach}
              </tbody>
            </table>
            {else}
            <span>Não existem Perguntas</span>
            {/if}
            <!-- end of orders list -->
          </div>
        </div>
      </div>
    </div>
    <!-- end of Orders -->
  </div>
</div>
<!-- /page content -->
{include file='owner/common/footer.tpl'}
<script src="{$BASE_URL}javascript/owner/questions.js"></script>
<script src="{$BASE_URL}javascript/utilities.js"></script>