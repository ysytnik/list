class Coordinate < ApplicationRecord


  has_and_belongs_to_many :valid_coordinate


#after_save :import_valid_coordinates
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |coordinate|
        csv << coordiante.attributes.values_at(*column_name)
      end
    end
  end

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      coordinate = find_by_id(row["id"]) || new
      coordinate.attributes = row.to_hash.slice(*row.to_hash.keys)
      coordinate.save!



    end
  end

  def new
    @coordinate = Coordinate.new
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".csv" then Roo::CSV.new(file.path, packed: nil, file_warning: :ignore)
      when ".xls" then Roo::Excel.new(file.path, packed: nil, file_warning: :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path, packed: nil, file_warning: :ignore)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
  #def import_valid_coordinates
  #columns = (Coordinate.column_names & ValidCoordinate.column_names) - ["id"]
  #ValidCoordinate.create(Coordinate.all.map(&:attributes) )

  #end
