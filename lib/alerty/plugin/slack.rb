require 'alerty'
require_relative 'slack/version'
require_relative 'slack/slack_client'

class Alerty
  class Plugin
    class Slack
      def initialize(config)
        @payload = config.payload || {}
        if config.webhook_url
          raise ConfigError.new('slack: webhook_url is given, but empty') if config.webhook_url.empty?
          @client = SlackClient::IncomingWebhook.new(config.webhook_url)
        elsif config.slackbot_url
          raise ConfigError.new('slack: slackbot_url is given, but empty') if config.slackbot_url.empty?
          @client = SlackClient::Slackbot.new(config.slackbot_url)
        elsif config.webapi_token
          raise ConfigError.new('slack: webapi_token is given, but empty') if config.webapi_token.empty?
          @client = SlackClient::Webapi.new
          @payload['token'] = config.webapi_token
        end
        @client.log = Alerty.logger
        @client.https_proxy = config.https_proxy if config.https_proxy

        @num_retries = config.num_retries || 3
      end

      def alert(record)
        payload = build_payload(record).to_h
        with_retry(@num_retries) { @client.post_message(payload) }
      end

      private

      def with_retry(num_retries, &block)
        retries = 0
        begin
          yield
        rescue => e
          retries += 1
          sleep 1
          if retries <= num_retries
            retry
          else
            raise e
          end
        end
      end

      # https://api.slack.com/methods/chat.postMessage
      # https://api.slack.com/docs/messages
      # https://api.slack.com/docs/messages/builder
      # https://api.slack.com/docs/message-attachments
      def build_payload(record)
        deep_expand_placeholder(@payload, record)
      end

      def deep_expand_placeholder(obj, record)
        case obj
        when Hash
          obj.each do |k, v|
            obj[k] = deep_expand_placeholder(v, record)
          end
        when Array
          obj.each_with_index do |v, i|
            obj[i] = deep_expand_placeholder(v, record)
          end
        when String
          expand_placeholder(obj, record)
        end
      end

      def expand_placeholder(str, record)
        str.dup.tap {|s|
          s.gsub!('${hostname}', record[:hostname])
          s.gsub!('${command}', record[:command])
          s.gsub!('${exitstatus}', record[:exitstatus].to_s)
          s.gsub!('${output}', record[:output])
        }
      end
    end
  end
end
