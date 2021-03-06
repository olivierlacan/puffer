require 'kaminari'

require 'orm_adapter'
require 'puffer/orm_adapter/base'
require 'puffer/orm_adapter/active_record' if defined?(ActiveRecord::Base::OrmAdapter)
require 'puffer/orm_adapter/mongoid' if defined?(Mongoid::Document::OrmAdapter)
#require 'puffer/orm_adapter/data_mapper' if defined?(DataMapper::Resource::OrmAdapter)
#require 'puffer/orm_adapter/mongo_mapper' if defined?(MongoMapper::Document::OrmAdapter)

require 'puffer/extensions/controller'
require 'puffer/extensions/core'
require 'puffer/extensions/mapper'
require 'puffer/extensions/form'
require 'puffer/extensions/engine'
require 'puffer/engine'

module Puffer

  module Controller
    autoload :Action, 'puffer/controller/actions'
    autoload :MemberAction, 'puffer/controller/actions'
    autoload :CollectionAction, 'puffer/controller/actions'
  end
  
  module Component
    autoload :Base, 'puffer/component'

    mattr_accessor :_mappings
    self._mappings = {}

    def self.map_component *args
      to = args.extract_options![:to]
      args.each { |type| _mappings[type.to_sym] = to }
    end

    def self.component_for type
      (_mappings[type.to_sym] || "#{type}_component").to_s.camelize.constantize
    end

    map_component :belongs_to, :has_one, :to => :ReferencesOneComponent
    map_component :has_many, :has_and_belongs_to_many, :to => :ReferencesManyComponent
    map_component :date, :time, :datetime, :timestamp, :to => :DateTimeComponent
    map_component :integer, :decimal, :to => :StringComponent
    map_component :array, :decimal, :to => :StringComponent
  end

end
