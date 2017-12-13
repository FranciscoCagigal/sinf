{include file='admin/common/header.tpl'}
<!-- page content -->
<div class="right_col" role="main">
  <div class="">
    <div class="page-title">
      <div class="title_left">
        <h3>Gestão de Publicações</h3>
      </div>
    </div>

    <div class="clearfix"></div>

    <!-- Content -->
    <div class="row">
      <div class="col-md-12 col-sm-12 col-xs-12">
        <div class="x_panel">

          <div class="x_title">
            <h2>Editar Publicação: <span>{$publicationData.titulo}</span></h2>
            <ul class="nav navbar-right panel_toolbox">
              <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
              </li>
            </ul>
            <div class="clearfix"></div>
          </div>

          <div class="x_content">
            <form action="{$BASE_URL}actions/admin/publication_edit.php" method="post" enctype="multipart/form-data" class="form-horizontal form-label-left input_mask">

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-3 col-xs-12">Titulo *</label>
                <div class="col-md-10 col-sm-3 col-xs-12">
                  <input type="text" class="form-control" name="titulo" readonly="readonly" value="{$publicationData.titulo}" placeholder="Titulo da Publicação">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-3 col-xs-12">Descrição </span>
                </label>
                <div class="col-md-10 col-sm-9 col-xs-12">
                  <textarea class="form-control" rows="3" name="descricao" readonly="readonly" placeholder="Descrição da Publicação">{$publicationData.descricao}</textarea>
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-3 col-xs-12">Editora <span class="required">*</span></label>
                <div class="col-md-10 col-sm-3 col-xs-12">
                  <input type="text" class="form-control" readonly="readonly" name="editora" value="{$publicationData.nome_editora}" placeholder="Nome da Editora da Publicação">
                </div>
              </div>

              <div class="form-group">

                <label class="control-label col-md-2 col-sm-3 col-xs-12">Categoria <span class="required">*</span> </label>
                <div class="col-md-4 col-sm-3 col-xs-12">
                  <select class="form-control" readonly="readonly" name="categoria" id="categoria" placeholder="Nome da Categoria da Publicação">
                    {foreach $allCategorys as $category}
                    <option value="{$category.categoriaid}" {if $publicationData.id_categoria == $category.categoriaid}selected{/if}>{$category.nome}</option>
                    {/foreach}
                  </select>
                </div>

                <label class="control-label col-md-2 col-sm-3 col-xs-12">Sub-Categoria <span class="required">*</span> </label>
                <div class="col-md-4 col-sm-3 col-xs-12">
                  <select class="form-control" readonly="readonly" name="subcategoria" id="subcategoria" placeholder="Nome da Sub-Categoria da Publicação">
                    {foreach $allSubCategories as $subcategory}
                    <option value="{$subcategory.subcategoriaid}" {if $publicationData.id_subcategoria == $subcategory.subcategoriaid}selected{/if}>{$subcategory.nome}</option>
                    {/foreach}
                  </select>
                </div>
              </div>

              <div class="form-group">
                <!-- DATA -->
                <label class="control-label col-md-2 col-sm-3 col-xs-12">Data da Publicação *
                </label>
                <div class="col-md-4 col-sm-6 col-xs-12 has-feedback">
                  <input type="text" class="form-control has-feedback-left" name="datapublicacao" value="{$publicationData.datapublicacao}" aria-describedby="inputSuccess2Status4" placeholder="YYYY-MM-DD">
                  <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
                  <span id="inputSuccess2Status4" class="sr-only">(success)</span>
                </div>

                <label class="control-label col-md-2 col-sm-3 col-xs-12">Stock *</label>
                <div class="col-md-4 col-sm-3 col-xs-12">
                  <input type="number" min="1" class="form-control" name="stock" readonly="readonly" value="{$publicationData.stock}" placeholder="Stock da Publicação">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-3 col-xs-12">Peso (gr) *</label>
                <div class="col-md-4 col-sm-3 col-xs-12">
                  <input type="number" step="0.001" min="0.001" class="form-control" name="peso" value="{$publicationData.peso}" placeholder="Peso da Publicação (gr)">
                </div>

                <label class="control-label col-md-2 col-sm-3 col-xs-12">Páginas </label>
                <div class="col-md-4 col-sm-3 col-xs-12">
                  <input type="number" min="0" class="form-control" name="nrpaginas" value="{$publicationData.paginas}" placeholder="Número de páginas da Publicação">
                </div>
              </div>

              <div id="div_preco" class="form-group">
                <label class="control-label col-md-2 col-sm-3 col-xs-12">Preço *</label>
                <div class="col-md-4 col-sm-3 col-xs-12">
                  <input  id="preco" type="number" step="0.01" min="0.01" class="form-control" name="preco" readonly="readonly" value="{$publicationData.preco}" placeholder="Preço da Publicação">
                  <span class="help-block with-errors" data-valmsg-for="preco" data-valmsg-replace="true"></span>
                </div>

                <label class="control-label col-md-2 col-sm-3 col-xs-12">Preço Promocional </label>
                <div class="col-md-4 col-sm-3 col-xs-12">
                  <input id="preco_promocional" type="number" step="0.01" min="0.0" class="form-control" name="precopromocional" readonly="readonly" value="{$publicationData.precopromocional}" placeholder="Preço Promocional da Publicação">
                   <span class="help-block with-errors" data-valmsg-for="preco_promocional" data-valmsg-replace="true"></span>
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-3 col-xs-12">Código de Barras </label>
                <div class="col-md-4 col-sm-3 col-xs-12">
                  <input type="number" min="0" class="form-control" name="codigobarras" readonly="readonly" value="{$publicationData.codigobarras}" placeholder="Código de Barras da Publicação">
                </div>

                <label class="control-label col-md-2 col-sm-3 col-xs-12">ISBN </label>
                <div class="col-md-4 col-sm-3 col-xs-12">
                  <input type="text" class="form-control" name="isbn" value="{$publicationData.isbn}" placeholder="ISBN da Publicação">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-3 col-xs-12">Edição </label>
                <div class="col-md-4 col-sm-3 col-xs-12">
                  <input type="text" class="form-control" name="edicao" value="{$publicationData.edicao}" placeholder="Edição da Publicação">
                </div>

                <label class="control-label col-md-2 col-sm-3 col-xs-12">Periodicidade </label>
                <div class="col-md-4 col-sm-3 col-xs-12">
                  <select class="form-control" name="periodicidade">
                    <option>Escolha uma opção</option>
                    {if $publicationData.periodicidade == "Diario"}
                    <option value="Diario" selected>Diário</option>
                    {else}
                    <option value="Diario">Diário</option>
                    {/if}
                    {if $publicationData.periodicidade == "Semanal"}
                    <option value="Semanal" selected>Semanal</option>
                    {else}
                    <option value="Semanal">Semanal</option>
                    {/if}
                    {if $publicationData.periodicidade == "Mensal"}
                    <option value="Mensal" selected>Mensal</option>
                    {else}
                    <option value="Mensal">Mensal</option>
                    {/if}
                    {if $publicationData.periodicidade == "Anual"}
                    <option value="Mensal" selected>Anual</option>
                    {else}
                    <option value="Mensal">Anual</option>
                    {/if}
                  </select>
                </div>
              </div>

              <div class="form-group">
                <label class="col-md-6 col-sm-9 col-xs-12 control-label">Novidade</span>
                </label>
                <div class="col-md-4 col-sm-9 col-xs-12">
                  <div class="radio">
                    <label>
                      <input type="radio" {if $publicationData.novidade == TRUE}checked=""{/if} value="TRUE" name="novidade"> Sim
                    </label>
                    <label>
                      <input type="radio" {if $publicationData.novidade == FALSE}checked=""{/if}value="FALSE" name="novidade"> Não
                    </label>
                  </div>
                </div>
              </div>

              <div class="clearfix"></div>
              <div class="ln_solid"></div>


              <div class="form-group">
                <label class="control-label col-md-2 col-sm-3 col-xs-12">Autor </label>
                <div class="col-md-10 col-sm-3 col-xs-12">
                  <select class="form-control" name="autor" id="autor" readonly="readonly" placeholder="Nome do Autor">
                    <option value="6">Sem Autor</option>
                    <option value="novoAutor">Novo Autor</option>
                    {foreach $allAutors as $autor}
                    <option value="{$autor.autorid}" {if $publicationData.id_autor ==$autor.autorid}selected{/if}>{$autor.nome}</option>
                    {/foreach}
                  </select>
                </div>
              </div>

              <div class="clearfix"></div>
              <div class="ln_solid"></div>

              <div class="form-group">
                <p>Imagem do Produto</p>
                <div class="col-md-55">
                  <a class="thumbnail fancybox" rel="ligthbox" href="{$BASE_URL}{$publicationData.url}">
                    <img class="img-responsive" alt="{$publicationData.titulo}" src="{$BASE_URL}{$publicationData.url}" />
                  </a>
                  <div class="col-md-55">
                    <input type="file" name="fileUpload">
                  </div>
                </div>
              </div>

              <div class="clearfix"></div>
              <div class="ln_solid"></div>

              <div class="form-group">
                <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset">
                  <input type="hidden" name="publication_id" value="{$publicationData.publicacaoid}">
                  <a href="{$BASE_URL}pages/admin/publications.php" type="button" class="btn btn-primary">Cancelar</a>
                  <button class="btn btn-primary" type="reset">Limpar</button>
                  <button id="submit" type="submit" class="btn btn-success">Submeter</button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
    <!-- end of Content -->
  </div>
</div>
<!-- /page content -->
{include file='admin/common/footer.tpl'}
<script src="{$BASE_URL}javascript/admin/publication.js"></script>