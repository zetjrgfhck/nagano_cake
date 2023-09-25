class Admin::ItemsController < ApplicationController
  def index
    @item = Item.new
  end

  def new
    @item = Item.new
  end

  def create
    #アイテム　ストロングパラメータで受けとったふぉーむの情報
    #情報の保存
    #遷移先かく
    
  end

  def show
    
  end

  def edit
  
  end

  def update
  
  end
 
 def item_params
    #params.require(:item).permit(カラム)
  end

end
