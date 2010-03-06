namespace :db do

	  
	desc "Drop, create, run all migrations on the database"
  task :recreate do
		Rake::Task['environment'].invoke
		Rake::Task['db:drop'].invoke
		Rake::Task['db:create'].invoke
		Rake::Task['db:migrate'].invoke
  end


  # thanks to: http://www.manu-j.com/blog/truncate-all-tables-in-a-ruby-on-rails-application/221/
	desc "Clear all data from the database"
  task :purge => :load_config do
    begin
      config = ActiveRecord::Base.configurations[RAILS_ENV]
      ActiveRecord::Base.establish_connection
      connection = ActiveRecord::Base.connection
      case config["adapter"]
      when "mysql" then
        connection.tables.each {|table| connection.execute("TRUNCATE #{table}")}
      when "sqlite", "sqlite3" then
        connection.tables.each do |table|
          connection.execute("DELETE FROM #{table}")
          connection.execute("DELETE FROM sqlite_sequence where name='#{table}'")
        end
        connection.execute("VACUUM")
      end
    rescue
      $stderr.puts "Error while truncating. Make sure you have a valid database.yml file and have created the database tables before running this command. You should be able to run rake db:migrate without an error"
    end
  end
  
  
  namespace :fixtures do
    
    desc "Saves all data in the database to /test/fixtures"
    task :save => :environment do
      #RAILS_ENV="production"
      #Rake::Task['environment'].invoke
      
      # create fixtures backup path
      fixtures_dir = "#{RAILS_ROOT}/test/fixtures"
      if Dir.exists?(fixtures_dir)
        old_fixtures_dir = "#{RAILS_ROOT}/test/fixtures #{Time.now.strftime("%Y.%m.%d.%H.%M.%S")}"
        FileUtils.mv fixtures_dir, old_fixtures_dir, :force => true
      end
      Dir.mkdir(fixtures_dir)
      
      # backup tables
      ignored_tables = ['schema_info', 'schema_migrations', 'sessions', 'public_exceptions']
      tables = ActiveRecord::Base.connection.tables
      tables = tables.sort.reject {|tbl| ignored_tables.member?(tbl)}
      for table in tables
        yml = fixtures_dir + "/#{table}.yml"
        klass = table.classify.constantize
        unless klass.count.zero? 
          puts "Writing #{klass.count} fixtures to #{yml}"
          File.open(yml, "w") do |file|
            for record in klass.all
              file << "#{table}_#{record.id}:\r\n"
              record.attributes.each do |key, value|
                file << "  #{key}: #{to_yaml(value)}\r\n" unless value.nil?
              end
              file << "\r\n"
            end
          end
        end
      end
    end
    
    def to_yaml(value)
      case value
      when Fixnum, BigDecimal, FalseClass, TrueClass, Time, Date
        value.to_s
      when String
        "\"#{value}\""
      when Hash
        "{#{value.map {|k,v| "#{k}: #{to_yaml(v)}"}.join(", ")}}"
      else
        raise "unrecognized type #{value.class.name}"
      end
    end
    
=begin
    def to_fixtures(table)
	    fixtures = ""
      klass = table.classify.constantize
      puts klass.count
      for record in klass.all
        fixtures << "#{table}_#{record.object_id}:\r\n"
        YAML.dump record[:attributes], fixtures
        fixtures << "\r\n"
      end
      fixtures
    end
=end

  end


end