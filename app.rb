require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "pizzashop.db"}

class Product < ActiveRecord::Base
end

class Order < ActiveRecord::Base
  validates :name, presence: true
  validates :phone, presence: true
  validates :address, presence: true
end

before do
end

get '/' do
  erb :index
end

get '/about' do
  erb :about
end

get '/products' do
  @products = Product.all
  erb :products
end

post '/cart' do
  @new_order = Order.new
  @orders_input = params[:orders]
  @items = parse_orders(@orders_input)

  if @items.length == 0
    return erb :empty_cart
  end

  @items.each do |item|
    item[0] = Product.find(item[0])
  end
  erb :cart
end

def parse_orders(orders_input)
  arr1 = orders_input.split(',')
  array = []
  arr1.each do |y|
    arr2 = y.split('=')
    arr3 = arr2[0].split('_')

    qty = arr2[1]
    id = arr3[1]
    array2 = [id, qty]
    array.push array2
  end
  array
end

post '/order' do
  @new_order = Order.new params[:order]
  if @new_order.save
    erb :order_confirmation #'<h2>Your order was received!</h2>'
  else
    @error = @new_order.errors.full_messages.first
    @orders_input = params[:order]['orders_input']
    @items = parse_orders(@orders_input)

    if @items.length == 0
      return erb :empty_cart
    end

    @items.each do |item|
      item[0] = Product.find(item[0])
    end
    erb :cart
  end
end

get '/order_list' do
  @order_list = Order.all.order('created_at DESC')
  erb :order_list
end
