class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|
      t.string   :name
      t.integer  :user_id
      t.text     :description
      t.date     :date_added
      t.date     :date_removed
      t.integer  :tool_category_id
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :picture_file_name
      t.string   :picture_content_type
      t.integer  :picture_file_size
      t.datetime :picture_updated_at
      t.string   :serial_id
      t.string   :location
      t.boolean  :donatable
      t.string   :value
      t.boolean  :notes
    end
  end
end

