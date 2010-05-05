require 'spec_helper'

describe 'MoStash as Hash' do
  it "should support merge when single level" do
    mo = MoStash.new :foo => 'bar', :hello => 'world'
    
    new_mo = mo.merge( :hello => 'tester' )

    new_mo[:foo].should == 'bar'
    new_mo[:hello].should == 'tester'
  end

  it "should support merge of single level when multi leveled" do
    mo = MoStash.new( { :foo => 'bar', :nested => { :hello => 'world' }} )
    
    new_mo = mo.merge( :foo => 'baz' )

    new_mo[:foo].should == 'baz'
    new_mo[:nested][:hello].should == 'world'
  end

  it "should support merge of multi levels when is multi leveled" do
    mo = MoStash.new( { :foo => 'bar', :nested => { :hello => 'world' }} )
    
    new_mo = mo.merge( :nested => { :hello => 'tester' } )

    new_mo[:foo].should == 'bar'
    new_mo[:nested][:hello].should == 'tester'
    new_mo[:nested].class.should == MoStash
  end

  it "should support merge!" do
    mo = MoStash.new( :foo => 'bar' )

    mo.merge!( :foo => 'baz' )
    mo.foo.should == 'baz'
  end

  it "should support multi level merge!" do
    mo = MoStash.new( { :foo => 'bar', :nested => { :hello => 'world' }} )
    
    mo.merge!( :nested => { :hello => 'tester' } )

    mo[:foo].should == 'bar'
    mo[:nested][:hello].should == 'tester'
    mo[:nested].class.should == MoStash
  end

  it "should be able to return a hash for single level" do
    mo = MoStash.new( :foo => 'bar' )

    mo.to_hash.should == { :foo => 'bar' }
  end

  it "should be able to return a hash for multi level" do
    mo = MoStash.new( :foo => 'bar', :nested => { :hello => 'world' } )

    mo.to_hash.should == { :foo => 'bar', :nested => { :hello => 'world' } }
  end
end

