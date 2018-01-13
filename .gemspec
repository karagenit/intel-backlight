Gem::Specification.new do |s|
    s.name          = 'intel-backlight'
    s.version       = IO.read('version.txt')
    s.license       = 'MIT'
    s.summary       = 'Set Screen Brightness on Intel Laptops'
    s.description   = 'This gem allows you to update your laptop screen backlight brightness on intel-based systems'
    s.homepage      = 'https://github.com/karagenit/intel-backlight'
    s.author        = 'Caleb Smith'
    s.email         = 'karagenit@outlook.com'
    s.files         = ['lib/backlight.rb']
    s.require_paths = ['lib/', 'bin/']
    s.executables   << 'backlight'
    s.platform      = Gem::Platform::RUBY

    s.add_development_dependency 'rubocop',                     '~> 0.49'
    s.add_development_dependency 'rdoc',                        '~> 4.2'
    s.add_development_dependency 'bundler',                     '~> 1.15'
    s.add_development_dependency 'rake',                        '~> 12.0'
    s.add_development_dependency 'test-unit',                   '~> 3.2'
    s.add_development_dependency 'github_changelog_generator',  '~> 1.14'
end
