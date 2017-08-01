class CreateFriendships < ActiveRecord::Migration[5.0]
  def change
    create_table :friendships do |t|
      t.string :sender
      t.string :receiver
      t.boolean :accept

      t.timestamps
    end
  end
end
