# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  # Generates HTML tag
  module Tag
    SELF_CLOSING = %w[
      area base br col
      command embed hr img
      input keygen link meta
      param source track wbr
    ].freeze

    def self.build(tag, **attributes)
      attributes = ([""] << attributes.map { |key, el| "#{key}=\"#{el}\"" }).join " "
      start_tag = ["<", tag]
      first_tag = attributes == " " ? (start_tag << ">").join : (start_tag << attributes << ">").join
      if SELF_CLOSING.include?(tag)
        first_tag
      else
        block_given? ? "#{first_tag}#{yield}</#{tag}>" : "#{first_tag}</#{tag}>" # yield if block_given? <- Linter!
      end
    end
  end
end
