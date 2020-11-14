# fornzen_string_literal: true

require 'active_support/all'

module CameRuby
  module MethodMissing
    extend ActiveSupport::Concern
    module ClassMethods
      def method_missing(method, *args)
        snaky_name = method.to_s.underscore.to_sym
        if public_methods.include?(snaky_name)
          public_send(snaky_name, *args)
        else
          super
        end
      end

      def respond_to_missing?(method, include_private)
        snaky_name = method.to_s.underscore.to_sym
        public_methods.include?(snaky_name) ? true : super
      end
    end

    def method_missing(method, *args)
      snaky_name = method.to_s.underscore.to_sym
      if public_methods.include?(snaky_name)
        self.public_send(snaky_name, *args)
      else
        super
      end
    end


    def respond_to_missing?(method, include_private)
      snaky_name = method.to_s.underscore.to_sym
      public_methods.include?(snaky_name) ? true : super
    end
  end
end
