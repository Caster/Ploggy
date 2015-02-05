#!/usr/bin/env ruby

require 'fileutils'

destination_dir = nil
ARGV.each{|a|
    destination_dir = a
    break
}

if destination_dir == nil or not File.directory?(destination_dir)
    puts "Usage: use_ploggy [destination_dir]"
    exit 1
end

if not File.exists?(File.join(destination_dir, 'nanoc.yaml'))
    puts "Destination directory does not appear to be a nanoc site."
    exit 2
end

# list of files to copy
base_dir = File.expand_path(File.dirname(__FILE__))
files_to_copy = [
    ['commands', 'addlog.rb'],
    ['content', 'items', 'index.rhtml'],
    ['lib', 'helpers', 'ploggy.rb'],
    ['Rules']
]

# copy all files
files_to_copy.each{|rf|
    src_f = File.join(base_dir, *rf)
    dest_f = File.join(destination_dir, *rf)
    if not FileUtils.identical?(src_f, dest_f)
        FileUtils.cp(src_f, dest_f, {verbose: true})
    end
}

# output a warning
rf = ['lib', 'helpers', 'ploggy_config.rb']
puts "Done. You possible need to manually merge or"
puts "  cp " + File.join(base_dir, *rf) + " " + File.join(destination_dir, *rf) + "."
puts "This is not done automatically to prevent overwriting of your project configuration."
