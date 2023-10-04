class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
     @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customers_my_pape_path(@customer.id)
    else
      render :edit
    end
  end
end
