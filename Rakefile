require 'bundler'
Bundler::GemHelper.install_tasks

namespace :doc do
  require 'yard'
  YARD::Rake::YardocTask.new do |task|
    task.files   = [ 'lib/**/*.rb']
    task.options = [
      '--protected',
      '--output-dir', 'doc/yard',
      '--tag', 'format:Supported formats',
      '--tag', 'authenticated:Requires Authentication',
      '--tag', 'rate_limited:Rate Limited',
      '--markup', 'markdown',
    ]
  end
end
