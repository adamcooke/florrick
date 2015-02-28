module Florrick
  class DSL

    def initialize(model)
      @model = model
    end

    def string(*vars, &block)
      vars.each do |var|
        @model.florrick_fields[:strings][var.to_sym] = block
      end
    end

    def relationship(*vars, &block)
      vars.each do |var|
        @model.florrick_fields[:relationships][var.to_sym] = block
      end
    end
  end
end
