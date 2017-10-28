<li class="linkdown">
  <a href="javascript:void(0);">
    <i class="fa fa-user mr-5"></i>
    <span class="hidden-xs">
      {$USERNAME} 
      <i class="fa fa-angle-down ml-5"></i>
    </span>
  </a>
  <ul class="w-150">
  {if $USERTYPE == 'client'}
    <li>
      <a href="{$BASE_URL}pages/users/my-account.php">
        <i class="fa fa-edit mr-5"></i>
        <span class="hidden-xs">
          Minha Conta
        </span></a>
      </li>
      <li>
        <a href="{$BASE_URL}pages/users/wishlist.php">
          <i class="fa fa-heart mr-5"></i>
          <span class="hidden-xs">
            Wishlist
          </span></a>
        </li>
        <li>
          <a href="{$BASE_URL}pages/users/cart.php">
            <i class="fa fa-shopping-cart mr-5"></i>
            <span class="hidden-xs">
              Ver Carrinho
            </span></a>
          </li>
          <li>
            <a href="{$BASE_URL}pages/users/order-list.php">
              <i class="fa fa fa-bar-chart mr-5"></i>
              <span class="hidden-xs">
                Encomendas
              </span></a>
            </li>
            <li>
              <a href="{$BASE_URL}pages/users/checkout.php">
                <i class="fa fa-credit-card mr-5"></i>
                <span class="hidden-xs">
                  Checkout
                </span></a>
              </li>
            </ul>
          </li>
          {/if}
          {if $USERTYPE == 'owner'}
          <li class="linkdown">
            <a href="{$BASE_URL}pages/owner/home.php">
              <i class="fa fa-pie-chart mr-5"></i>
              <span class="hidden-xs">
                Dashboard
              </span>
            </a>
          </li>
          {elseif $USERTYPE == 'admin'}
          <li class="linkdown">
            <a href="{$BASE_URL}pages/admin/home.php">
              <i class="fa fa-pie-chart mr-5"></i>
              <span class="hidden-xs">
                Dashboard
              </span>
            </a>
          </li>
          {/if}
          <li class="linkdown">
            <a href="{$BASE_URL}actions/users/logout.php">
              <i class="fa fa-user-times mr-5"></i>
              <span class="hidden-xs">
                Logout
              </span>
            </a>
          </li>
          {if $USERTYPE == 'client'}
          <li class="linkdown">
            <a href="javascript:void(0);">
              <i class="fa fa-shopping-basket mr-5"></i>  
            </a>
            <ul class="cart w-250">
              <li>
                <div class="cart-items">
                  <ol class="items">
                    {foreach $PUBLICATIONSUSERCART as $publicationusercart}
                    <li data-id="{$publicationusercart.publicacaoid}"> 
                      <a href="{$BASE_URL}pages/publications/publication.php?id={$publicationusercart.publicacaoid}" class="product-image">
                        <img src="{$BASE_URL}{$publicationusercart.url}" alt="Sample Product ">
                      </a>
                      <div class="product-details">
                        <div class="close-icon"> 
                          <a href="javascript:void(0);"><i class="fa fa-close"></i></a>
                        </div>
                        <p class="product-name"> 
                          <a href="{$BASE_URL}pages/publications/publication.php?id={$publicationusercart.publicacaoid}">{$publicationusercart.titulo}</a> 
                        </p>
                        <strong data-type="quantidade">{$publicationusercart.quantidade}</strong> x <span class="price text-primary">€{$publicationusercart.preco}</span>
                      </div><!-- end product-details -->
                    </li><!-- end item -->
                    {/foreach}
                  </ol>
                </div>
              </li>
              <li>
                <div class="cart-footer">
                  <a href="?page=cart" class="pull-right"><i class="fa fa-cart-plus mr-5"></i>Ver Carrinho Completo</a>
                  <a href="?page=checkout" class="pull-right"><i class="fa fa-shopping-basket mr-5"></i>Checkout</a>
                </div>
              </li>
            </ul>
          </li>
          {/if}
        </ul>
      </div><!-- end container -->
    </div>
    <!-- end topBar -->

    <script src="{$BASE_URL}javascript/users/menu_logged_in.js"></script>