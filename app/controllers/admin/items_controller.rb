class Admin::ItemsController < Admin::ApplicationController
  def index
    @items = Item.all
  end

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

  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
    @item.images.attach(item_params[:images])

    respond_to do |format|
      if @item.update(item_params.except(:images))
        format.js do
          set_flash_message('Item updated successfully')
          redirect_to admin_items_path
        end
      else
        format.js do
          set_flash_message("Error! Please fill the form properly")
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
      category_ids: [],
      images: []
    )
  end

  def set_flash_message(msg)
    response.set_header('Flash-Message',msg ) 
  end
end
