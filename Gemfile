source "https://rubygems.org"

ruby file: ".ruby-version"

gem "rails", "~> 8.0.2"
gem "blueprinter"
gem "bootsnap", require: false # Reduces boot times through caching; required in config/boot.rb
gem "countries"
gem "cssbundling-rails" # Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "http"
gem "jsbundling-rails" # Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "oj"
gem "pg", "~> 1.1"
gem "propshaft" # The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "puma", ">= 5.0"
gem "rack-cors"
gem "solid_cache"
gem "solid_queue"
gem "thruster", require: false # Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "tzinfo-data", platforms: %i[ windows jruby ] # Windows does not include zoneinfo files, so bundle the tzinfo-data gem

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "rubocop-rails-omakase", require: false # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
end

group :development do
  gem "web-console"
  gem "rails-erd"
  gem "annotaterb"
end
