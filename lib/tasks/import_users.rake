namespace :import_users do
  desc "Creates users from the provided CSV"
  task :from_csv, [:file_path] => :environment do |_task, args|
    results = CreateUsersFromCSV.new(args.file_path).call
    puts "#{results[:successes].count} succeeded"
    puts "#{results[:failures].count} failed"
    results.fetch(:failures).each do |failure|
      puts failure.errors.details
    end
  end
end
