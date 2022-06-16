class TransactionsController < ApplicationController
	after_action :validation_messages,except: :index

	def index
		@user = User.find(params[:user_id])
		@transactions = @user.transactions
	end

	def create
		@transaction = Transaction.new(transaction_params)
		if @transaction.save
			redirect_to  store_products_path(params[:transaction][:store_id])
		else
			render 'new'
		end
	end

	private
	def transaction_params
		params.require(:transaction).permit(:amount,:product_id,:user_id,:store_id)
	end

	def validation_messages
    return unless @transaction.validation_context.present?

    flash[:notice] = @transaction.validation_context
  end
end
