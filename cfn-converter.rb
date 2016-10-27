#!/usr/bin/env ruby

require 'yaml'
require 'json'
require 'optparse'
require 'pp'
require 'fileutils'
@script_version = '1.0.2-20161027'

# Parse Arguments/Options
@options = Hash.new
ARGV << '-h' if ARGV.empty?
options_parser = OptionParser.new do |opts|
  opts.banner = 'Usage: cfn-converter.rb -f filename.(json || yml || yaml) [options]'
  opts.separator ''
  opts.separator 'Options:'

  opts.on('-f', '--file FULLNAME', '(Required) JSON or YAML Template File Full Path if not in same Directory') do |opt|
    @options['source_file'] = opt
  end
  opts.on('-o', '--overwrite', 'Overwrite Output File') do
    @options['overwrite'] = true
  end

  opts.on_tail('-h', '--help', 'Show this message') do
    puts opts
    exit
  end
end
options_parser.parse(ARGV)

def show_header
  system 'clear' unless system 'cls'
  puts "CloudFormation Format Converter v#{@script_version} | Ruby v#{RUBY_VERSION} | by Levon Becker"
  puts '--------------------------------------------------------------------------------'
  puts "SOURCE FILE:  #{@options['source_file']}"
  puts "OUTPUT FILE:  #{@options['output_file']}"
  puts '--------------------------------------------------------------------------------'
end

def show_subheader(subtext)
  puts subtext
  puts '--------------------------------------------------------------------------------'
  puts ''
end

def show_report(message)
  puts "REPORT: #{message}"
end

def show_action(message)
  puts "ACTION: #{message}"
end

def show_error(message)
  puts ''
  puts "ERROR: #{message}"
  puts ''
  raise
end

def j2y
  show_action 'Converting JSON to YAML'
  y_file = File.open((@options['output_file']).to_s, 'a')
  y_file.write(YAML.dump(JSON.parse(IO.read(@options['source_file']))))
  y_file.close
  show_report 'Converted Successfully!'
end

def y2j
  show_action 'Converting YAML to JSON'
  j_file = YAML.load_file(File.open((@options['source_file']).to_s, 'r'))
  File.write (@options['output_file']).to_s, JSON.pretty_generate(j_file)
  show_report 'Converted Successfully!'
end

def output_verify
  show_header
  if @options['overwrite']
    show_report "Overwriting (#{@options['output_file']})"
  elsif File.exist?(@options['output_file'])
    show_error "Output File Already Exists! (#{@options['output_file']})"
  else
    show_report "Output File Does Not Yet Exist (#{@options['output_file']})"
  end
end

def set_output_file(file_extension, dir_name, file_name_noext)
  if file_extension == '.json'
    @options['output_file'] = File.join(dir_name, "#{file_name_noext}.yml")
    output_verify
    j2y
  elsif file_extension == '.yaml' || file_extension == '.yml'
    @options['output_file'] = File.join(dir_name, "#{file_name_noext}.json")
    output_verify
    y2j
  else
    show_error "ERROR: Unknown File Type (#{file_extension})"
  end
end

def perform_conversion
  if File.exist?(@options['source_file'])
    file_extension = File.extname(@options['source_file'])
    dir_name = File.dirname(@options['source_file'])
    file_name_noext = File.basename(@options['source_file'], '.*')
    set_output_file(file_extension, dir_name, file_name_noext)
  else
    show_error 'ERROR: Source Template File Not Found!'
  end
end

# Run
perform_conversion
# TODO: Call Cleanup Method to fix up conversion issues with intrinsic functions etc.
