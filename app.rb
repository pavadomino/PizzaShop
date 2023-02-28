require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "pizzashop.db"}

class Product < ActiveRecord::Base
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

get '/cart' do
  erb :cart
end

post '/cart' do
  @orders_input = params[:orders]
  @items = parse_orders(@orders_input)
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
  erb '<h2>Your order was received!</h2>'
end

get '/order_list' do
  "Hello World"
end
