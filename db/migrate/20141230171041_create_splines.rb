class CreateSplines < ActiveRecord::Migration
  def self.up
    create_table :splines do |t|
      t.string :name
      t.boolean :reticulated, default: false
    end
  end

  def self.down
    drop_table :splines
  end
end
