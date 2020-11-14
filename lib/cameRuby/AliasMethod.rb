# fornzen_string_literal: true

require 'active_support/all'

module CameRuby
  class AliasMethod
    # TODO: I get the following warning.
    # [WARNING] Attempted to create command "sayStatus" without usage or description.
    # Call desc if you want this method to be available as command or declare it inside a no_commands{} block.
    # Invoked from :in `alias_method'".
    def self.call
      ObjectSpace.each_object(Class) do |klass|
        klass.instance_methods.each do |method_name|
          camelized_name = method_name.to_s.camelize(:lower).to_sym
          next if camelized_name == method_name

          klass.instance_eval do
            alias_method(camelized_name, method_name)
          end
        rescue FrozenError => err
          next
        end
      end
    end
  end
end
