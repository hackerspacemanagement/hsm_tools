class ToolsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    if params[:id]
      @user       = User.find(params[:id])
      @tools      = @user.tools.paginate(:page => params[:page])
      @user_tools = true
    elsif params[:category]
      @tools      = ToolCategory.find(params[:category]).tools.paginate(:page => params[:page])
      @user_tools = nil
    else
      @tools      = Tool.paginate(:page => params[:page])
      @user_tools = nil
    end
  end

  def new
    @tool       = Tool.new
    @users      = users 
    @categories = categories
  end

  def edit
    @tool       = Tool.find(params[:id])
    @users      = users 
    @categories = categories
  end

  def show
    if params[:id]
      @tool = Tool.find(params[:id])
      @user = @tool.user
    else
      flash[:error] = "No tool selected!"
    end
  end

  def create
    @tool = Tool.new(params[:tool])
    @tool.date_added = Time.now
    if @tool.save
      log_action "added", @tool
      flash[:notice] = "Dude, you are awesome. You've added a tool."
      redirect_to tools_path
    else
      flash[:alert] = 'You broke something. :-('
      redirect_to edit_tool_path(@tool)
    end
  end

  def update
    @tool = Tool.find(params[:id])
    if @tool.update_attributes(params[:tool])
      log_action "updated", @tool
      flash[:notice] = "Your changes have been saved, good sir or madam."
      redirect_to tools_path
    else
      flash[:alert] = "Whoops, something bad happened!"
      redirect_to edit_tool_path(@tool)
    end
  end
  
  def destroy
    if tool = Tool.find(params[:id])
      if current_user.can_administrate? or current_user == tool.user
        name = tool.name
        if tool.destroy
          flash[:notice] = "You've deleted the #{name}."
          redirect_to tools_path
          return
        else
          flash[:alert] = "Whoops, something bad happened!"
          redirect_to edit_tool_path(tool)
          return
        end  
      else
        flash[:alert] = "You are not allowed to delete tools you don't own"
        redirect_to edit_tool_path(tool)
        return
      end
    else
      flash[:alert] = "Could not find tool with id #{ params[:id] }."
      return
    end
  end
  
  private
  
  def users
    User.all.collect { |p| [p.full_name, p.id]} << [Settings.group_name, ""]
  end
  
  def categories
    ToolCategory.all.collect {|p| [ p.name, p.id ] }
  end 

end
