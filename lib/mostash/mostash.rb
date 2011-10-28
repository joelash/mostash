class Mostash < Hash
  alias_method :orig_init, :initialize
  def initialize(init={})
    if init.is_a? Hash
      __init__ init
    else
      super
    end
  end

  def method_missing(method_name, *args, &block)
    #dbg "#{method_name} was sent #{args.inspect}, and block #{block.inspect}"
    if __is_setter__( method_name )
      method_name = method_name.to_s.gsub! '=', ''
      self[method_name] = args.first
    else
      self[method_name]
    end
  end

  alias_method :__set__, :[]=
  def []=(key, value)
    __set__ key.to_sym, __adjusted_value__(value)
  end

  alias_method :__get__, :[]
  def [](key)
    __get__ key.to_sym
  end

  private
  def __init__(hash)
    hash.each_pair do |key, value|
      self[key.to_sym] =  __adjusted_value__( value )
    end
  end

  def __adjusted_value__(value)
    case value
    when Hash then Mostash.new( value )
    when Array then value.map{ |v| __adjusted_value__( v ) }
    else value
    end#.tap { |ret| dbg "calc adj value for #{value.inspect} = #{ret}" }
  end

  def __is_setter__(method_name)
    method_name.to_s =~ /=$/
  end
 
  def eigenclass
    class << self
      self
    end
  end
end
