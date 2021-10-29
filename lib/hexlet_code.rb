# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  # Generates HTML tag
  class Tag
    def self.build(tag, **attributes)
      "#{tag}   #{attributes}"
    end
  end
end

puts HexletCode::Tag.build("img", src: "path/to/image")

