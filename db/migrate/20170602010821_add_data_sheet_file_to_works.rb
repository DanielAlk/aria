class AddDataSheetFileToWorks < ActiveRecord::Migration
  def change
  	add_attachment :works, :data_sheet_file
  end
end
