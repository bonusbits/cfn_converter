
# Style tests. Rubocop
namespace :style do
  require 'rubocop/rake_task'
  desc 'RuboCop'
  RuboCop::RakeTask.new(:ruby)
end

desc 'Circle CI Tasks'
task circleci: %w(style:ruby)

desc 'Rubocop'
task default: %w(style:ruby)
