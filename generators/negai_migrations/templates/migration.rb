class CreateNegaiObjects < ActiveRecord::Migration
  def self.up
    create_table :scripts do |t|
      t.string :name
      t.string :content

      t.timestamps
    end

    create_table :executions do |t|
      t.belongs_to :script  # script to execute
      t.string :output  # standard output of the execution
      t.integer :execution_time
      t.timestamps
    end
  end
  def self.down
    drop_table :executions
    drop_table :scripts
  end
end
