# frozen_string_literal: true

module RSpecParameterizedContext
  class Context
    def initialize(rspec_context)
      @rspec_context = rspec_context
      @where_names = []
      @where_block = nil
      @where_size = nil

      @with_them_block = nil
    end

    def where(*names, size:, focus_index: nil, &block)
      @where_names = names
      @where_size = size
      @where_block = block
    end

    def with_them(&block)
      @with_them_block = block
    end

    def define_spec
      raise '.where is not called' unless @where_block.respond_to?(:call)
      raise '.with_them is not called' unless @with_them_block.respond_to?(:call)

      where_block = @where_block
      where_names = @where_names
      where_size = @where_size
      with_them_block = @with_them_block

      where_size.times do |index|
        @rspec_context.context("parameterized phase ##{index}") do
          let(:_parameters) do
            instance_exec(&where_block)
          end

          before do
            raise "expected where(..., size: #{_parameters.size})" unless _parameters.size == where_size
          end

          where_names.each_with_index do |name, parameter_index|
            let(name) do
              _parameters[index][parameter_index]
            end
          end

          instance_exec(&with_them_block)
        end
      end
    end

    def method_missing(action, *args, **options, &block)
      @rspec_context.send(action, *args, **options, &block)
    end

    def respond_to_missing?(action, include_private)
      @rspec_context.respond_to?(action, include_private) || super
    end
  end

  def parameterized(&block)
    parameterized_context = RSpecParameterizedContext::Context.new(self)
    parameterized_context.instance_exec(&block)
    parameterized_context.define_spec
  end
end
