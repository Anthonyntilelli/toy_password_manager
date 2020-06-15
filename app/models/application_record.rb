# frozen_string_literal: true

# Abstract active record base
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
