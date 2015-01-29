$LOAD_PATH.unshift('lib')

require 'app'

run App::User.freeze.app
