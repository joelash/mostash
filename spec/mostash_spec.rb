require 'spec_helper'

describe MoStash do

  it "should act like basic OpenStruct" do
    mo = MoStash.new
    mo.foo = "bar"

    mo.foo.should == "bar"
  end

  it "should allow basic Hash methods" do
    mo = MoStash.new
    mo.foo = "bar"
    mo[:baz] = "foo"

    mo[:foo].should == "bar"
    mo.baz.should == "foo"
  end

  it "should be initializable via a Hash" do
    mo = MoStash.new(:foo => "bar")

    mo.foo.should == "bar"
  end

  it "should be initializable via nested Hash" do
    h = {:foo => {:bar => "baz"}, :oh => "hai"}
    mo = MoStash.new h

    mo.foo.bar.should == "baz"
    mo.oh.should == "hai"
  end

  it "should allow values to be arrays" do
    mo = MoStash.new
    mo.foo = ['hello']

    mo.foo.first.should == "hello"
  end

  it "should automatically make a hash a MoStash" do
    mo = MoStash.new
    mo.foo = {:bar => 'baz'}

    mo.foo.bar.should == 'baz'
  end

  it "should automatically make a hash a Mostash if key already exist" do
    mo = MoStash.new( {:foo => {:bar => 'baz' } } )

    mo.foo = { :bar => 'new_baz' }
    mo.foo.bar.should == 'new_baz'
  end

  it "should correctly handle an array of hashes" do
    mo = MoStash.new
    mo.foo = [{:hey => 'you'}, {:oh => 'hai'}]

    mo.foo[1].oh.should == 'hai'
  end

  it "should create method when new method called" do
    mo = Mostash.new
    mo.foo = "bar"

    mo.methods.should include(:foo)
  end

end
