require "ffi"

module Extension
  extend FFI::Library

  ffi_lib File.join(File.expand_path("../lib/target/release/libjruby_test.dylib", __FILE__))

  attach_function :env_test, [], :void

  def self.extension_env_test
    puts %(TEST: ENV["FOO"] = "something")
    ENV["FOO"] = "something"
    run_tests
    puts

    puts %(TEST: ENV.delete("FOO"))
    ENV["FOO"] = "something"
    ENV.delete("FOO")
    run_tests
    puts

    puts %(TEST: ENV["FOO"] = nil)
    ENV["FOO"] = "something"
    ENV["FOO"] = nil
    run_tests
    puts

    puts %(TEST: ENV.update("FOO" => nil))
    ENV["FOO"] = "something"
    ENV.update("FOO" => nil)
    run_tests
    puts

    puts %(TEST: ENV.clear && ENV.replace({}))
    ENV["FOO"] = "something"
    ENV.clear
    ENV.replace({})
    run_tests
    puts

    puts %(TEST: ENV["FOO"] = "")
    ENV["FOO"] = "something"
    ENV["FOO"] = ""
    run_tests
  end

  def self.run_tests
    test_ruby_env
    env_test
  end

  def self.test_ruby_env
    if ENV.key?("FOO")
      puts "Ruby result:      FOO = #{ENV["FOO"].inspect}"
    else
      puts "Ruby result:      FOO is not set"
    end
  end
end

Extension.extension_env_test
