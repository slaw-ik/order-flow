# frozen_string_literal: true

namespace :db do
  desc 'Recreate the database, load the schema, and initialize with the seed data'
  task reseed: :environment do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke
  end
end
