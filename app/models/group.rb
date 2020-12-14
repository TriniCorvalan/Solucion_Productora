class Group < ApplicationRecord
    has_many :concerts
    enum type_group: %w[Girlgroup Boygroup Band]
end