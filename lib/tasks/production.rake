require_relative '../../db/production_seeds'

namespace :production do
  desc "Seed the production database with tags, etc."
  task seed_tags: :environment do
    ProductionSeed.seed_tags
  end

  desc "Make a user a superadmin."
  task :make_superadmin, [:username, :password] => :environment do |task, args|
    ProductionSeed.superadmin(args[:username], args[:password])
  end

  desc "Seed first doctors and reviews"
  task seed_doctors: :environment do
    ProductionSeed.seed_insurance
    ProductionSeed.seed_anon_user
    ProductionSeed.seed_doctors
  end

end
