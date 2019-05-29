###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

# Reload the browser automatically whenever files change
configure :development do
  path = File.expand_path "./data/me.json"
  unless File.exist? path
    File.open(path, "w") { |file| file.write "{}\n" }
  end
  activate :livereload
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end
require "lib/qrcode_helpers"
helpers QrcodeHelpers

# Build-specific configuration
configure :build do
  # Minify assets on build
  activate :minify_html
  activate :minify_css
  activate :minify_javascript

  # middleman-gh-pages
  activate :relative_assets
  set :relative_links, true
end


activate :deploy do |deploy|
  if File.exist? "./data/me.json"
    json = JSON.parse File.read("./data/me.json")
    github = json["info"].select { |item| item["url"].start_with? "https://github.com/" }.first if json["info"]
    remote = github["value"] if github
  end

  deploy.deploy_method = :git
  deploy.build_before = true
  deploy.remote = remote if remote
  deploy.branch = "master"
end
