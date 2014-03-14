require 'cucumber/rake/task'

# Cucumber::Rake::Task.new :features do |t|
#   t.cucumber_opts = '-f junit features/wgoc_check_kai.feature --out .'
# end 

Cucumber::Rake::Task.new :features do |t|
  t.cucumber_opts = '-f junit --tags @run_test --out .'
end

# namespace :features do
#   Cucumber::Rake::Task.new(:win7) do |t|
#     t.profile = "win7"
#   end

#   Cucumber::Rake::Task.new(:xp) do |t|
#     t.profile = "xp"
#   end
# end