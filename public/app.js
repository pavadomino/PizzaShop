function something()
{
  var x = window.localStorage.getItem('aaa');
  x = x * 1 +1
  window.localStorage.setItem('aaa', x);
  alert(x);
}

function add_to_cart(id)
{
  var key = 'product_' + id;
  var x = window.localStorage.getItem(key);
  x = x * 1 + 1;
  window.localStorage.setItem(key, x);
  alert('Items in your cart: ' + cart_get_number_of_items());
}

function cart_get_number_of_items()
{
  var total = 0;
  for (var i = 0; i < window.localStorage.length; i++){
    var key = window.localStorage.key(i);
    var value = window.localStorage.getItem(key);
    if (key.indexOf('product_') == 0)
    {
      total = total + value * 1;
    }
  }
  return total;
}

function cart_get_orders()
{
  var orders = '';
  for (var i = 0; i < window.localStorage.length; i++){
    var key = window.localStorage.key(i);
    var value = window.localStorage.getItem(key);
    if (key.indexOf('product_') == 0)
    {
      orders = orders + key + '=' + value + ',';
    }
  }
  return orders;
}
