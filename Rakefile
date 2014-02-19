require 'cucumber/rake/task'

Cucumber::Rake::Task.new :features do |t|
  t.cucumber_opts = '-f junit features/wgoc_check_kai.feature --out .'
end 

Cucumber::Rake::Task.new :features_xp do |t|
  t.cucumber_opts = '-f junit features/wgoc_check_kai.feature --out C:\Documents and Settings\work\.jenkins\workspace\wg_merchant_oc_regression\'
end