class Admin::ItemsController < Admin::ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.js do
          flash[:notice] = 'Item saved'
          redirect_to new_admin_item_path
        end
      else
        format.js do
          render plain: @item.errors.full_messages
        end
      end
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :title, 
      :desc, 
      :price,
      category_ids: []
    )
  end
end
