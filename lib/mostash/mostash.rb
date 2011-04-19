class Mostash < OpenStruct
  def initialize(init={})
    super({})
    @initial_hash = init
    __init__ init
  end

  def method_missing(method_name, *args, &block)
    #dbg "#{method_name} was sent #{args.inspect}, and block #{block.inspect}"
    if @table.respond_to? method_name
      @table.send method_name, *args, &block
    elsif __is_setter__( method_name )
      super method_name, __adjusted_value__( args.first )
    else
      super || @initial_hash.send(:[], method_name, *args, &block)
    end
  end

  def []=(key, value)
    self.send "#{key.to_s}=", value
  end

  def [](key)
    self.send "#{key.to_s}"
  end

  def merge(new_hash)
    new_mo = @table.merge( new_hash ) do |key, oldval, newval|
      if oldval.class == Mostash
        oldval.merge newval
      else
        newval
      end
    end
    Mostash.new( new_mo )
  end

  #TODO: HACK!!!!!
  def merge!(new_hash)
    @table = self.merge( new_hash ).instance_variable_get( '@table' )
    self
  end

  def to_hash
    hash = {}
    @table.each_pair do |key, value|
      hash[key] = if value.class == Mostash
                    value.to_hash
                  else
                    value
                  end
    end
    hash
  end

  private

  def __init__(hash)
    hash.each_pair do |key, value|
      self.send "#{key.to_s}=", __adjusted_value__( value )
    end
  end

  def __adjusted_value__(value)
    case value
    when Hash then Mostash.new( value )
    when Array then value.map{ |v| __adjusted_value__( v ) }
    else value
    end
  end

  def __is_setter__(method_name)
    method_name.to_s =~ /=$/
  end
end
