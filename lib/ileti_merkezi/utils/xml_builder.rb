module IletiMerkezi
  # XmlBuilder
  module XmlBuilder
    XML_TAG = '<%<tag>s>%<content>s</%<tag>s>'.freeze

    def hash_to_xml(hash)
      hash.each_with_object([]) do |(key, value), tags|
        tags << case value
                when Hash then create_xml_tag(key, hash_to_xml(value))
                when Array then array_to_xml(key, value)
                else
                  create_xml_tag(key, value)
                end
      end.flatten.join
    end

    private

    def array_to_xml(tag, collection)
      collection.map do |item|
        create_xml_tag(
          tag, (item.is_a?(Hash) ? hash_to_xml(item) : item)
        )
      end
    end

    def create_xml_tag(tag, content)
      format(XML_TAG, tag: tag, content: content)
    end
  end
end
