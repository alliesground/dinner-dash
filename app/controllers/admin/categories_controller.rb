class Admin::CategoriesController < Admin::ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.js do
          set_flash_message("Category #{@category.name} created")
          redirect_to new_admin_category_path
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
