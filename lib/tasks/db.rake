namespace 'db' do #Rails.application.class.parent do
  desc 'Clear all databases and populate with seed data'
  task repopulate: :environment do
    Rake::Task['db:mongoid:drop'].invoke
    Rake::Task['db:drop'].invoke
    Rake::Task['db:setup'].invoke
  end
end
