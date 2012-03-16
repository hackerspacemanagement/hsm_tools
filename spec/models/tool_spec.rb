require 'spec_helper'

describe Tool, "name" do
    before do
        @category = Factory.create :tool_category, :name => "Category"
    end
    
    it "returns the tool's name" do
        tool = Factory.create :tool
        tool.name = "Screwdriver"
        tool.name.should == "Screwdriver"
    end
    
    it "returns the tool's category" do
        tool = Factory.create :tool
        tool.tool_category = @category
        tool.tool_category.name.should == "Category"
    end
    
    it "returns the tool's description" do
        tool = Factory.create :tool
        tool.description = "This is a test"
        tool.description.should == "This is a test"
    end
    
    it "sets and returns the user" do
        tool = Factory.create :tool
        user = Factory.create :user
        tool.user = user
        tool.user.should
        
        tool.save # so that user gets the tool
        
        user.tools.should have(1).tool
    end
end
