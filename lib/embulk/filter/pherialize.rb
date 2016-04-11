require 'php_serialize'

module Embulk
  module Filter
    #
    class Pherialize < FilterPlugin
      Plugin.register_filter('pherialize', self)

      def self.transaction(config, in_schema, &control)
        task = {
          'serialized_column'      => config.param('serialized_column', :string),
          'extract_fields'         => config.param('extract_fields', :array, default: []),
          'drop_serialized_column' => config.param('drop_serialized_column', :bool, default: false),
        }
        index = 0
        out_schema = in_schema.sort_by(&:index).reduce([]) do |mem, col|
          next mem if task['drop_serialized_column'] && col.name == task['serialized_column']
          mem << col.tap do |c|
            c.index = index
            index += 1
          end
          mem
        end
        size = out_schema.size
        out_schema += task['extract_fields'].map.each_with_index do |f, i|
          name = (in_schema.names.include? f['name']) ? "_#{f['name']}" : f['name']
          Column.new(size + i, name, f['type'].to_sym)
        end
        yield(task, out_schema)
      end

      def init
        @serialized_column = task['serialized_column']
        @extract_fields    = task['extract_fields']
        @drop_serialized_column = task['drop_serialized_column']
      end

      def close
      end

      def add(page)
        target = page.schema.find { |s| s.name == @serialized_column }
        page.each do |record|
          serialized = @drop_serialized_column ? record.delete_at(target.index) : record[target.index]
          data = PHP.unserialize(serialized)
          result = @extract_fields.map { |f| data[f['name']] }
          page_builder.add(record + result)
        end
      end

      def finish
        page_builder.finish
      end
    end
  end
end
