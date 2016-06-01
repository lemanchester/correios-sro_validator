require 'spec_helper'

describe Correios::SROValidator do

  subject { described_class.new(sro) }

  describe "#valid?" do

    context "given a valid sro" do
      let(:sro) { 'LX473124829BR' }

      it { expect(subject.valid?).to be true }
    end

    context "given an invalid sro" do
      let(:sro) { 'LX473124821BR' }

      it { expect(subject.valid?).to be false }
    end

  end

end
