class PaymentsController < ApplicationController

	def new
		@author = AuthorBook.find_by_id(params[:author_book_id])
		@payment = @author.build_payment
		render layout: "dashboard"
	end

	def create
		@author_book = AuthorBook.find_by_id(params[:author_book_id])
		@payment = @author_book.build_payment(params[:payment])
		require "stripe"
		Stripe.api_key = "sk_test_cWbI1fA0O5evvorlsXuD4C23"
		response = Stripe::Charge.create(
		  :amount => @author_book.genre_price,
		  :currency => "usd",
		  :card => params[:payment][:token], # obtained with Stripe.js
		  :description => @author_book.email,
		  :capture => true
		)
		@payment.charge_id = response["id"]
		num_str = params[:payment][:card_numbre]
      	@last_four = num_str[-4..-1]
      	@payment.card_numbre = @last_four
		@payment.save!
		@author_book.payment_status = "Paid"
		@author_book.save!
		flash[:notice] = "Your Credit card details successfully saved."
		redirect_to new_author_book_path
	end
end
