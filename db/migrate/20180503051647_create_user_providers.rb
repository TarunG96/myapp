class CreateUserProviders < ActiveRecord::Migration[5.1]
  def change
    create_table :user_providers do |t|
      t.string :provider
      t.string :uid
      t.references :user, index: true
 
      t.timestamps
    end
  end
end
