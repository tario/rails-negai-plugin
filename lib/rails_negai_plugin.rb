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
# add models directory in ActiveSupport
%w{ models }.each do |dir|
  path = File.join(File.dirname(__FILE__), 'app', dir)
  print path,"\n"

  $LOAD_PATH << path
  ActiveSupport::Dependencies.load_paths << path
  ActiveSupport::Dependencies.load_once_paths.delete(path)
end
