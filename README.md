# jRuby env tester

This is an jRuby example app using an extension, showing that environment
variables in jRuby are not cleared using `ENV.delete("FOO")`, `ENV["FOO"] =
nil`, etc. when fetched in an extension.

New values on an environment variable are synced, but it doesn't sync any
assignments to `nil` or `delete` calls.

The value unset changes on the ENV constant only work in the Ruby runtime and
not in any extension.

This is behavior differs from MRI.

## Requirements

- Rust installed
- Ruby MRI 2.3.5 installed
- jRuby 9.1.14.0 installed

## How to run

### MRI

```
(cd lib && cargo build --release)
chruby ruby-2.3.5 # or your Ruby version manager of choice
bundle install

bundle exec ruby app.rb
```

### jRuby

```
(cd lib && cargo build --release)
chruby jruby-9.1.14.0 # or your Ruby version manager of choice
bundle install

bundle exec ruby app.rb
```

## Test output

### MRI output

```
TEST: ENV["FOO"] = "something"
Ruby result:      FOO = "something"
Extension result: FOO = "something"

TEST: ENV.delete("FOO")
Ruby result:      FOO is not set
Extension result: FOO is not set

TEST: ENV["FOO"] = nil
Ruby result:      FOO is not set
Extension result: FOO is not set

TEST: ENV.update("FOO" => nil)
Ruby result:      FOO is not set
Extension result: FOO is not set

TEST: ENV.clear && ENV.replace({})
Ruby result:      FOO is not set
Extension result: FOO is not set

TEST: ENV["FOO"] = ""
Ruby result:      FOO = ""
Extension result: FOO = ""
```

### jRuby output

```
TEST: ENV["FOO"] = "something"
Ruby result:      FOO = "something"
Extension result: FOO = "something"

TEST: ENV.delete("FOO")
Ruby result:      FOO is not set
Extension result: FOO = "something"

TEST: ENV["FOO"] = nil
Ruby result:      FOO is not set
Extension result: FOO = "something"

TEST: ENV.update("FOO" => nil)
Ruby result:      FOO is not set
Extension result: FOO = "something"

TEST: ENV.clear && ENV.replace({})
Ruby result:      FOO is not set
Extension result: FOO = "something"

TEST: ENV["FOO"] = ""
Ruby result:      FOO = ""
Extension result: FOO = ""
```
