require 'spec_helper'

shared_examples_for "configuring enable_should_and_should_not" do
  include InSubProcess

  it 'preserves should and should_not when passed true' do
    configure_with true
    expect(Object.new).to respond_to(:should, :should_not)
  end

  it 'removes should and should_not when passed false' do
    in_sub_process do
      configure_with false
      expect(Object.new).not_to respond_to(:should, :should_not)
    end
  end
end

describe "RSpec::Expectations.enable_should_and_should_not=" do
  it_behaves_like "configuring enable_should_and_should_not" do
    def configure_with(value)
      RSpec::Expectations.enable_should_and_should_not = value
    end
  end
end

describe "RSpec::Core.configuration.enable_should_and_should_not=" do
  it_behaves_like "configuring enable_should_and_should_not" do
    def configure_with(value)
      RSpec.configuration.enable_should_and_should_not = value
    end
  end
end

