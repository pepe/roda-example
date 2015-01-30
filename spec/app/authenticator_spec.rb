require 'authenticator_spec_helper'

RSpec.describe App::Authenticator do
  it 'can be initialized with params' do
    expect(App::Authenticator.new('pepe', 'pepe')).not_to be_nil
  end

  context 'is created' do
    subject { App::Authenticator.new('pepe', 'pepe') }

    it 'can authenticate with pepe:pepe :)', type: :sham do
      expect(subject).to be_valid
    end

    it 'knows its account' do
      auth = App::Authenticator.new('pepe', 'pepe')
      expect(subject.account).to eq 'pepe'
    end
  end
end
