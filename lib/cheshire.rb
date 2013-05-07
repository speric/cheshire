module Cheshire
  def method_missing(meth, *args, &block)
    properties = meth.to_s.split("_and_")
    if properties.length > 0 && properties.each { |property| respond_to?(property.to_sym) }
      concatenate properties
    else
      super
    end
  end
  
  def concatenate(fields)
    #or build an array of fields and use join(' ')
    str = String.new
    fields.each {|field| str << "#{public_send(field.to_sym)} "}
    str.rstrip!
  end

  #implement respond_to?
  #chain like a.public_send(:shoots).public_send(:first).public_send(:name)
end
