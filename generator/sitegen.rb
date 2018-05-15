#!/usr/bin/env ruby

# sitegen.rb - a simple static site generator
#
# Abras Cet, Copyright 2018 Gabor Bata
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation files
# (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge,
# publish, distribute, sublicense, and/or sell copies of the Software,
# and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
# BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
# ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# encoding: UTF-8

require "erb"
require "yaml"

# Class representing a page
class Page

  attr_reader :id, :template, :model, :folder, :link

  def initialize(id, template, model, folder = nil)
    @id = id
    @template = template
    @model = model
    @folder = folder
    @link = @folder ? "#{@folder}/#{@id}.html" : "#{@id}.html"
  end

  def render(template_path = @template)
    template_content = nil
    File.open(File.expand_path("../template/#{template_path}"), "r:UTF-8") do |file|
      template_content = file.read
    end
    template = ERB.new(template_content, nil, '-')
    template.result(binding)
  end

  def absolute_url(domain, link = @link)
    @link == link ? "#{domain}/" : "#{domain}/#{link}"
  end

  def href(href)
    if ["../index.html", "index.html"].include?(href)
      "/"
    elsif href.start_with?("#{@folder}/")
      href.sub("#{@folder}/", "")
    else
      "#{@folder ? "../" : ""}#{href}"
    end
  end

  def generate(site_model)
    puts "Generating: id:#{@id}, template:#{@template}, link:#{@link}"
    @model = site_model.merge(@model)
    content = render("layout.erb")
    Dir.mkdir("../#{@folder}") if @folder && !Dir.exist?("../#{@folder}")
    File.open(File.expand_path("../#{@link}"), "w:UTF-8") do |file|
      file.write(content)
    end
  end
end

def create_home_page()
  model = YAML.load_file("../content/home.yml")
  page = Page.new("index", "home.erb", model)
end

def create_archive_page(image_pages)
  model = YAML.load_file("../content/archive.yml")
  page = Page.new("archiv", "archive.erb", model)
end

def create_about_page()
  model = YAML.load_file("../content/about.yml")
  page = Page.new("a-cetrol", "about.erb", model)
end

def create_image_pages()
  pages = []
  previous_page = nil
  YAML.load_file("../content/images.yml").each do |key, model|
    current_page = Page.new(key, "image.erb", model, "abra")
    if previous_page
      current_page.model["prev"] = previous_page
      previous_page.model["next"] = current_page
    end
    previous_page = current_page
    pages.push(current_page)
  end
  return pages
end

# Create pages
image_pages = create_image_pages()
home_page = create_home_page()
archive_page = create_archive_page(image_pages)
about_page = create_about_page()

# Load site model
site_model = YAML.load_file("../content/site.yml")
site_model["pages"] = {
  "home" => home_page,
  "images" => image_pages[0],
  "archive" => archive_page,
  "about" => about_page
}

# Generate pages
(image_pages + [home_page, archive_page, about_page]).each do |page|
  page.generate(site_model) if page
end
