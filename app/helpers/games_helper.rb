module GamesHelper
  def position(column_number, row_number)
    column_number.to_i + row_number.to_i * 3
  end
end
