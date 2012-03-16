class ToolCategoriesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @categories = ToolCategory.all
  end

  def new
    @redirect_to = params[:redirect_to]
    @category = ToolCategory.new
  end

  def edit
    @category = ToolCategory.find(params[:id])
  end

  def create
    @category = ToolCategory.new(params[:tool_category])
    if @category.save
      flash[:notice] = "Dude, you are awesome. You've added a category."
      if params[:redirect] 
        redirect_to params[:redirect]
      else
        redirect_to tool_categories_path
      end
    else
      flash[:alert] = 'You broke something. :-('
      redirect_to edit_tool_category_path(@category)
    end
  end

  def update
    @category = ToolCategory.find(params[:id])
    if @tool.update_attributes(params[:tool_category])
      flash[:notice] = "Your changes have been saved, good sir or madam."
      redirect_to tool_categories_path
    else
      flash[:alert] = "Whoops, something bad happened!"
      redirect_to edit_tool_category_path(@category)
    end
  end

  def show
    @c = ToolCategory.find(params[:id])
  end

end
