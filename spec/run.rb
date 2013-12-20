# To launch the spec:

# ruby run.rb; guard

# then edit a file :)

puts `cd ..; gem build guard-concatfilter.gemspec`
puts `cd ..; gem install guard-concatfilter-0.0.4.gem`
