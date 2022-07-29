class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :name, null: false
      t.string :social_number, null: false, unique: true
      t.boolean :active, default: true, null: false

      t.timestamps
    end
  end
end
