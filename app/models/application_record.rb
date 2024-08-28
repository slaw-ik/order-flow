# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  scope :page, ->(page) { limit(10).offset((page - 1) * 10) }
end
