# CloudFilesTransfer

Transfer Rackspace Cloud Files assets from one container to another or from account to another.

## Installation

Add this line to your application's Gemfile:

    gem 'cloud_files_transfer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cloud_files_transfer

## Usage

Have Rackspace username, api key and container name ready for both origin and destination folders.

    $ rake cloud_files_assets:transfer

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
