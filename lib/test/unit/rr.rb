#--
#
# Author:: Kouhei Sutou
# Copyright::
#   * Copyright (c) 2011 Kouhei Sutou <kou@clear-code.com>
# License:: Ruby license.

require 'rr'
require 'test/unit'

module Test::Unit
  module RR
    VERSION = "1.0.2"

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
              begin
                ::RR.verify
              rescue ::RR::Errors::RRError => exception
                add_failure(exception.message, exception.backtrace)
              end
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
