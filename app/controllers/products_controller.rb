class ProductsController < ApplicationController
	before_action :set_store

	def index
		@products = @store.products
	end

	def buy_now
		@product = Product.find(params[:id])
		@transaction = Transaction.new
	end

	private
	def set_store
		@store = Store.find(params[:store_id])
	end
end
