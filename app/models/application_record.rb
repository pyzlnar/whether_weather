# Class for shared functionality
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
