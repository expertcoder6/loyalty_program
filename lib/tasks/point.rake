namespace :point do
  desc "TODO"
  task update_every_year: :environment do
    LoyaltyPoint.update(point: 0)
  end

end
