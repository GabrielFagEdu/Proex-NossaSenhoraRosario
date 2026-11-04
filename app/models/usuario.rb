class Usuario < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true
    validates :senha, presence: true

    
end
     