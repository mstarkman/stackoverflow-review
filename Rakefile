APPNAME = 'ember-skeleton'

require 'colored'
require 'rake-pipeline'

desc "Build #{APPNAME}"
task :build do
  Rake::Pipeline::Project.new('Assetfile').invoke
end

desc "Run tests with PhantomJS"
task :test => :build do
  unless system("which phantomjs > /dev/null 2>&1")
    abort "PhantomJS is not installed. Download from http://phantomjs.org/"
  end

  cmd = "phantomjs tests/run-tests.js \"file://#{File.dirname(__FILE__)}/tests/index.html\""

  # Run the tests
  puts "Running #{APPNAME} tests"
  success = system(cmd)

  if success
    puts "Tests Passed".green
  else
    puts "Tests Failed".red
    exit(1)
  end
end

namespace :update do
  def clone_repo(source, package_name)
    `git clone #{source} #{temp_location_for(package_name)}`
  end

  def temp_location_for(package_name)
    "tmp/#{package_name}"
  end

  def clean_temp_location(package_name)
    FileUtils.rm_rf temp_location_for(package_name)
  end

  def update_source(options)
    clean_temp_location options[:package_name]
    clone_repo options[:github_url], options[:package_name]
    yield temp_location_for(options[:package_name]) if block_given?
    clean_temp_location options[:package_name]
  end

  def copy_vendor_file(source, dest_path, dest_name)
    FileUtils.mkdir_p dest_path
    FileUtils.cp source, "#{dest_path}/#{dest_name}"
  end

  def copy_js(source, dest_name)
    copy_vendor_file source, "app/vendor/js", dest_name
  end

  def copy_img(source, dest_name)
    copy_vendor_file source, "app/vendor/img", dest_name
  end

  def copy_css(source, dest_name)
    copy_vendor_file source, "app/vendor/css", dest_name
  end

  desc "Update the minispade source"
  task :minispade do
    update_source package_name: "minispade", github_url: "https://github.com/wycats/minispade.git" do |temp|
      copy_js "#{temp}/lib/main.js", "minispade.js"
    end
  end

  desc "Update the handlebars.js source"
  task :handlebars do
    version = "1.0.rc.1"
    package_name = "handlebars"
    clean_temp_location package_name
    temp_path = temp_location_for(package_name)
    FileUtils.mkdir_p temp_path
    `curl http://cloud.github.com/downloads/wycats/handlebars.js/handlebars-#{version}.js >> #{temp_path}/handlebars.js`

    copy_js "#{temp_path}/handlebars.js", "handlebars.js"
  end

  desc "Update the ember.js source"
  task :ember_js do
    update_source package_name: "ember", github_url: "https://github.com/emberjs/ember.js.git" do |temp|
      Dir.chdir(temp) do
        `bundle install`
        `bundle exec rake dist`
      end

      copy_js "#{temp}/dist/ember.js", "ember.js"
    end
  end

  desc "Update the ember data source"
  task :ember_data do
    update_source package_name: "ember-data", github_url: "https://github.com/emberjs/data.git" do |temp|
      Dir.chdir(temp) do
        `bundle install`
        `bundle exec rake dist`
      end

      copy_js "#{temp}/dist/ember-data.js", "ember-data.js"
    end
  end

  desc "Update ember.js and ember data"
  task ember: [:ember_js, :ember_data]

  desc "Update the Twitter Bootstrap source"
  task :twitter_bootstrap do
    package_name = "twitter_bootstrap"
    temp_path = temp_location_for(package_name)
    clean_temp_location package_name
    FileUtils.mkdir_p temp_path
    `curl http://twitter.github.com/bootstrap/assets/bootstrap.zip >> #{temp_path}/bootstrap.zip`
    Dir.chdir(temp_path) do
      `unzip bootstrap.zip`
    end

    copy_css "#{temp_path}/bootstrap/css/bootstrap.css", "bootstrap.css"
    copy_css "#{temp_path}/bootstrap/css/bootstrap-responsive.css", "bootstrap-responsive.css"

    copy_img "#{temp_path}/bootstrap/img/glyphicons-halflings-white.png", "glyphicons-halflings-white.png"
    copy_img "#{temp_path}/bootstrap/img/glyphicons-halflings.png", "glyphicons-halflings.png"

    copy_js "#{temp_path}/bootstrap/js/bootstrap.js", "bootstrap.js"

    clean_temp_location package_name
  end

  desc "Update all vendor stuffs"
  task all: [:twitter_bootstrap, :ember, :minispade, :handlebars]
end
