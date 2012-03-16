class CreateToolCategories < ActiveRecord::Migration
  def change
    create_table :tool_categories do |t|
      t.string   :name
      t.text     :description
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end


