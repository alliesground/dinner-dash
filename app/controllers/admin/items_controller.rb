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
          set_flash_message(@item.errors.full_messages)
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

  def set_flash_message(msg)
    response.set_header('Flash-Message',msg ) 
  end
end
