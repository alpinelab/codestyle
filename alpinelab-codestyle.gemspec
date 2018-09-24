# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "alpinelab/codestyle/version"

Gem::Specification.new do |spec|
  spec.name = "alpinelab-codestyle"
  spec.version = Alpinelab::Codestyle::VERSION
  spec.files = Dir["README.md", "LICENSE.md", "config/*.yml", "lib/**/*.rb"]

  spec.required_ruby_version = ">= 2.3.0"

  spec.summary = "Code style used by AlpineLab"
  spec.description = <<~DESCRIPTION
    This repository holds linter rules (e.g. Rubocop) that enforce our code
    style in any project (thanks to Rubocop `inherit_gem' directive) as well as
    other conventions not transposable as automated rules (those are explained
    as plain Markdown).
  DESCRIPTION
  spec.license = "MIT"
  spec.homepage = "https://www.alpine-lab.com"
  spec.authors = ["AlpineLab developers"]
  spec.email = ["dahu@alpine-lab.com"]
end
