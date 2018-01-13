task :default => [:clean, :build, :install, :test]

task :build do
    sh "bundle install"
    sh "gem build .gemspec"
    sh "rdoc lib/"
end

task :install do
    sh "gem install intel-backlight-" + IO.read('version.txt') + ".gem"
end

task :clean do
    sh "gem uninstall intel-backlight"
    sh "rm *.gem"
end

task :test do
    sh "rubocop lib/intel-backlight"
    sh "./test/test-intel-backlight.rb"
end

task :publish do
    puts "Current Version: " + IO.read('version.txt')
    print "New Version: "
    vers = STDIN.gets.chomp
    IO.write('version.txt', vers)
    sh "rake build"
    sh "git commit -am \"Update Version\""
    sh "git tag -a v" + vers + " -m \"\""
    sh "git push origin master"
    sh "git push origin v" + IO.read('version.txt')
    sh "github_changelog_generator"
    sh "git commit -am \"Update Changelog\""
    sh "git push origin master"
    sh "gem push intel-backlight-" + IO.read('version.txt') + ".gem"
end
