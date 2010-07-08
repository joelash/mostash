require 'spec_helper'

describe 'MoStash as Hash' do

  context 'to_hash' do
    it "should be able to return a hash for single level" do
      mo = MoStash.new( :foo => 'bar' )

      mo.to_hash.should == { :foo => 'bar' }
    end

    it "should be able to return a hash for multi level" do
      mo = MoStash.new( :foo => 'bar', :nested => { :hello => 'world' } )

      mo.to_hash.should == { :foo => 'bar', :nested => { :hello => 'world' } }
    end
  end

  context 'hash functions' do

    it "should respond to empty?" do
      mo = Mostash.new
      mo.empty?.should == true
    end

    it "should be able to delete a key/value" do
      mo = Mostash.new :a => 100, :b => 200

      mo.delete :a
      mo.size.should == 1
      mo[:a].should be_nil
    end

    it "should be clearable" do
      mo = Mostash.new :a => 100, :b => 200

      mo.clear
      mo.size.should == 0
    end

    it "should be able to iterable via each_pair" do
      mo = Mostash.new :a => 100, :b => 200
      vals = []
      mo.each_pair { |key, value| vals << "#{key} = #{value}" }

      vals.size.should == 2
      vals[0].should == "a = 100"
      vals[1].should == "b = 200"
    end

    it "should be able to iterable via each_value" do
      mo = Mostash.new :a => 100, :b => 200
      vals = []
      mo.each_value { |value| vals << value }

      vals.size.should == 2
      vals[0].should == 100
      vals[1].should == 200
    end

    it "should be iterable via each_key" do
      mo = Mostash.new :a => 100, :b => 200
      vals = []
      mo.each_key { |key| vals << key }

      vals.size.should == 2
      vals[0].should == :a
      vals[1].should == :b
    end

    context 'merge' do
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
    end

  end

end
