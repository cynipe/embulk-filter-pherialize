
Gem::Specification.new do |spec|
  spec.name          = 'embulk-filter-pherialize'
  spec.version       = '0.0.1'
  spec.authors       = ['cynipe']
  spec.summary       = 'Pherialize filter plugin for Embulk'
  spec.description   = 'Embulk plugin that deserialize PHP serialized strings to extract values as new column'
  spec.email         = ['cynipe@gmail.com']
  spec.licenses      = ['MIT']
  spec.homepage      = 'https://github.com/cynipe/embulk-filter-pherialize'

  spec.files         = `git ls-files`.split("\n") + Dir['classpath/*.jar']
  spec.test_files    = spec.files.grep(%r{^(test|spec)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'k-php-serialize', ['~> 1.2.1']

  spec.add_development_dependency 'embulk', ['>= 0.8.8']
  spec.add_development_dependency 'bundler', ['>= 1.10.6']
  spec.add_development_dependency 'rake', ['>= 10.0']
  spec.add_development_dependency 'pry'
end
