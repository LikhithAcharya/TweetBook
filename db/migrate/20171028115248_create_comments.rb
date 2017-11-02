class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :tweet, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
