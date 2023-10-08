class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
     @customer = current_customer
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
    current_customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end
end
