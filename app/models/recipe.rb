class Recipe < ApplicationRecord

  validates :title, :recipe_type, :cuisine, :difficulty, :cook_time, :ingredients, 
            :cook_method, presence: true
  validates :cook_time, numericality: { greater_than: 0 }

  def cook_time_min
    "#{cook_time} minutos"
  end
end
