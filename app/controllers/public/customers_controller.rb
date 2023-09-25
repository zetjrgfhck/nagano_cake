class Public::CustomersController < ApplicationController
  def show
  end

  def edit
  end

  def update
    @customer = current_customer
		  if @customer.update(customer_params)
        redirect_to customers_path
      else
        render :edit
      end
  end

  def quit
  
  end

  def leave
  
  end
end
