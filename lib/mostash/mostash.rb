class MoStash < OpenStruct
  def initialize(init={})
    super({})
    __init__ init
  end

  def method_missing(method_name, *args)
    #dbg "#{method_name} was sent #{args.inspect}"
    if __is_setter__( method_name )
      super method_name, __adjusted_value__( args.first )
    else
      super
    end
  end

  def []=(key, value)
    self.send "#{key.to_s}=", value
  end

  def [](key)
    self.send "#{key.to_s}"
  end

  private

  def __init__(hash)
    hash.each_pair do |key, value|
      self.send "#{key.to_s}=", __adjusted_value__( value )
    end
  end

  def __adjusted_value__(value)
    case value
    when Hash then MoStash.new( value )
    when Array then value.map{ |v| __adjusted_value__( v ) }
    else value
    end
  end

  def __is_setter__(method_name)
    method_name.to_s =~ /=$/
  end
end
