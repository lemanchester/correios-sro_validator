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

    context "given a random string" do
      let(:sro) { '31231231231231' }

      it { expect(subject.valid?).to be false }
    end

    context "given a valid SRO with diff suffix" do
      subject { described_class.new(sro, 'CN') }

      let(:sro) { 'LX473124829CN' }

      it { expect(subject.valid?).to be true }
    end

    context "given a random object is used as param" do
      let(:sro) { 12132323 }

      it { expect(subject.valid?).to be false }
    end
  end

  describe "#sro" do
    context "given a valid sro lowercase with tailing spaces" do
      let(:sro) { '  lx473124829bR ' }

      it { expect(subject.sro).to be_eql sro }
    end
  end

  describe "#sanitized_sro" do

    context "given a valid sro lowercase with tailing spaces" do
      let(:sro) { '  lx473124829bR ' }

      it { expect(subject.sanitized_sro).to be_eql 'LX473124829BR' }
    end
  end

end
