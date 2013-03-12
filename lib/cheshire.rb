module Cheshire
  def method_missing(meth, *args, &block)
    delegate_to(meth) { |obj_properties| run_conjoin(obj_properties)}
  end
  
  def delegate_to(meth)
    properties = meth.to_s.split("_and_")
    if properties.split("_and_").length > 0 && properties.each { |property| respond_to?(property.to_sym) }
      yield properties
    else
      super
    end
  end

  def run_conjoin(fields)
    foo = String.new
    fields.each {|field| foo << "#{public_send(field.to_sym)} "}
    foo.rstrip
  end

  #implement respond_to?
  #chain like a.public_send(:shoots).public_send(:first).public_send(:name)
end