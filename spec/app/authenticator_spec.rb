require 'authenticator_spec_helper'

RSpec.describe App::Authenticator do
  it 'can be initialized with params' do
    expect(App::Authenticator.new('account' => 'pepe')).not_to be_nil
  end

  it 'can authenticate with pepe:pepe :)', type: :sham do
    auth = App::Authenticator.new('account' => 'pepe', 'password' => 'pepe')
    expect(auth).to be_valid
  end

  it 'knows its account' do
    auth = App::Authenticator.new('account' => 'pepe', 'password' => 'pepe')
    expect(auth.account).to eq 'pepe'
  end
end
