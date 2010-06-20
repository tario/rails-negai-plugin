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
class Script < ActiveRecord::Base

  has_many  :executions

  def create_execution
    e = Execution.new
    e.script_id = self.id
    if block_given?
      yield(e)
    end
    e.save
    e
  end

  def run
    # run through negai using the current_user privileges
    e = create_execution
    e.script = self
    e.run

    e
  end

end
