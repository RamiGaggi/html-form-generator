# frozen_string_literal: true

RSpec.describe HexletCode do
  it "has a version number" do
    expect(HexletCode::VERSION).not_to be nil
  end

  describe ".form_for" do
    context "with given user" do
      let(:abstract_user) { Struct.new(:name, :job, :gender, keyword_init: true) }
      let(:user) { abstract_user.new name: "ramil", job: "engineer", gender: "m" }
      let(:url) { "/users" }
      let(:file) { File.new("./spec/fixtures/html_tag.html", "r") }

      it "returns form" do
        html_form = described_class.form_for user, url: url do |f|
          f.input :name
          f.input :job, as: :text
          f.submit "Ok"
        end
        expect(html_form).to eq(file.read)
      end
    end
  end
end

RSpec.describe HexletCode::Tag do
  describe ".build" do
    context "with given self-closing tag" do
      it "returns self-closing tag" do
        expect(described_class.build("br")).to eq("<br>")
      end
    end

    context "with given self-closing tag with attributes" do
      it "returns self-closing tag with attributes" do
        expect(described_class.build("img", src: "path/to/image")).to eq(%(<img src="path/to/image">))
      end
    end

    context "with given pair-tag" do
      it "returns pair-tag" do
        expect(described_class.build("div")).to eq(%(<div></div>))
      end
    end

    context "with given pair-tag and attributes" do
      it "returns pair-tag with attributes" do
        expect(described_class.build("div", style: "color:red;")).to eq(%(<div style="color:red;"></div>))
      end
    end

    context "with given pair-tag, attributes, and body" do
      it "returns pair-tag with attributes and text" do
        expect(described_class.build("label", for: "email") { "Email" }).to eq(%(<label for=\"email\">Email</label>))
      end
    end
  end
end
