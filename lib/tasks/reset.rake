namespace :db do
  desc "Reset the parks table"
  task reset_parks: :environment do
    Park.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!('parks')
    puts "Parks table has been reset"
  end
end
