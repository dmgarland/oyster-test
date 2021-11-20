require 'rspec'
require './lib/journey'
require './lib/station'

RSpec.describe Journey do
  subject { Journey.new }

  describe "#tap_in" do
    let(:start_zone) { 1 }

    before do
      subject.tap_in(zone: start_zone)
    end

    it "charges the maximum fare" do
      expect(subject.transactions.length).to eq(1)
      expect(subject.transactions.first.value).to eq(Journey::MAX_FARE)
    end
  end

  describe "#tap_out" do
    before do
      journey.each_with_index do |zone, i|
        if i.even?
          subject.tap_in(zone: zone)
        else
          subject.tap_out(zone: zone)
        end
      end
    end

    context "starting in zone 1" do
      context "and leaving in zone 1" do
        let(:journey) { [1, 1] }

        it "charges the correct fare" do
          expect(subject.transactions.length).to eq(1)
          expect(subject.transactions.first.value).to eq(250)
        end
      end

      context "and leaving in zone 2" do
        let(:journey) { [1, 2] }

        it "charges the correct fare" do
          expect(subject.transactions.length).to eq(1)
          expect(subject.transactions.first.value).to eq(300)
        end
      end

      context "and leaving in zone 3" do
        let(:journey) { [1, 3] }

        it "charges the correct fare" do
          expect(subject.transactions.length).to eq(1)
          expect(subject.transactions.first.value).to eq(300)
        end
      end
    end

    context "starting in zone 2" do
      context "and leaving in zone 1" do
        let(:journey) { [2, 1] }

        it "charges the correct fare" do
          expect(subject.transactions.length).to eq(1)
          expect(subject.transactions.first.value).to eq(300)
        end
      end

      context "and leaving in zone 2" do
        let(:journey) { [2, 2] }

        it "charges the correct fare" do
          expect(subject.transactions.length).to eq(1)
          expect(subject.transactions.first.value).to eq(200)
        end
      end

      context "and leaving in zone 3" do
        let(:journey) { [2, 3] }

        it "charges the correct fare" do
          expect(subject.transactions.length).to eq(1)
          expect(subject.transactions.first.value).to eq(225)
        end
      end
    end

    context "starting in zone 3" do
      context "and leaving in zone 1" do
        let(:journey) { [3, 1] }

        it "charges the correct fare" do
          expect(subject.transactions.length).to eq(1)
          expect(subject.transactions.first.value).to eq(300)
        end
      end

      context "and leaving in zone 2" do
        let(:journey) { [3, 2] }

        it "charges the correct fare" do
          expect(subject.transactions.length).to eq(1)
          expect(subject.transactions.first.value).to eq(225)
        end
      end

      context "and leaving in zone 3" do
        let(:journey) { [3, 3] }

        it "charges the correct fare" do
          expect(subject.transactions.length).to eq(1)
          expect(subject.transactions.first.value).to eq(200)
        end
      end
    end

    context "having made a journey in zone 1" do
      context "and leaving in zone 1" do
        let(:journey) { [1, 1, 1, 1] }

        it "charges the correct fare" do
          expect(subject.transactions.length).to eq(2)
          expect(subject.transactions.sum(&:value)).to eq(500)
        end
      end

      context "and leaving in zone 2" do
        let(:journey) { [1, 1, 1, 2] }

        it "charges the correct fare" do
          expect(subject.transactions.length).to eq(2)
          expect(subject.transactions.sum(&:value)).to eq(550)
        end
      end

      context "and leaving in zone 3" do
        let(:journey) { [1, 1, 1, 3] }

        it "charges the correct fare" do
          expect(subject.transactions.length).to eq(2)
          expect(subject.transactions.sum(&:value)).to eq(550)
        end
      end
    end

    context "having made a journey in zone 2" do
      context "and leaving in zone 1" do
        let(:journey) { [2, 2, 2, 1] }

        it "charges the correct fare" do
          expect(subject.transactions.length).to eq(2)
          expect(subject.transactions.sum(&:value)).to eq(500)
        end
      end

      context "and leaving in zone 2" do
        let(:journey) { [2, 2, 2, 2] }

        it "charges the correct fare" do
          expect(subject.transactions.length).to eq(2)
          expect(subject.transactions.sum(&:value)).to eq(400)
        end
      end

      context "and leaving in zone 3" do
        let(:journey) { [2, 2, 2, 3] }

        it "charges the correct fare" do
          expect(subject.transactions.length).to eq(2)
          expect(subject.transactions.sum(&:value)).to eq(425)
        end
      end
    end

    context "having made a journey in zone 3" do
      context "and leaving in zone 1" do
        let(:journey) { [3, 3, 3, 1] }

        it "charges the correct fare" do
          expect(subject.transactions.length).to eq(2)
          expect(subject.transactions.sum(&:value)).to eq(500)
        end
      end

      context "and leaving in zone 2" do
        let(:journey) { [3, 3, 3, 2] }

        it "charges the correct fare" do
          expect(subject.transactions.length).to eq(2)
          expect(subject.transactions.sum(&:value)).to eq(425)
        end
      end

      context "and leaving in zone 3" do
        let(:journey) { [3, 3, 3, 3] }

        it "charges the correct fare" do
          expect(subject.transactions.length).to eq(2)
          expect(subject.transactions.sum(&:value)).to eq(400)
        end
      end
    end

    context "having travelled between zone 1 and 2" do
      context "and leaving in zone 1" do
        let(:journey) { [1, 2, 2, 1] }

        it "charges the correct fare" do
          expect(subject.transactions.length).to eq(2)
          expect(subject.transactions.sum(&:value)).to eq(600)
        end
      end

      context "and leaving in zone 2" do
        let(:journey) { [1, 2, 2, 2] }

        it "charges the correct fare" do
          expect(subject.transactions.length).to eq(2)
          expect(subject.transactions.sum(&:value)).to eq(500)
        end
      end

      context "and leaving in zone 3" do
        let(:journey) { [1, 2, 2, 3] }

        it "charges the correct fare" do
          expect(subject.transactions.length).to eq(2)
          expect(subject.transactions.sum(&:value)).to eq(525)
        end
      end
    end
  end
end
