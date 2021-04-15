# frozen_string_literal: true

class ChangeColumnNullOnBook < ActiveRecord::Migration[6.0]
  def change
    change_column_null :books, :title, false
    change_column_null :books, :author, false
  end
end
