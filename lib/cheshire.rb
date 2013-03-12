module Cheshire
  def method_missing(meth, *args, &block)
    fields = meth.to_s.split("_and_")
    if fields.split("_and_").length > 0 && fields.each { |field| respond_to?(field.to_sym) }
      run_conjoin(fields)
    else
      super
    end
  end
  
  def respond_to?()
  end
  
  def run_conjoin(fields)
    foo = String.new
    fields.each {|field| foo << "#{public_send(field.to_sym)} "}
    foo.chomp
  end
end