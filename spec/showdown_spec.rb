require 'spec_helper'

describe Showdown do
  it 'has a version number' do
    expect(Showdown::VERSION).not_to be nil
  end
end

describe Showdown::RackApp do
end

describe Showdown::Converter do
  include Showdown::Converter

  before(:all) { @target_path = File.expand_path('../support/test.md', __FILE__) }

  describe '#converted_html' do
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

describe Showdown::WatchDog do
  include Showdown::WatchDog

  before(:all) { @target_path = File.expand_path('../support/test.md', __FILE__) }

  describe '#file_changed?' do
    context 'file is chenged' do
      before(:each) do
        test_time = Time.now
        FileUtils.touch(@target_path, mtime: test_time)
        @old_file_mtime = test_time - 60 # a minute ago
      end

      it { expect(file_changed?).to eq true }
    end

    context "file isn't chenge" do
      before(:each) do
        test_time = Time.now
        FileUtils.touch(@target_path, mtime: test_time)
        @old_file_mtime = test_time
      end

      it { expect(file_changed?).to eq false }
    end
  end
end
