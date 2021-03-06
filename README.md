[![Build Status](https://travis-ci.org/suzuki86/ftpspec.svg?branch=master)](https://travis-ci.org/suzuki86/ftpspec)

# FTPSpec

RSpec custom matchers for ftp server that enables you to test file structure like Serverspec.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ftpspec'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install ftpspec
```

## Usage

Execute ftpspec-init command.

```
$ ftpspec-init
```

Then, spec directory will be generated.

```
$ tree
.
├── Rakefile
└── spec
    ├── ftp_spec.rb
    └── spec_helper.rb

1 directory, 3 files
```

Write credentials of ftp server into spec/spec_helper.rb

```ruby
require "ftpspec"
require "rubygems"
require "rspec"
require "net/ftp"

RSpec.configure do |c| 
  c.add_setting :ftp, :default => nil 
  c.before do
    hostname = "YOUR HOSTNAME"
    user = "YOUR USER"
    password = "YOUR PASSWORD"
    c.ftp = Net::FTP.new
    c.ftp.passive = true
    c.ftp.connect(hostname)
    c.ftp.login(user, password)
    Ftpspec.set_ftp
  end 
  c.after do
    c.ftp.close
  end 
end
```

Write spec in each spec files.

```ruby
require "spec_helper"

describe "/httpdocs/index.html" do
  it { should be_mode "644" }
end
```

Execute rake command.

```
$ rake spec
```

Results are shown.

```
.

Finished in 2 seconds (files took 0.14477 seconds to load)
1 examples, 0 failures
```

## Matchers

### be_mode

Test whether file permission of subject is same as expected.

```ruby
describe "/httpdocs/index.html" do
  it { should be_mode "644" }
end
```

### be_file

Test whether subject is a file.

```ruby
describe "/httpdocs/index.html" do
  it { should be_file }
end
```

### be_directory

Test whether subject is a directory.

```ruby
describe "/httpdocs/images" do
  it { should be_directory }
end
```

### be_owned_by

Test whether subject is owned by expected owner.

```ruby
describe "/httpdocs/index.html" do
  it { should be_owned_by "someone" }
end
```

### be_grouped_into

Test whether subject is grouped into expected group.

```ruby
describe "/httpdocs/index.html" do
  it { should be_grouped_into "admin" }
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/ftpspec/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
