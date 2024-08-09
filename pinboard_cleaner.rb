require 'json'

# Read pinboard.json and convert to markdown
# Pinboard json format:
# {"href"=>"http://justinlamb.org/",
# "description"=>"Link Title",
# "extended"=>"longer description",
# "meta"=>"key",
# "hash"=>"key",
# "time"=>"2010-08-31T03:51:53Z",
# "shared"=>"no",
# "toread"=>"no",
# "tags"=>"email productivity"}]
class PinboardCleaner
  def initialize
    @pinboard = parse_json(ARGV[0])
    clean if @pinboard
  end

  private

  def parse_json(file)
    JSON.parse(File.read(file))
  rescue JSON::ParserError => e
    puts "Failed to parse JSON: #{e.message}"
    nil
  end

  def clean
    data = @pinboard.map { |pin| format_pin(pin) }.join("\n")
    File.write('./pinboard.md', data)
  end

  def format_pin(pin)
    tags = clean_tags(pin['tags'])
    description = pin['description'].gsub(/\R+/, ' ')
    href = pin['href']
    extended = pin['extended'].gsub(/\R+/, ' ')

    string = "[#{description}](#{href})"
    string << " - #{extended}" if extended.length.positive?
    string << " - (Tags: #{tags})" if tags.length.positive?
    string
  end

  def clean_tags(tags)
    return '' unless tags

    all_tags = tags.split(' ')
    all_tags.reject { |tag| tag.include?('via:') }.join(' ')
  end
end

PinboardCleaner.new
