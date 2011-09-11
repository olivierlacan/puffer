module Puffer
  module OrmAdapter
    module Base

      def columns_hash
        raise NotSupportedError
      end

    end
  end
end

OrmAdapter::Base.send :include, Puffer::OrmAdapter::Base