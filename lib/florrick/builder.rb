module Florrick
  class Builder

    VALID_EXPORT_TYPES = [String, Numeric, Date, Time]

    attr_reader :original_string, :objects

    def initialize(string, objects = {})
      @original_string = string
      @objects = objects
    end

    def output
      string = @original_string.dup
      string.gsub(/(\{\{([(\w+)\.]+)(?>\ ?\|\ ?([\w\-\+\ \!\?\[\]\(\)]+))?\}\})/) do
        original_string = $1
        fallback_string = $3
        parts = $2.split('.')
        final_string = nil
        previous_object = @objects[parts.shift.to_sym]

        if previous_object.nil?
          final_string = fallback_string || original_string
        end

        until final_string
          # get the latest part
          if var = parts.shift
            # if the previous object is suitable for string interpolation, we can
            # pass the var to it and get out a string or an integer.
            if previous_object.respond_to?(:string_interpolation_value_for)
              if previous_object.class.string_interpolation_for?(var)
                # we can do this easily
                previous_object = previous_object.string_interpolation_value_for(var)
                # if the previous object was nil, just set to an empty string
                final_string = "" if previous_object.nil?
              elsif previous_object.class.string_interpolation_relationship_for?(var)
                # maybe we can do this on another object
                previous_object = previous_object.send(var)
              else
                # can't do this :(
                final_string = fallback_string || original_string
              end
            elsif VALID_EXPORT_TYPES.any? { |t| previous_object.is_a?(t)}
              previous_object = Florrick::Formatter.convert(var, previous_object)
            else
              # does not respond to string_interpolation_value_for and isn't a valid object,
              # we can't do anything here just return the passed value.
              final_string = fallback_string || original_string
            end
          else
            # we're at the end now, if we can return the previous object, lets do it otherwise
            # we'll just return the string as we can't do anything.
            if VALID_EXPORT_TYPES.any? { |t| previous_object.is_a?(t)}
              final_string = previous_object.to_s
            else
              final_string = fallback_string || original_string
            end
          end
        end
        final_string
      end
    end

  end
end
