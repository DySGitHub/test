require_relative '../../sqlite_persistence'
require 'sequel'
require 'sqlite3'

describe SQLitePersistence do
   before(:each) do
      $DB = Sequel.sqlite(ENV['DB'] ) # memory database, requires sqlite3
      @sqlp = SQLitePersistence.new $DB
      @sqlp.startUp
   end
   describe "#isbnSearch" do
     context "when their is a match in d/b" do
           it "then it is retrieved and returned" do
                result = @sqlp.isbnSearch '1111'
                expect(result.title).to eql 'Title 1'
           end
     end
     context "when their is not a match in d/b" do
           it "then it returns nil" do
                result = @sqlp.isbnSearch '1114'
                expect(result).to be nil
           end
      end          
   end 
end