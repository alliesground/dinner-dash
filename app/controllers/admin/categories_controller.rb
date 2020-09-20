class Admin::CategoriesController < Admin::ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.js do
          set_flash_message('Item saved')
          # redirect_to admin_item_path @item
        end
      else
        format.js do
          set_flash_message(@category.errors.full_messages)
        end
      end
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
