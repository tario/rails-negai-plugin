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
require "negai"

class Execution < ActiveRecord::Base

  belongs_to  :script

  class << self
    attr_reader :default_permissions

    #The default permissions for all the script runs, usually accesed from
    #the config files
    #Example:
    #
    #  Execution.default_permissions.allow_method :print
    #  Execution.default_permissions.allow_class_definitions
    #
    def default_permissions
      @default_permissions ||= Shikashi::Privileges.new
      @default_permissions
    end
  end

  #run the execution with the corresponding permissions:
  #Example:
  #  script = Script.find(params[:id])
  #  if script
  #    e = script.create_execution
  #    e.run
  #  end
  #
  #NOTE: can use instead:
  #  script = Script.find(params[:id])
  #  if script
  #    execution = script.run
  #  end
  #

  def run
    runner = Negai::Runner.new

    local_output = ""
    runner.output_proc = proc do |data|
      local_output << data
    end
    runner.run(script.content, :privileges => current_permissions)

    self.output = local_output
    save
  end

private
  def current_permissions
    if respond_to? :user
      if user.respond_to? :negai_permissions
        user.negai_permissions
      else
        Execution.default_permissions
      end
    else
      Execution.default_permissions
    end
  end
end
