require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module GameOfLife
  describe Organism do
    let(:static) do
      %q{
         X
        X X
         X
      }
    end

    let(:oscillator) do
      %q{
        XXX
      }
    end

    let(:dot) do
      Organism.new({[1, 1] => true})
    end

    let(:square) do
      Organism.new({
        [1, 1] => true, [1, 2] => true, [1, 3] => true,
        [2, 1] => true, [2, 2] => true, [2, 3] => true,
        [3, 1] => true, [3, 2] => true, [3, 3] => true
      })
    end

    describe "#center" do
      it "should return the row/col coordinates of the center of the organism" do
        dot.center.should == [1, 1]
      end

      it "should return the center of a more complicated organism" do
        square.center.should == [2, 2]
      end
    end

    describe "#min_row" do
      it 'should return the lowest-valued row in the organism' do
        square.min_row.should == 1
      end
    end

    describe "#max_row" do
      it 'should return the highest-valued row in the organism' do
        square.max_row.should == 3
      end
    end

    describe "#min_col" do
      it 'should return the lowest-valued col in the organism' do
        square.min_col.should == 1
      end
    end

    describe "#max_col" do
      it 'should return the highest-valued col in the organism' do
        square.max_col.should == 3
      end
    end

    describe "#step" do
      it 'should oscillate when given an oscillator' do
        oscillator_organism = Organism.from_string(oscillator)
        oscillator_organism.step
        oscillator_organism.raw.keys.should == [
          [-1, 0],
          [0, 0],
          [1, 0]
        ]
      end

      it 'should remain static when given a static organism' do
        static_organism = Organism.from_string(static)
        static_organism.step
        static_organism.raw.keys.should == Organism.from_string(static).raw.keys
      end

      it 'should glide given a glider' do
        glider = Organism.from_string(%{
          X X
           XX
           X
        })
        glider.step.step.step.step
        glider.center.should == [1, 1]
      end
    end

    describe "::from_string" do
      it "should correctly initialize itself from a String" do
        oscillator_organism = Organism.from_string(oscillator)
        oscillator_organism.should_not be_nil
        oscillator_organism.raw.keys.sort.should == [
          [0, -1], [0, 0], [0, 1]
        ]
      end
    end

  end
end
