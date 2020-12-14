class Group < ApplicationRecord
    has_many :concerts, dependent: :destroy
    enum type_group: %w[Girlgroup Boygroup Band]
end