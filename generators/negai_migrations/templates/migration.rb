=begin

This file is part of the negai project, http://github.com/tario/negai

Copyright (c) 2009-2010 Roberto Dario Seminara <robertodarioseminara@gmail.com>

negai is free software: you can redistribute it and/or modify
it under the terms of the gnu general public license as published by
the free software foundation, either version 3 of the license, or
(at your option) any later version.

negai is distributed in the hope that it will be useful,
but without any warranty; without even the implied warranty of
merchantability or fitness for a particular purpose.  see the
gnu general public license for more details.

you should have received a copy of the gnu general public license
along with negai.  if not, see <http://www.gnu.org/licenses/>.

=end


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
