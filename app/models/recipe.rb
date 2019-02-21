class Recipe < ApplicationRecord
  belongs_to :recipe_type
  validates :title, :cuisine, :difficulty, :cook_time, :ingredients, 
            :cook_method, presence: true
  validates :cook_time, numericality: { greater_than: 0, message: "Tempo de preparo precisa ser maior que zero" }

  def cook_time_min
    "#{cook_time} minutos"
  end
end
