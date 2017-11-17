{include file='common/header.tpl'}

<div class="breadcrumbs">
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <ul>
                    <li><a href="{$BASE_URL}">Página inicial</a></li>
                    <li class="active">Checkout</li>
                </ul><!-- end breadcrumb -->
            </div><!-- end col -->    
        </div><!-- end row -->
    </div><!-- end container -->
</div><!-- end breadcrumbs -->

<!-- start section -->
<section class="section white-backgorund">
    <div class="container">
        <div class="row">
            {include file='common/sidebar.tpl'}

            <div class="col-sm-9">
                <div class="row">
                    <div class="col-sm-12 text-left">
                        <h2 class="title">Checkout</h2>
                    </div><!-- end col -->
                </div><!-- end row -->

                <hr class="spacer-5"><hr class="spacer-20 no-border">
                
                <div class="row">
                    <form action="{$BASE_URL}actions/users/checkout.php" method="post">
                        <div class="col-sm-12">
                            <ul class="nav nav-pills style2 nav-justified">
                                <li class="active">
                                    <a href="#shopping-cart" data-toggle="tab">
                                        1. Carrinho
                                        <div class="icon">
                                            <i class="fa fa-check"></i>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="#billing-info" data-toggle="tab">
                                        2. Dados pessoais
                                        <div class="icon">
                                            <i class="fa fa-home"></i>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="#payment" data-toggle="tab">
                                        3. Pagamento
                                        <div class="icon">
                                            <i class="fa fa-credit-card"></i>
                                        </div>
                                    </a>
                                </li>
                            </ul>

                            <div class="tab-content pills">
                                <div class="tab-pane active" id="shopping-cart">
                                    <div class="table-responsive">    
                                        <table class="table table-striped">
                                            <thead>
                                                <tr>
                                                    <th colspan="2">Produtos</th>
                                                    <th>Preço</th>
                                                    <th>Quantidade</th>
                                                    <th colspan="2">Total</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                {foreach $publicationscart as $publication}
                                                <tr data-id="{$publication.publicacaoid}" data-price="{$publication.precopromocional}">
                                                    <td>
                                                        <a href="{$BASE_URL}pages/publications/publication.php?id={$publication.publicacaoid}">
                                                            <img width="60px" src="{$BASE_URL}{$publication.url}" alt="product">
                                                        </a>
                                                    </td>
                                                    <td>
                                                        <h6 class="regular"><a href="{$BASE_URL}pages/publications/publication.php?id={$publication.publicacaoid}">{$publication.titulo}</a></h6>
                                                        <p>{$publication.nome_categoria} | {$publication.nome_subcategoria}</p>
                                                    </td>
                                                    <td>
                                                        <span>€{$publication.precopromocional}</span>
                                                    </td>
                                                    <td>
                                                        <select class="form-control" name="select">
                                                            {html_options options=$qtOptions selected=$publication.quantidade}
                                                        </select>
                                                    </td>
                                                    <td data-column="total">
                                                        <span class="text-primary">€{$publication.precopromocional * $publication.quantidade}</span>
                                                    </td>
                                                    <td>
                                                        <button type="button" class="close">×</button>
                                                    </td>
                                                </tr>
                                                {/foreach}
                                            </tbody>
                                        </table><!-- end table -->
                                    </div><!-- end table-responsive -->
                                </div><!-- end tab-pane -->
                                <div class="tab-pane" id="billing-info">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <h5 class="thin subtitle">Morada de faturação</h5>                                            
                                            <div class="row">
                                                <div class="form-group">
                                                    <label for="nomef" class="col-sm-2 control-label">Nome<span class="text-danger">*</span></label>
                                                    <input type="text" placeholder="Nome" name="nomef" value="{$USER_DATA.nome}" class="form-control input-md required">
                                                </div><!-- end form-group -->
                                                <div class="form-group">
                                                    <label for="moradaf" class="col-sm-2 control-label">Morada<span class="text-danger">*</span></label>
                                                    <input name="moradaf" type="text" placeholder="Endereço" class="form-control input-md required" value="{$USER_DATA.rua}">
                                                </div><!-- end form-group -->
                                                <div class="row">
                                                    <div class="col-sm-6">
                                                        <div class="form-group">
                                                            <label for="localidadef" class="col-sm-2 control-label">Localidade<span class="text-danger">*</span></label>
                                                            <input name="localidadef" type="text" placeholder="Localidade" class="form-control input-md required" value="{$USER_DATA.nomelocalidade}">
                                                        </div><!-- end form-group -->
                                                    </div><!-- end col -->
                                                    <div class="col-sm-6">
                                                        <div class="form-group">
                                                            <label for="codigopostalf" class="control-label">Código-Postal<span class="text-danger">*</span></label>
                                                            <input name="codigopostalf" type="text" placeholder="Código-Postal" class="form-control input-md required" value="{$USER_DATA.cod1}-{$USER_DATA.cod2}">
                                                        </div><!-- end form-group -->
                                                    </div><!-- end col -->
                                                </div><!-- end row -->
                                                <div class="row">
                                                    <div class="col-sm-6">
                                                        <div class="form-group">
                                                            <label for="email" class=" col-sm-2 control-label">Email<span class="text-danger">*</span></label>
                                                            <input name="email" type="email" placeholder="Email" class="form-control input-md required" value="{$USER_DATA.email}">
                                                        </div><!-- end form-group -->
                                                    </div><!-- end col -->
                                                    <div class="col-sm-6">
                                                        <div class="form-group">
                                                            <label for="telefone" class="col-sm-2 control-label">Telefone</label>
                                                            <input name="telefone" type="tel" placeholder="Telefone" class="form-control input-md required" value="{$USER_DATA.telefone}">
                                                        </div><!-- end form-group -->
                                                    </div>
                                                </div><!-- end row -->
                                                <div class="row">
                                                    <div class="col-sm-6">
                                                        <div class="form-group">
                                                            <label for="nif" class=" col-sm-2 control-label">NIF</label>
                                                            <input name="nif" type="text" placeholder="Nif" class="form-control input-md required" value="{$USER_DATA.nif}">
                                                        </div><!-- end form-group -->
                                                    </div><!-- end col -->

                                                </div><!-- end row -->
                                            </div>
                                        </div><!-- end col -->

                                        <div class="col-md-7">
                                            <h5 class="thin subtitle">Morada de envio</h5>
                                            <div class="form-group">
                                                <div class="checkbox-input checkbox-primary" data-toggle="collapse" data-target=".shipto">
                                                    <input id="ship-to-billing-address" class="styled" type="checkbox" checked>
                                                    <label for="ship-to-billing-address">
                                                        Enviar para a morada de faturação?
                                                    </label>
                                                </div><!-- end checkbox-input -->
                                            </div><!-- end form-group -->

                                            <div class="shipto collapse">
                                                <div class="row">
                                                    <div class="form-group">
                                                        <label for="nomee" class="col-sm-2 control-label">Nome<span class="text-danger">*</span></label>
                                                        <input type="text" placeholder="Nome" name="nomee" value="{$USER_DATA.nome}" class="form-control input-md required">
                                                    </div><!-- end form-group -->
                                                    <div class="form-group">
                                                        <label for="moradae" class="col-sm-2 control-label">Morada<span class="text-danger">*</span></label>
                                                        <input name="moradae" type="text" placeholder="Endereço" class="form-control input-md required" value="{$USER_DATA.rua}">
                                                    </div><!-- end form-group -->
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <label for="localidadee" class="col-sm-2 control-label">Localidade<span class="text-danger">*</span></label>
                                                                <input name="localidadee" type="text" placeholder="Localidade" class="form-control input-md required" value="{$USER_DATA.nomelocalidade}">
                                                            </div><!-- end form-group -->
                                                        </div><!-- end col -->
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <label for="codigopostale" class="control-label">Código-Postal<span class="text-danger">*</span></label>
                                                                <input name="codigopostale" type="text" placeholder="Código-Postal" class="form-control input-md required" value="{$USER_DATA.cod1}-{$USER_DATA.cod2}">
                                                            </div><!-- end form-group -->
                                                        </div><!-- end col -->
                                                    </div><!-- end row -->
                                                </div>
                                            </div><!-- end collapse -->    
                                        </div><!-- end col -->
                                    </div><!-- end row -->
                                </div><!-- end tab-pane -->
                                <div class="tab-pane" id="payment">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <h5 class="thin subtitle">Escolha o método de pagamento</h5>
                                            <div class="panel-group accordion style2" id="accordionPayment" role="tablist" aria-multiselectable="true">
                                                <div class="panel panel-default">
                                                    <div class="panel-heading" role="tab" id="headingPayment1">
                                                        <h4 class="panel-title">
                                                            <a class="" data-toggle="collapse" data-parent="#accordionPayment" href="#collapsePayment1" aria-expanded="true" aria-controls="collapsePayment1">
                                                                <i class="fa fa-credit-card mr-10"></i>Cartão de crédito ou de debito
                                                            </a>
                                                        </h4><!-- end panel-title -->
                                                    </div><!-- end panel-heading -->
                                                    <div id="collapsePayment1" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingPayment1">
                                                        <div class="panel-body">
                                                            <div class="form-group">
                                                                <div class="row">
                                                                    <label class="col-sm-4">Nome do titular do cartão <span class="text-danger"></span></label>
                                                                    <div class="col-sm-8">
                                                                        <input type="text" class="form-control required" name="nomecartao" placeholder="" value="{$USER_DATA.nome}">
                                                                    </div><!-- end col -->
                                                                </div><!-- end row -->
                                                            </div><!-- end form-group -->
                                                            <div class="form-group">
                                                                <div class="row">
                                                                    <label class="col-sm-4">Número do cartão <span class="text-danger"></span></label>
                                                                    <div class="col-sm-8">
                                                                        <input type="text" class="form-control required" name="numerocartao" placeholder="" value="{$USER_DATA.numerocartao}">
                                                                    </div><!-- end col -->
                                                                </div><!-- end row -->
                                                            </div><!-- end form-group -->
                                                            <div class="form-group">
                                                                <div class="row">
                                                                    <label class="col-sm-4">Tipo de pagamento <span class="text-danger">*</span></label>
                                                                    <div class="col-sm-8">
                                                                        <ul class="list list-inline">
                                                                            <li>
                                                                            <input type="radio" name="metodopagamento" value="Visa">
                                                                            <i class="pf pf-visa" data-toggle="tooltip" data-placement="top" title="Visa"></i></li>
                                                                            <li>
                                                                            <input type="radio" name="metodopagamento" value="PayPal">
                                                                            <i class="pf pf-paypal" data-toggle="tooltip" data-placement="top" title="PayPal"></i></li>
                                                                            <li class="text-primary"><input type="radio" name="metodopagamento" value="Multibanco"><i class="pf pf-multibanco" data-toggle="tooltip" data-placement="top" title="Multibanco"></i></li>
                                                                            <li><input type="radio" name="metodopagamento" value="A Cobranca"><i class="pf pf-cash-on-delivery" data-toggle="tooltip" data-placement="top" title="À Cobrança"></i></li>
                                                                            <li><input type="radio" name="metodopagamento" value="Transferencia Bancaria" ><i class="pf pf-bank-transfer" data-toggle="tooltip" data-placement="top" title="Transferência Bancária"></i></li>
                                                                        </ul>
                                                                    </div><!-- end col -->
                                                                </div><!-- end row -->
                                                            </div><!-- end form-group -->
                                                            <div class="form-group">
                                                                <div class="row">
                                                                    <label class="col-sm-4">Data de válidade <span class="text-danger"></span></label>
                                                                    <div class="col-sm-8">
                                                                        <div class="row">
                                                                            <div class="col-sm-6">
                                                                                <input type="text" name="mm" placeholder="MM" class="form-control required" value={$cardmonth}>
                                                                            </div><!-- end col -->
                                                                            <div class="col-sm-6">
                                                                                <input type="text" name="yy" placeholder="YY" class="form-control required" value={$cardyear}>
                                                                            </div><!-- end col -->
                                                                        </div><!-- end row -->      
                                                                    </div><!-- end col -->
                                                                </div><!-- end row -->
                                                            </div><!-- end form-group -->
                                                            <div class="form-group">
                                                                <div class="row">
                                                                    <label class="col-sm-4">CVV <span class="text-danger"></span></label>
                                                                    <div class="col-sm-8">
                                                                    <input type="text" class="form-control required" name="cvv" placeholder="CVV" value="{$USER_DATA.cvv}">
                                                                    </div><!-- end col -->
                                                                </div><!-- end row -->
                                                            </div><!-- end form-group -->
                                                            <div class="form-group">
                                                                <div class="row">
                                                                    <div class="col-sm-offset-4 col-sm-8">
                                                                        <div class="checkbox-input checkbox-primary mb-10">
                                                                            <input id="save-my-card" class="styled" type="checkbox">
                                                                            <label for="save-my-card">
                                                                                Salvar informações do cartão?
                                                                            </label>
                                                                        </div><!-- end checkbox-input -->
                                                                    </div><!-- end col -->
                                                                </div><!-- end row -->
                                                            </div><!-- end form-group -->
                                                            <div class="form-group">
                                                                <div class="row">
                                                                    <div class="col-sm-offset-4 col-sm-8 text-right">
                                                                        <button type="submit" class="btn btn-default btn-md round">Confirmar <i class="fa fa-arrow-circle-right ml-5"></i></a>
                                                                        </div><!-- end col -->
                                                                    </div><!-- end row -->
                                                                </div><!-- end form-group -->
                                                            </div><!-- end panel-body -->
                                                        </div><!-- end collapse -->
                                                    </div><!-- end panel -->

                                                    <div class="panel panel-default">
                                                  
                                                        </div><!-- end panel -->
                                                    </div><!-- end panel-group -->
                                                </div><!-- end col -->
                                                <div class="col-md-6">
                                                    <h5 class="thin subtitle">Perguntas frequentes</h5>
                                                    <div class="panel-group accordion style1" id="question" role="tablist" aria-multiselectable="true">
                                                        <div class="panel panel-default">
                                                            <div class="panel-heading" role="tab" id="questionOne">
                                                                <h4 class="panel-title">
                                                                    <a class="" data-toggle="collapse" data-parent="#question" href="#collapseQuestionOne" aria-expanded="true" aria-controls="collapseOne">
                                                                        Que pagamentos posso usar?
                                                                    </a>
                                                                </h4>
                                                            </div><!-- end panel-heading -->
                                                            <div id="collapseQuestionOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="questionOne">
                                                                <div class="panel-body">
                                                                    <p>Lorem ipsum dolor sit amet, link adipisicing elit. Dicta voluptatem, tenetur eum tempore minus libero voluptates eos doloremque. Dolore minima rem consequuntur exercitationem quaerat deleniti repellendus enim necessitatibus mollitia tenetur?</p>
                                                                </div><!-- end panel-body -->
                                                            </div><!-- end collapse -->
                                                        </div><!-- end panel -->

                                                        <div class="panel panel-default">
                                                            <div class="panel-heading" role="tab" id="questionTwo">
                                                                <h4 class="panel-title">
                                                                    <a class="collapsed" data-toggle="collapse" data-parent="#question" href="#collapseQuestionTwo" aria-expanded="false" aria-controls="collapseTwo">
                                                                        Posso usar um cartão de presente para o pagamento?
                                                                    </a>
                                                                </h4>
                                                            </div><!-- end panel-heading -->
                                                            <div id="collapseQuestionTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="questionTwo">
                                                                <div class="panel-body">
                                                                    <p>Lorem ipsum dolor sit amet, link adipisicing elit. Dicta voluptatem, tenetur eum tempore minus libero voluptates eos doloremque. Dolore minima rem consequuntur exercitationem quaerat deleniti repellendus enim necessitatibus mollitia tenetur?</p>
                                                                </div><!-- end panel-body -->
                                                            </div><!-- end collapse -->
                                                        </div><!-- end panel -->

                                                        <div class="panel panel-default">
                                                            <div class="panel-heading" role="tab" id="questionThree">
                                                                <h4 class="panel-title">
                                                                    <a class="collapsed" data-toggle="collapse" data-parent="#question" href="#collapseQuestionThree" aria-expanded="false" aria-controls="collapseThree">
                                                                        Quanto tempo demora até receber a minha encomenda?
                                                                    </a>
                                                                </h4>
                                                            </div><!-- end panel-heading -->
                                                            <div id="collapseQuestionThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="questionThree">
                                                                <div class="panel-body">
                                                                    <p>Lorem ipsum dolor sit amet, link adipisicing elit. Dicta voluptatem, tenetur eum tempore minus libero voluptates eos doloremque. Dolore minima rem consequuntur exercitationem quaerat deleniti repellendus enim necessitatibus mollitia tenetur?</p>
                                                                </div><!-- end panel-body -->
                                                            </div><!-- end collapse -->
                                                        </div><!-- end panel -->
                                                    </div><!-- end panel-group -->
                                                </div><!-- end col -->
                                            </div><!-- end row -->
                                        </div><!-- end tab-pane -->
                                    </div><!-- end pills content -->

                                    <hr class="spacer-30">

                                    <div class="row">
                                        <div class="col-sm-7 text-left">

                                        </div><!-- end col -->

                                        <div class="col-sm-5">
                                            <div class="table-responsive"> 
                                                <table class="table no-border">
                                                    <tr>
                                                        <th data-type="carrinhosubtotal">Total do carrinho</th>
                                                        <td>€ {$cartsubtotal}</td>
                                                    </tr>
                                                    <tr>
                                                        <th>Taxa de envio</th>
                                                        <td>Envio grátis</td>
                                                    </tr>
                                                    <tr>
                                                        <th data-type="carrinhosubtotal">Total da encomenda</th>
                                                        <td>€ {$cartsubtotal}</td>
                                                    </tr>
                                                </table><!-- end table -->
                                            </div><!-- end table-responsive -->
                                        </div><!-- end col -->
                                    </div><!-- end row -->
                                </div><!-- end col -->
                            </form>
                        </div><!-- end row -->
                    </div><!-- end col -->
                </div><!-- end row -->                
            </div><!-- end container -->
        </section>
        <!-- end section -->

        <script src="{$BASE_URL}javascript/users/checkout.js"></script>