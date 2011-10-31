class Mostash < Hash
  alias_method :orig_init, :initialize

  attr_accessor :default_proc

  def initialize(init={}, &def_proc)
    @default_proc = nil
    if init.is_a? Hash
      __init__ init
      self.send(:default=, init.default) if init.default
      @default_proc = init.default_proc if init.default_proc
    else
      super
    end
    @default_proc = def_proc if block_given?
  end

  def clone
    Mostash.new(self)
  end
  alias_method :dup, :clone

  def method_missing(method_name, *args, &block)
    #dbg "#{method_name} was sent #{args.inspect}, and block #{block.inspect}"
    return default_proc.call(self, method_name) if default_proc
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

  def merge!(from={})
    from.each_pair do |key, value|
      new_value = case value
                  when Hash then Mostash.new(self[key] || {}).merge(value)
                  else value
                  end
      self[key] = new_value
    end
    self
  end

  def merge(from={})
    self.clone.merge! from
  end

  private
  def __init__(hash)
    hash.each_pair do |key, value|
      self[key] =  __adjusted_value__( value )
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
