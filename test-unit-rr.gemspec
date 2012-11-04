# -*- mode: ruby; coding: utf-8 -*-
#
# Copyright (C) 2012  Kouhei Sutou <kou@clear-code.com>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

clean_white_space = lambda do |entry|
  entry.gsub(/(\A\n+|\n+\z)/, '') + "\n"
end

$LOAD_PATH.unshift(File.expand_path("lib", File.dirname(__FILE__)))
require "test/unit/rr/version"

Gem::Specification.new do |spec|
  spec.name = "test-unit-rr"
  spec.version = Test::Unit::RR::VERSION.dup
  spec.rubyforge_project = "test-unit"
  spec.homepage = "http://test-unit.rubyforge.org/#test-unit-rr"
  spec.authors = ["Kouhei Sutou"]
  spec.email = ["kou@clear-code.com"]
  readme = File.read("README.md")
  readme.force_encoding("UTF-8") if readme.respond_to?(:force_encoding)
  entries = readme.split(/^\#\#\s(.*)$/)
  description = clean_white_space.call(entries[entries.index("Description") + 1])
  spec.summary, spec.description, = description.split(/\n\n+/, 3)
  spec.license = "LGPLv2 or later"
  spec.files = ["README.md", "Rakefile", "COPYING"]
  spec.files += ["#{spec.name}.gemspec", "Gemfile"]
  spec.files += Dir.glob("lib/**/*.rb")
  spec.test_files += Dir.glob("test/**/*")

  spec.add_dependency("test-unit", ">= 2.1.2")
  spec.add_dependency("rr", ">= 1.0.2")

  spec.add_development_dependency("bundler")
  spec.add_development_dependency("rake")
  spec.add_development_dependency("packnga")
  spec.add_development_dependency("redcarpet")
end
