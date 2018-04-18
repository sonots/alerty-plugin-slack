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
- slackbot_url: Slack SlackBot URL. Get from https://slack.com/apps/A0F81R8ET-slackbot
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

```
bundle exec alerty -c example/slackbot.yml -- ls /this_is_a_test
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sonots/alerty-plugin-slack. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
