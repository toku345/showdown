require 'spec_helper'

describe MdPreview do
  it 'has a version number' do
    expect(MdPreview::VERSION).not_to be nil
  end
end

describe MdPreview::RackApp do
end

describe MdPreview::Converter do
  include MdPreview::Converter

  describe '#converted_html' do
    before(:all) { @target_path = File.expand_path('../support/test.md', __FILE__) }

    let(:expected_html) { "<p>This is <em>bongos</em>, indeed.</p>\n" }

    context '@markdown is nil' do
      before(:each) { @markdown = nil }

      it 'return converted html' do
        expect(converted_html).to eq expected_html
      end
    end

    context '@markdown is not nil' do
      before(:all) { @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML) }

      it 'return converted html' do
        expect(converted_html).to eq expected_html
      end
    end
  end
end

describe MdPreview::WatchDog do
end
