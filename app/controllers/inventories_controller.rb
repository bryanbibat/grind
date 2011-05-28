class InventoriesController < ApplicationController
  def show
    @owned_items = current_user.owned_items
    @owned_items.sort_by! { |item| item.item.item_type }
  end
end

