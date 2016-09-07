# Alerty::Plugin::Slack

Slack plugin for [alerty](https://github.com/sonots/alerty).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'alerty-plugin-slack'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install alerty-plugin-slack

## Configuration

- type: must be `slack`
- webhook_url: Slack Webhook URL. Get from https://slack.com/apps/A0F7XDUAZ-incoming-webhooks
- slackbot_url: Slack SlackBot URL. Get from https://analytics-support.slack.com/apps/A0F81R8ET-slackbot
- webapi_token: Slack WebAPI token
- payload
  - text: text message
  - channel: channel name
  - see https://api.slack.com/methods/chat.postMessage and https://api.slack.com/docs/message-attachments

## Placeholders

* `${hostname}`: hostname which rans the command
* `${command}`: a given command
* `${exitstatus}`: exitstatus of the executed command
* `${output}`: output of the executed command

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sonots/alerty-plugin-slack. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
