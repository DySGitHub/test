require_relative '../helper'
 
RSpec.configure do |c|
  c.include Helpers
end

require_relative '../../src/data_access'
require 'json'
require_relative '../../src/sqlite_persistence'
require 'sequel'
require 'sqlite3'

describe @DataAccess do
   before(:each) do
      $DB = Sequel.sqlite(ENV['DB'] )
      @sqlp = SQLitePersistence.new $DB
      @memcache_client = Dalli::Client.new(ENV['MCACHE'])
      @data_access = DataAccess.new(@sqlp, @memcache_client)
      @book1 = Book.new("1111", "title1","author1", 11.1, "genre1", 11)
      @book2 = Book.new("2222", "title2","author2", 22.2, "genre2", 22)
      @book3 = Book.new("3333", "title3","author1", 11.1, "genre1", 11)
      @book4 = Book.new("4444", "title4","author2", 22.2, "genre2", 22)
      @data_access.startUp
   end


  describe '#isbnSearch' do
     context "required book is not in the remote cache" do
         it "should get it from the database and put it in both caches" do
            result = @data_access.isbnSearch('1111') 
            expect(result).to eql @book1    
         end
     end
  end
 
end