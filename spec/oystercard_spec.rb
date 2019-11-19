require 'oystercard'
describe Oystercard do
  
  describe '#balance' do
    it 'should show 0 balance' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    
  context "top up within max capacity" do
    
    it 'should increase the balance by 10' do
      expect{ subject.top_up(10) }.to change{ subject.balance }.by (10)
    end
    it 'should increase the balance by 5 twice' do
      expect{ 2.times{subject.top_up(5)} }.to change{ subject.balance }.by (10)
    end
  end

  context "top up over the max capacity" do
    it 'should raise an error when we pass the max capacity' do
      subject.top_up(90)
      expect{ subject.top_up(10) }.to raise_error("Exceed maximum balance #{Oystercard::DEFAULT_LIMIT}" )
    end
  end
  end

  describe '#deduct' do

    before do 
      subject.top_up(Oystercard::DEFAULT_LIMIT)
    end

    it 'should deduct given quantitiy from balance' do
      expect { subject.deduct(Oystercard::DEFAULT_LIMIT*0.9) }.to change { subject.balance }.by (-Oystercard::DEFAULT_LIMIT*0.9)
    end

    it 'should raise error when the balance goes negative' do
      expect { subject.deduct(Oystercard::DEFAULT_LIMIT*1.1) }.to raise_error("Insufficient funds")
    end
  end

  context "using the card" do 

    describe "#touch_in" do 
      it "should be in journey after touching in" do
        subject.touch_in
        expect( subject.in_journey?).to eq(true)
      end
    end

    describe "#touch_out" do 
      it "should not be in a journey after touching out" do
        subject.touch_in
        subject.touch_out
        expect( subject.in_journey? ).to eq(false)
      end
    end

    describe "#in_journey?" do 
      it "should true after touching in" do
        subject.touch_in
        expect(subject).to be_in_journey
      end
    end



  end
    






end