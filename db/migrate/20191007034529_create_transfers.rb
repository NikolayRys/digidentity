class CreateTransfers < ActiveRecord::Migration[5.2]
  def change
    create_table :transfers do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :amount, null: false
      t.text    :note

      t.timestamps
    end
  end
end
