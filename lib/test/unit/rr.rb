# Copyright (C) 2011  Kouhei Sutou <kou@clear-code.com>
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

require 'rr'
require 'test-unit'
require "test/unit/rr/version"

module Test::Unit
  module RR
    module Adapter
      include ::RR::Adapters::RRMethods

      class << self
        def included(mod)
          ::RR.trim_backtrace = true
          mod.module_eval do
            setup :before => :prepend
            def setup_rr
              ::RR.reset
            end

            cleanup :after => :append
            def cleanup_rr
              ::RR.verify
            end

            exception_handler do |test_case, exception|
              return false unless exception.is_a?(::RR::Errors::RRError)
              test_case.problem_occurred
              test_case.add_failure(exception.message, exception.backtrace)
              true
            end
          end
        end
      end

      def assert_received(subject, &block)
        block.call(received(subject)).call
      end
    end
  end

  class TestCase
    include RR::Adapter
  end
end
