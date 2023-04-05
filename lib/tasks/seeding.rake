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
        Rails.root.join('db', 'seeds', 'categories.rb'),
        Rails.root.join('db', 'seeds', 'users.rb'),
        Rails.root.join('db', 'seeds', 'restaurants.rb'),
        Rails.root.join('db', 'seeds', 'addresses.rb'),
        Rails.root.join('db', 'seeds', 'menu_items.rb'),
        Rails.root.join('db', 'seeds', 'reviews.rb'),
        Rails.root.join('db', 'seeds', 'comments.rb'),
      ]

      foundation_partials_path_array.each do |foundation_partial_path|
        load(foundation_partial_path) if File.exist?(foundation_partial_path)
      end

      # Rake::Task["db:seed:users"].invoke
      # Rake::Task["db:seed:restaurants"].invoke
    end

    # Load individual seed_partials located under seed_partials directory
    Dir[Rails.root.join('db', 'seeds', '*.rb')].each do |filename|
      task_name = File.basename(filename, '.rb')
      desc "Seed " + task_name + ", based on the file with the same name in `db/seeds/*.rb`"

      task task_name.to_sym => :environment do
        load(filename) if File.exist?(filename)
      end
    end

    # This is for if you want to run all seeds inside db/seeds directory in order
    desc "Inject all seeds under db/seeds into DB in correct order"
    task :all => :environment do
      foundation_partials_path_array = [
        Rails.root.join('db', 'seeds', 'categories.rb'),
        Rails.root.join('db', 'seeds', 'users.rb'),
        Rails.root.join('db', 'seeds', 'restaurants.rb'),
        Rails.root.join('db', 'seeds', 'addresses.rb'),
        Rails.root.join('db', 'seeds', 'menu_items.rb'),
        Rails.root.join('db', 'seeds', 'reviews.rb'),
        Rails.root.join('db', 'seeds', 'comments.rb'),
      ]

      foundation_partials_path_array.each do |foundation_partial_path|
        load(foundation_partial_path) if File.exist?(foundation_partial_path)
      end

      # Rake::Task["db:seed:users"].invoke
      # Rake::Task["db:seed:restaurants"].invoke
    end

  end # namespace :seed
end # namespace :db