{include file='common/header.tpl'}

<div class="breadcrumbs">
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <ul>
                    <li><a href="?page=home">Página inicial</a></li>
                    <li class="active">Pesquisa</li>
                </ul><!-- end breadcrumb -->
            </div><!-- end col -->    
        </div><!-- end row -->
    </div><!-- end container -->
</div><!-- end breadcrumbs -->

<!-- start section -->
<section class="section white-backgorund">
    <div class="container">
        <div class="row">
            <!-- start sidebar -->
            <div class="col-sm-3">
                <div class="widget">
                    <h6 class="subtitle">Pesquisa</h6>

                    <form>
                        <input type="text" id="lastname" class="form-control input-sm" placeholder="Pesquisa">
                    </form>
                </div><!-- end widget -->

                <div class="widget">
                   <h6 class="subtitle">Categorias</h6>
                   <select class="form-control" name="categoria" id="categoria-form">
                    {foreach $category as $c}
                    {if $c.nome == $def_cat}
                    <option value="{$c.categoriaid}" selected="selected">{$c.nome}</option>
                    {else}
                    <option value="{$c.categoriaid}">{$c.nome}</option>
                    {/if}
                    {/foreach}
                </select>
            </div><!-- end widget -->

            <div class="widget">
               <h6 class="subtitle">Subcategorias</h6>
               <select class="form-control" name="subcategoria" id="subcategoria-form">
                   {foreach $def_subcat_array as $sub}
                   {if $sub.nome == $def_subcat}
                   <option value="{$sub.subcategoriaid}" selected="selected">{$sub.nome}</option>
                   {else}
                   <option value="{$sub.subcategoriaid}">{$sub.nome}</option>
                   {/if}
                   {/foreach}
               </select>
           </div><!-- end widget -->

           <div class="widget">
            <h6 class="subtitle">Preços</h6>
            <form method="post" id="price-filter" class="price-range" data-start-min="0" data-start-max="50" data-min="0" data-max="150" data-step="5">
                <div class="ui-range-values">
                    <div class="ui-range-value-min">
                        €<span></span>
                        <input type="hidden" id="min-val">
                    </div> -
                    <div class="ui-range-value-max">
                        €<span></span>
                        <input type="hidden" id="max-val">
                    </div>
                </div>
                <div class="ui-range-slider">
                </div>
            </form>
            <button id="price-submit" class="btn btn-default btn-block btn-sm">Filtrar Preços</button>
        </div><!-- end widget -->


        <div class="widget">
            <h6 class="subtitle">Novidades</h6>
            <figure>
                <a href="{$BASE_URL}pages/publications/publication.php?id={$oneRandomNewPublication.publicacaoid}">
                    <img src="{$BASE_URL}{$oneRandomNewPublication.url}" alt="collection">
                </a>
            </figure>
        </div><!-- end widget -->
    </div><!-- end col -->
    <!-- end sidebar -->
    <div class="col-sm-9">
        <div class="row">
            <div class="col-sm-12 text-left">
                <h2 class="title">Pesquisa de produtos</h2>
            </div><!-- end col -->
        </div><!-- end row -->

        <hr class="spacer-5"><hr class="spacer-20 no-border">

        <div class="col-sm-12 text-left" id="products-listing">
            <div class="sub-products-listing" >
               <table class="table" id="products-table">
                <tbody>
                    {if $def_pubs[0].publicacaoid == null}
                    <p>Sem publicações sobre {$def_pubs[0].nome_subcategoria}</p>
                    {else}
                    {foreach $def_pubs as $publication}
                    <tr>
                        <td>
                            <a href="{$BASE_URL}pages/publications/publication.php?id={$publication.publicacaoid}"></a>
                            <img src='{$BASE_URL}{$publication.url}' width='70px' />
                        </td>
                        <td>
                          <a href="{$BASE_URL}pages/publications/publication.php?id={$publication.publicacaoid}"> {$publication.titulo}</a>
                      </td>
                      <td>
                          <h7> {$publication.nome_autor} </h7>
                      </td>
                      <td>
                          <strike>{$publication.preco|string_format:"%.2f"}€</strike>
                      </td>
                      <td>
                          <h7>{$publication.precopromocional|string_format:"%.2f"}€</h7>
                      </td>
                  </tr>
                  {/foreach}
                  {/if}
              </tbody>
          </table>
      </div>
  </div><!-- end row -->
</div><!-- end col -->   
</div>

</section>
<!-- end section -->

{include file='common/footer.tpl'}
<script src="{$BASE_URL}javascript/publications/filter2.js"></script>