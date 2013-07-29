class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :name
      t.string :description
      t.integer :section_id

      t.timestamps
    end
    add_index :feeds, [:section_id, :name]
  end
end
