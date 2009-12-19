namespace :db do
	  
	desc "Drop, create, run all migrations on the database"
  task :recreate do
		for env in %w[development test]
			RAILS_ENV = env

			Rake::Task['environment'].invoke
			Rake::Task['db:drop'].invoke
			Rake::Task['db:create'].invoke
			Rake::Task['db:migrate'].invoke
		end
  end

	desc "Clear all data from the database"
  task :purge do
		for env in %w[development test]
			RAILS_ENV = env
			
      # todo: write a task that does this without dropping and recreating the database
  		Rake::Task['db:recreate'].invoke
		end
  end

end