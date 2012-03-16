require 'spec_helper' 

describe 'Tool' do
  before do
    # Create some initial Tool categories
    @user = Factory.create :user
    login_as @user
  end
  
  describe 'Adding and Removing Tools' do
    it 'should display a link to add new tools on the tools index' do
      visit tools_path
      
      page.should have_css "a[href='#{ new_tool_path }']"
    end
    
    context 'without a redirect set' do
      it 'should allow users to add tool categories' do
        visit new_tool_category_path
        
        fill_in_fields :tool_category_name        => "Test Category",
                       :tool_category_description => "This is a test category"
        
        click_button "Create Tool category"

        should_be_on tool_categories_path
      end
    end

    context 'with a redirect set' do
      it 'should allow users to add tool categories' do
        visit new_tool_category_path(:redirect_to => root_path)

        fill_in_fields :tool_category_name        => "Test Category",
                       :tool_category_description => "This is a test category"

        click_button "Create Tool category"

        should_be_on root_path
      end
    end
    
    describe 'actual tool creation' do
      before do
        Factory.create :tool_category, :name => "Test Category"
        visit new_tool_path
        
        fill_in_fields :tool_name        => "Test Tool",
                       :tool_serial_id   => "1234",
                       :tool_description => "This is a test tool"
        
        page.select("Test Category", :from => "tool_tool_category_id")
        page.select(@user.full_name, :from => "tool_user_id")
        
        click_button "Create Tool"
      end

      it 'should allow users to add tools' do
        Tool.find_by_name("Test Tool").should
      end

      it 'should list new tool on the newsfeed' do
        visit newsfeed_path

        page.should have_content "created tool Test Tool"
      end
    end
  end
  
  describe "deleting tools" do
    before do
      @tool = Factory :tool, :name => "Test Tool"
      @tool.save
    end
    
    it 'should have a link to remove the tool' do
      visit tools_path
      
      page.should have_css "a[href='#{ edit_tool_path(@tool) }']"
    end
    
    it 'should be able to delete tools', :js => true do
      visit edit_tool_path(@tool)
      
      page.should have_css "a[href='#{ tool_path(@tool) }']"
      click_link "Delete this tool"
      
      alert = page.driver.browser.switch_to.alert
      alert.text.should == "Are you sure?"

      alert.accept
    end
    
    it "should not allow users to delete tools that they don't own", :js => true do
      @owner_user = Factory :user, :email => "me@example.com"
      @tool.user  = @owner_user
      @tool.save
      
      visit edit_tool_path(@tool)
      click_link "Delete this tool"
      
      alert = page.driver.browser.switch_to.alert
      alert.text.should == "Are you sure?"

      alert.accept
      
      page.should have_content "You are not allowed to delete tools you don't own"
    end
  end
  
  describe 'Editing tools' do
    before do
      @tool_category = Factory :tool_category, :name => "Test Category"
      
      @tool          = Factory :tool, :name          => "Test tool",
                                      :user          => @user,
                                      :tool_category => @tool_category,
                                      :description   => "This is a test"

      @tool.save

      visit edit_tool_path @tool

      fill_in_fields :tool, :name        => "Test Changed Tool",
                            :location    => "back of the lab",
                            :serial_id   => "1234",
                            :description => "This is still a test"

      click_button "Update Tool"
    end
    
    it 'should be able to edit existing tools' do
      page.should_not have_content "Whoops"
      should_be_on tools_path
      
      @tool.reload
      @tool.name.should        == "Test Changed Tool"
      @tool.location.should    == "back of the lab"
      @tool.serial_id.should   == "1234"
      @tool.description.should == "This is still a test"
    end

    it 'should show the changes on the newsfeed' do
      visit newsfeed_path

      page.should have_content "updated tool Test Changed Tool"
    end

  end
  
  describe 'tool categories' do
    describe 'adding new tool categories' do
      it 'should have a link to add new tool categories' do
        visit tool_categories_path
        
        click_link "Add a tool category"
        
        page.should have_content "New Tool Category"
      end
      
      it 'should allow anyone to add new tool categories' do
        visit new_tool_category_path
        
        fill_in_fields :tool_category, :name => "Test Category",
                                       :description => "This is a test!"
        
        click_button "Create Tool category"
      end
    end
  end
end
