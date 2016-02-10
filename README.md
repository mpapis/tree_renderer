[![Gem Version](https://badge.fury.io/rb/tree_renderer.png)](https://rubygems.org/gems/tree_renderer)
[![Build Status](https://secure.travis-ci.org/mpapis/tree_renderer.png?branch=master)](https://travis-ci.org/mpapis/tree_renderer)
[![Dependency Status](https://gemnasium.com/mpapis/tree_renderer.png)](https://gemnasium.com/mpapis/tree_renderer)
[![Code Climate](https://codeclimate.com/github/mpapis/tree_renderer.png)](https://codeclimate.com/github/mpapis/tree_renderer)
[![Coverage Status](https://img.shields.io/coveralls/mpapis/tree_renderer.svg)](https://coveralls.io/r/mpapis/tree_renderer?branch=master)
[![Inline docs](http://inch-ci.org/github/mpapis/tree_renderer.png)](http://inch-ci.org/github/mpapis/tree_renderer)
[![Yard Docs](http://img.shields.io/badge/yard-docs-blue.svg)](http://rubydoc.info/github/mpapis/tree_renderer/master/frames)
[![Github Code](http://img.shields.io/badge/github-code-blue.svg)](https://github.com/mpapis/tree_renderer)

# Tree Renderer

Render set of templates, also renders the path names.

### Installation

    gem install tree_renderer

or add to `Gemfile`:

    gem "tree_renderer"

and `gem install --file`

### Usage

    TreeRenderer.new("/template/path", "/target/path", variables).save

`variables` can be either a hash, object or a binding.
