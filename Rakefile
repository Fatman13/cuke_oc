require 'cucumber/rake/task'

# Cucumber::Rake::Task.new :features do |t|
#   t.cucumber_opts = '-f junit features/wgoc_check_kai.feature --out .'
# end 

Cucumber::Rake::Task.new :features do |t|
  t.cucumber_opts = '-f junit features/wgoc_check_kai.feature --out "C:/Documents and Settings/work/.jenkins/workspace/wg_merchant_oc_regression/"'
end

# namespace :features do
#   Cucumber::Rake::Task.new(:win7) do |t|
#     t.profile = "win7"
#   end

#   Cucumber::Rake::Task.new(:xp) do |t|
#     t.profile = "xp"
#   end
# end