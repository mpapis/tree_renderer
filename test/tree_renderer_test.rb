=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

require "minitest_helper"
require "tree_renderer"
require "ostruct"

describe TreeRenderer do
  subject { TreeRenderer }

  describe "#new" do
    it "sets binding directly" do
      example = OpenStruct.new(a: 1).instance_eval { binding }
      subject.new("path1", "path2", example).var_binding.must_equal(example)
    end

    it "sets binding from object" do
      example = OpenStruct.new(a: 1)
      subject.new("path1", "path2", example).var_binding.must_be_instance_of(Binding)
    end

    it "sets binding from hash" do
      example = {a: 1}
      subject.new("path1", "path2", example).var_binding.must_be_instance_of(Binding)
    end
  end

  describe "#all_files" do
    it "lists all files in lib" do
      lib = File.expand_path("../../lib", __FILE__)
      subject.new(lib, "path2").send(:all_files).must_equal([
        "#{lib}/tree_renderer.rb",
        "#{lib}/tree_renderer/version.rb",
      ])
    end
  end

  describe "#transform_path" do
    it "transforms paths with erb" do
      subject.new(
        "/path1/bin", "/path2/lib", name: "file"
      ).send(
        :transform_path, "/path1/bin/some/path/<%= name %>.txt"
      ).must_equal(
        "/path2/lib/some/path/file.txt"
      )
    end
  end

  describe "#render" do
    it "render plain text" do
      subject.new(
        "/path1/bin", "/path2/lib"
      ).send(
        :render, "Lorem ipsum"
      ).must_equal(
        "Lorem ipsum"
      )
    end

    it "render text with erb" do
      subject.new(
        "/path1/bin", "/path2/lib", name: "dolor"
      ).send(
        :render, "Lorem ipsum <%= name %>"
      ).must_equal(
        "Lorem ipsum dolor"
      )
    end

    it "raises exceptions on missing variables" do
      proc {
        subject.new(
          "/path1/bin", "/path2/lib", nil
        ).send(
          :render, "Lorem ipsum <%= name %>"
        )
      }.must_raise NameError
    end
  end
end
