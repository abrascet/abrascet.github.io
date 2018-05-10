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

  def initialize(id, model)
    @id = id
    @model = model
  end

  def render(path)
    template_content = nil
    File.open(File.expand_path("../template/#{path}"), "r:UTF-8") do |file|
      template_content = file.read
    end
    template = ERB.new(template_content)
    template.result(binding)
  end
end

common_model = YAML.load_file("../content/common.yml")
model = common_model.merge({})

page = Page.new("id", model)
content = page.render("home.erb")
File.open(File.expand_path("../index.html"), "w:UTF-8") do |file|
  file.write(content)
end
