#!/usr/bin/env ruby

# sitegen.rb - a static site generator
#
# Copyright (c) 2018 abrascet
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
require 'yaml'

# Class representing a page
class Page
  def initialize(id, template, model, folder = nil)
    @id = id
    @template = template
    @model = model
    @folder = folder
    @href = @folder ? "#{@folder}/#{@id}.html" : "#{@id}.html"
  end

  def render(template_path = @template)
    template_content = nil
    File.open(File.expand_path("../template/#{template_path}"), "r:UTF-8") do |file|
      template_content = file.read
    end
    template = ERB.new(template_content)
    template.result(binding)
  end

  def href(href)
    "#{@folder ? '../' : ''}#{href}"
  end

  def write
    content = render
    Dir.mkdir("../#{@folder}") if @folder && !Dir.exist?("../#{@folder}")
    File.open(File.expand_path("../#{@href}"), "w:UTF-8") do |file|
      file.write(content)
    end
  end
end

site_model = YAML.load_file("../content/site.yml")

model = site_model.merge({})
page = Page.new("index", "home.erb", model)
page.write

model = site_model.merge({})
page = Page.new("index", "home.erb", model, "abra")
page.write
