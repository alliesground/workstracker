source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'

gem 'rails', '~> 5.1.3'
gem 'pg', '~> 0.18'
gem 'puma', '~> 4.3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'devise'
gem 'haml-rails', '~> 1.0'
gem 'semantic-ui-sass'
gem 'jquery-rails'
gem 'active_model_serializers', '~> 0.10.0'
gem 'simple_form'
gem 'octokit', '~> 4.0'
gem 'figaro'
gem 'draper'
gem 'gravtastic'
gem 'jwt'
gem 'rack-cors', :require => 'rack/cors'
gem 'sidekiq'
gem 'webpacker', '~> 4.x'
gem 'jsonapi-resources'
gem 'webpacker-react', "~> 1.0.0.beta.1"
gem 'public_activity'
gem 'redis', '~> 3.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
  gem 'rspec-rails', '~> 3.6'
  gem 'factory_girl_rails'
end

group :test do
  gem 'faker', '~> 1.6', '>= 1.6.3'
  gem 'database_cleaner'
  gem 'shoulda-matchers', '~> 3.1', '>= 3.1.2'
  gem 'vcr', '~> 3.0', '>= 3.0.3'
  gem 'webmock', '~> 3.0', '>= 3.0.1'
  gem 'capybara'
  gem 'launchy', '~> 2.4', '>= 2.4.3'
  gem 'capybara-email'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'letter_opener', '~> 1.4', '>= 1.4.1'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
