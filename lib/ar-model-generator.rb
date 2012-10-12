require "highline"
require "active_record"
require "active_support/all"
require "fileutils"
module ArModelGenerator
  module_function
  def cli

    connection = {}
    connection[:database] = h.ask "Database Name?"
    connection[:username] = h.ask "Database User?"
    connection[:password] = h.ask "Database Password? (not shown)" do |q|
       q.echo = false
    end
    connection[:adapter] = h.ask "Database Adapter?", lambda{|s| s.to_sym} do |q|
      q.default = :mysql2
    end
    connection[:host] = h.ask "Database Host?" do |q|
      q.default = "localhost"
    end

    ActiveRecord::Base.establish_connection connection
    ActiveRecord::Base.connection
    $stdout.puts h.color("Connection established", :green)

    namespace = h.ask "Namespace for models (lowercase singular ok)?"
    create_models(namespace, connection)

    $stdout.puts "DONE. please look inside the Base.rb and delete/replace
    connection information with something like :#{namespace.downcase} from your database.yml"
  end

  def h
    @h ||= HighLine.new
  end

  def create_models(namespace, connection)
    path = "app/models/#{namespace}/"
    namespace_up = namespace.classify
    FileUtils.mkdir_p path

    # Base-File
    base_path = path + "base.rb"
    File.open(base_path , "w+") do |f|
      f.write "class #{namespace_up}::Base < ActiveRecord::Base\n  self.abstract_class = true\n  establish_connection(#{connection.inspect}) end\n"
    end
    $stdout.puts h.color("Writing #{base_path}", :green)

    ActiveRecord::Base.connection.tables.each do |table_name|
      table_up = table_name.classify
      string = "class #{namespace_up}::#{table_up} < #{namespace_up}::Base\n  self.table_name = '#{table_name}'"

      if table_has_type_column?(table_name)
        $stderr.puts "Table #{table_name} has column :type. Adding inheritance_column."
        string += "\n  self.inheritance_column = :sti_type"
      end
      string += add_table_id_column(table_name)
      string += "\nend\n"

      target_path = path + "#{table_up.underscore}.rb"
      $stdout.puts h.color("Writing #{namespace_up}::#{table_up} to #{target_path}", :green)
      File.open(target_path, "w+") { |f|
        f.write string
      }
    end
  end

  def table_has_type_column?(table)
    ActiveRecord::Base.connection.columns(table).map(&:name).include? "type"
  end

  def add_table_id_column(table)
    columns = ActiveRecord::Base.connection.columns(table).map(&:name)
    return "" if columns.include? "id"
    if col = columns.find{|i| i[/id$/i]}
      message = "Automatically inferred ID colum of #{table} to #{col}"
      $stderr.puts
      "\n  self.primary_key = '#{col}'\n  # #{message}\n"
    else
      $stderr.puts "WARNING: Could not determine id-colum of #{table}"
      ""
    end
  end
end
