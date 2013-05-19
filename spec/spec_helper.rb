require 'mapquest'
require 'webmock'

RSpec.configure do |config|
  include WebMock::API
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  def fixture(filename)
    File.open(File.dirname(__FILE__) + '/fixtures/' + filename + '.json', 'r').read
  end

end
