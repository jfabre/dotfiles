
require 'awesome_print'
submodules = `git submodule status`.split("\n")
  .reject{|l| l.include? 'fatal' }
  .map{|line| line.split[1] }

Dir.foreach('.') do |item|
  next if ['.', '..'].include? item 
  next unless File.directory?  item
  next if submodules.include?  item

  origin = `cd #{item}; git remote get-url origin`.strip
  puts origin
  `rm -rf #{item}`
  `git add .`
  `git submodule add #{origin} #{item}`
end
