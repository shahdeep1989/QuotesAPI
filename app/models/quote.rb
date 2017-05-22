require 'roo'
class Quote < ActiveRecord::Base
	belongs_to :category

	validates :quote, presence: true, uniqueness: true
	validates :cnt, numericality: { only_integer: true, :greater_than_or_equal_to =>0 }
        




	def self.open_spreadsheet(file)
		puts "----- file ---------"
	  		puts file.inspect
	  		puts "----- file path ---------"
	  		puts file.path
	  case File.extname(file.original_filename)
		  when ".csv" then Csv.new(file.path, nil, :ignore)
		  #when ".xls" then Excel.new(file.path, nil, :ignore)
		  when ".xls" then Roo::Excel.new(file.path, packed: false, file_warning: :ignore) #Roo::Excelx.new(file.path, :ignore)
		  #when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
		  when ".xlsx" then Roo::Excelx.new(file.path, packed: false, file_warning: :ignore) #Roo::Excelx.new(file.path, :ignore)
		  else raise "Unknown file type: #{file.original_filename}"
	  end
	end

	def self.import(file, category_id)
	  spreadsheet = open_spreadsheet(file)
	  header = spreadsheet.row(1)
	  (2..spreadsheet.last_row).each do |i|
	    row = Hash[[header, spreadsheet.row(i)].transpose]
	    Quote.create(:quote => row["QUOTE"], :author => row["PERSON WHO SAID IT"], :category_id => category_id)
	  end
	end

end