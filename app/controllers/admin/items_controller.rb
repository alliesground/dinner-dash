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
          redirect_to admin_item_path @item
        end
      else
        format.js do
          set_flash_message(@item.errors.full_messages)
        end
      end
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(
      :title, 
      :desc, 
      :price,
      category_ids: [],
      images: []
    )
  end

  def set_flash_message(msg)
    response.set_header('Flash-Message',msg ) 
  end
end
