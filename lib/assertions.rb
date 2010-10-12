module Assertions
  
  def assert_valid(record)
    # assert record.valid?, record.errors.full_messages_recursive.join("\n")
    assert record.valid?, record.errors.all_messages.join("\n")
  end
  
  def assert_valid_and_save!(record)
    assert_valid(record)
    record.save!
  end

end



ActiveSupport::TestCase.send(:include, Assertions)