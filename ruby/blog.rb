# The script generates HTML files from the Markdown files, creates an index file with the list of posts, and copies other files from the source directory to the output directory.
# The script also generates an RSS feed file.
# The script uses the Kramdown gem to convert Markdown to HTML and the RSS gem to generate the RSS feed.
# The script uses the WEBrick gem to start a local web server to serve the generated blog.
# The script takes two arguments: the path to the directory containing the Markdown files and the path to the output directory.
# The script checks if the output directory is empty and asks for confirmation before recreating it.
# The script uses the Umami analytics script to track page views.
require 'fileutils'
require 'kramdown'
require 'time'
require 'rss'

$titulo = %q{sixhat's bookmarks}
$umami = %q{<script defer src="https://cloud.umami.is/script.js" data-website-id="69f3152f-7fa7-4301-afad-2e1467d0701f"></script>}

def convert_markdown_to_html(md_content)
    Kramdown::Document.new(md_content, input: 'GFM').to_html
end

def generate_blog(posts, output_path, posts_directory)
  FileUtils.mkdir_p(output_path) unless Dir.exist?(output_path)
  posts.each do |post|
    html_content = convert_markdown_to_html(post[:content])
    output_file = File.join(output_path, post[:relative_path], "#{File.basename(post[:filename], '.md')}.html")
    FileUtils.mkdir_p(File.dirname(output_file))
    File.write(output_file, "<!DOCTYPE html><html><head><title>#{post[:title]}</title><link rel='stylesheet' type='text/css' href='/style.css'>#{$umami}</head>\n<body><header><h1>#{$titulo}</h1></header>#{html_content}<footer><a href='/index.html'>Home</a></footer></body></html>")
  end
  generate_index(posts, output_path)
  generate_rss_feed(posts, output_path)
  copy_other_files(posts_directory, output_path)
end

def generate_index(posts, output_path)
    index_content = "<!DOCTYPE html><html><head><title>sixhat's bookmarks index</title><link rel='stylesheet' type='text/css' href='/style.css'>#{$umami}</head>\n<body><header><h1>#{$titulo}</h1></header><hr>"
    sorted_posts = posts.sort_by { |post| post[:modified_time] }.reverse
    recent_posts = sorted_posts.first(10)
    recent_posts.each do |post|
        html_content = convert_markdown_to_html(post[:content])
        index_content += "<article><div>#{html_content}</div></article>"
    end
    index_content += "<h2>Index</h2><ul>"
    sorted_posts.each do |post|
        post_filename = File.join(post[:relative_path], "#{File.basename(post[:filename], '.md')}.html")
        index_content += "<li><a href='#{post_filename}'>#{post[:title]}</a> - <small>#{post[:modified_time].strftime('%Y-%m-%d %H:%M:%S')}</small></li>"
    end
    index_content += "</ul><footer><a href='/index.html'>Home</a></footer></body></html>"
    File.write(File.join(output_path, 'index.html'), index_content)
end

def generate_rss_feed(posts, output_path)
  rss = RSS::Maker.make("atom") do |maker|
    maker.channel.author = "David Sousa-Rodrigues"
    maker.channel.updated = Time.now.to_s
    maker.channel.about = "https://www.sixhat.net/feed.xml"
    maker.channel.title = "sixhat.net RSS Feed"

    posts.each do |post|
      maker.items.new_item do |item|
        item.link = "https://www.sixhat.net/#{post[:relative_path]}/#{File.basename(post[:filename], '.md')}.html"
        item.title = post[:title]
        item.updated = post[:modified_time].to_s
        item.content.content = convert_markdown_to_html(post[:content])
      end
    end
  end

  File.write(File.join(output_path, 'rss.xml'), rss)
end

def load_posts_from_directory(directory)
  posts = []
  Dir.glob("#{directory}/**/*.md").each do |filepath|
    content = File.read(filepath)
    lines = content.lines
    title = if lines.first.start_with?('---')
              File.basename(filepath, '.md')
            else
              lines.find { |line| !line.strip.empty? }.gsub(/^#+/, '').strip
            end
    modified_time = File.mtime(filepath)
    relative_path = File.dirname(filepath).sub(directory, '')
    posts << { title: title, content: content, filename: File.basename(filepath), modified_time: modified_time, relative_path: relative_path }
  end
  posts
end

def copy_other_files(src_directory, dest_directory)
  Dir.glob("#{src_directory}/**/*").each do |src_path|
    next if File.directory?(src_path)
    next if File.extname(src_path) == '.md'
    dest_path = File.join(dest_directory, src_path.sub(src_directory, ''))
    FileUtils.mkdir_p(File.dirname(dest_path))
    FileUtils.cp(src_path, dest_path)
  end
end

if ARGV.length != 2
  puts "Usage: ruby blog.rb <posts_directory> <output_directory>"
  exit 1
end

posts_directory = ARGV[0]
unless Dir.exist?(posts_directory)
    puts "Error: The specified posts directory does not exist."
    exit 1
end

output_directory = ARGV[1]

posts_parent_directory = File.expand_path('..', posts_directory)
output_parent_directory = File.expand_path('..', output_directory)

unless posts_parent_directory == output_parent_directory
    puts "Error: The posts directory and output directory must have the same parent directory."
    exit 1
end
if Dir.exist?(output_directory) && !Dir.empty?(output_directory)
    puts "Warning: The specified output directory is not empty. Do you want to continue and recreate the directory? (yes/no)"
    answer = $stdin.gets.chomp.downcase
    if answer != 'yes' && answer != ''
        puts "Operation aborted."
        exit 1
    else
        puts "The directory #{output_directory} is going to be deleted and recreated."
        FileUtils.rm_rf(output_directory)
        FileUtils.mkdir_p(output_directory)
    end
else
    FileUtils.mkdir_p(output_directory)
end

posts = load_posts_from_directory(posts_directory)
generate_blog(posts, output_directory, posts_directory)
puts "Blog generation process completed. You can open the index file at #{File.join(output_directory, 'index.html')} to view the blog."

require 'webrick'

server = WEBrick::HTTPServer.new(
    Port: 8000,
    DocumentRoot: output_directory,
    MimeTypes: WEBrick::HTTPUtils::DefaultMimeTypes.merge({
        'html' => 'text/html; charset=UTF-8'
    })
)

trap 'INT' do
    server.shutdown
end

puts "Starting server at http://localhost:8000"
server.start
