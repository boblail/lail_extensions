TestTaskWithoutDescription.new("test:me" => "test:prepare") do |t|
  t.libs << "test"
  t.pattern = ["test/unit/**/*_test.rb", "test/functional/**/*_test.rb", "test/integration/**/*_test.rb"]
end
