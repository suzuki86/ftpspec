[![Build Status](https://travis-ci.org/suzuki86/ftpspec.svg?branch=master)](https://travis-ci.org/suzuki86/ftpspec)

# Work in progress

This project is under development.

# FTPSpec

RSpec custom matchers for ftp server that enables you to test file structure like Serverspec.

## Installation

Clone to your machine.

```
git clone https://github.com/suzuki86/ftpspec.git
```

Move to directory you cloned.

```
cd ftpspec
```

Create a gem from ftpspec.gemspec with `gem build`.

```
gem build ftpspec.gemspec
```

Install generated ftpspec-x.x.x.gem with `gem install`

```
gem install ftpspec-x.x.x.gem
```

## Usage

Execute ftpspec-init command.

```
ftpspec-init
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
  it { should be_mode 644 }
end
```

Execute rake command.

```
rake spec
```

## Matchers

### be_mode

Test whether file permission of subject is same as expected.

```
describe "/httpdocs/index.html" do
  it { should be_mode 644 }
end
```

### be_file

Test whether subject is a file.

```
describe "/httpdocs/index.html" do
  it { should be_file }
end
```

### be_directory

Test whether subject is a directory.

```
describe "/httpdocs/images" do
  it { should be_directory }
end
```

### be_owned_by

Test whether subject is owned by expected owner.

```
describe "/httpdocs/index.html" do
  it { should be_owned_by "someone" }
end
```

### be_grouped_into

Test whether subject is grouped into expected group.

```
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
