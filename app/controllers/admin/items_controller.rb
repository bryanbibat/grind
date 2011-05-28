module Admin
  class ItemsController < ApplicationController
    before_filter :authenticate_user!
    before_filter :check_if_admin
    def index
      @items = Item.all
    end

    def new
      @item = Item.new
    end

    def create
      @item = Item.new(params[:item])
      if @item.save
        redirect_to admin_items_path, :notice => "Item successfully created"
      else
        render "new"
      end
    end

    def edit
      @item = Item.find(params[:id])
    end

    def update
      @item = Item.find(params[:id])
      if @item.update_attributes(params[:item])
        redirect_to admin_items_path, :notice => "Item successfully updated"
      else
        render "edit"
      end
    end
  end
end
