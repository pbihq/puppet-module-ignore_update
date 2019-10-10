require 'spec_helper'
describe 'ignore_update' do
  context 'with default values for all parameters' do
    it { should contain_class('ignore_update') }
  end
end
