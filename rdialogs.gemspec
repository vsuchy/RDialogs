lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rdialogs/version'

Gem::Specification.new do |spec|
  spec.name    = 'rdialogs'
  spec.version = RDialogs::VERSION
  spec.authors = ['Vladimir Suchy']
  spec.email   = ['vs.git@vsuchy.com']

  spec.summary     = 'A ruby wrapper for ncurses dialog and newt whiptail.'
  spec.description = 'RDialogs allows ruby scripts to display dialog boxes using ncurses dialog' \
    ' or newt whiptail. RDialogs can be used to display information to the user,' \
    ' or to get input from the user in a friendly way.'
  spec.homepage    = 'http://vsuchy.github.io/RDialogs/'
  spec.license     = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.0.0'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rake'
end
