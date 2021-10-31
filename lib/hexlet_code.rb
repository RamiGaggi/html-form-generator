# frozen_string_literal: true

require_relative 'hexlet_code/version'

# Generates HTML form
module HexletCode
  # Check for self-closing tags
  module SelfClosingTag
    SELF_CLOSING = %w[
      area base br col
      command embed hr img
      input keygen link meta
      param source track wbr
    ].freeze
    def self_closing?(tag)
      SELF_CLOSING.include?(tag)
    end

    def build_tag(tag, attributes)
      incomplete_tag = ['<', tag]
      attributes == ' ' ? (incomplete_tag << '>').join : (incomplete_tag << attributes << '>').join
    end
  end

  # Generates HTML tag
  class Tag
    extend SelfClosingTag

    def self.build(tag, **attributes)
      attributes = ([''] << attributes.map { |key, el| "#{key}=\"#{el}\"" }).join(' ')
      first_tag = build_tag(tag, attributes)
      if self_closing?(tag)
        first_tag
      else
        "#{first_tag}#{yield if block_given?}</#{tag}>"
      end
    end
  end

  # Content between form tags <form>...</form>
  class UserFormBody
    def initialize(user)
      @user = user
      @tags = []
    end

    def input(attribute, as: :input, **attributes)
      tag = if as == :input
              Tag.build('input', name: attribute, type: 'text', value: @user.public_send(attribute), **attributes)
            else
              Tag.build('textarea', cols: 20, rows: 40, name: attribute, **attributes) { @user.public_send(attribute) }
            end
      @tags << Tag.build('label', for: attribute) { attribute.capitalize }
      @tags << tag
    end

    def submit(value = 'Save')
      @tags << Tag.build('input', name: 'commit', type: 'submit', value: value)
    end

    def generate
      @tags.map { |el| "  #{el}" }.join("\n")
    end

    def empty?
      @tags.empty?
    end
  end

  def self.form_for(user, url: '#')
    user_form = UserFormBody.new(user)
    yield user_form
    Tag.build('form', action: url, method: 'post') { user_form.empty? ? '' : "\n#{user_form.generate}\n" }
  end
end
