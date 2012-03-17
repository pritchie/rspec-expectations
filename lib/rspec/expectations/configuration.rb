module RSpec
  module Expectations
    def self.enable_should_and_should_not=(enable)
      return if enable # enabled by default
      ::Kernel.module_eval do
        undef should
        undef should_not
      end
    end
  end

  if defined?(Core)
    module Core
      Configuration.class_eval do
        def enable_should_and_should_not=(enable)
          RSpec::Expectations.enable_should_and_should_not = enable
        end
      end
    end
  end
end

