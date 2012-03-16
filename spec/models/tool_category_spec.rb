require 'spec_helper'

describe ToolCategory do
  it 'can create tool categories' do
    @tool = Factory.create :tool_category, :name => 'test'
    
    @tool.should
  end
  
  it 'can have a name' do
    @tool = Factory.create :tool_category, :name => 'test'
    
    @tool.name = "Test!"
    @tool.name.should == "Test!"
  end
  
  it 'can have a description' do
    @tool = Factory.create :tool_category, :name => 'test'
    
    @tool.description = "This is a test!"
    @tool.description.should == "This is a test!"
  end 
end
