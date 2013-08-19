class AddColumnsToSections < ActiveRecord::Migration
  def change
    add_column :sections, :rank, :int
    add_column :sections, :image_src, :string

    add_index  :sections, :rank
  end

end
