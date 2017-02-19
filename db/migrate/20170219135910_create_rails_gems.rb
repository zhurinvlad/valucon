class CreateRailsGems < ActiveRecord::Migration[5.0]
  def change
    create_table :rails_gems do |t|
      t.string :version, :limit => 20
      t.string :gem_copy
      t.string :sha
    end
  end
end
