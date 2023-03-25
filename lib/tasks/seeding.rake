# lib/tasks/custom_seed.rake
namespace :db do
  namespace :seed do

    ### BEGIN DROP, CREATE, MIGRATE DATABASE ###
    desc "Database will be dropped, created again, all migrations will run, and database will be seeded with required data."
    task :rdcm => :environment do
      Rake::Task["db:drop"].invoke
      Rake::Task["db:create"].invoke
      Rake::Task["db:migrate"].invoke

      partials_path_array = [
        # Rails.root.join('db', 'seeds', 'categories.rb'),
      ]

      partials_path_array.each do |partial_path|
        load(partial_path) if File.exist?(partial_path)
      end
    end
    ### END DROP, CREATE, MIGRATE DATABASE ###

    ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
    ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

    desc "DB dropped, created, migrated, followed by seeding users, categories, and brands"
    task :foundation => :environment do
      # Purge ActiveStorage tables and all files stored in subdirectories under storage/
      ActiveStorage::Attachment.all.each do |attachment|
        attachment.purge
      end
      puts "\tPurged all Attachments from ActiveStorage."

      Rake::Task["db:drop"].invoke
      Rake::Task["db:create"].invoke
      Rake::Task["db:migrate"].invoke

      foundation_partials_path_array = [
        # Rails.root.join('db', 'seeds', 'categories.rb'),
        Rails.root.join('db', 'seeds', 'users.rb'),
        # Rails.root.join('db', 'seeds', 'profiles.rb'),
      ]

      foundation_partials_path_array.each do |foundation_partial_path|
        load(foundation_partial_path) if File.exist?(foundation_partial_path)
      end
    end

  end # namespace :seed
end # namespace :db