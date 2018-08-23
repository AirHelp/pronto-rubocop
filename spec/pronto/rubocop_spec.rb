require 'spec_helper'

module Pronto
  describe Rubocop do
    let(:rubocop) { Rubocop.new(patches) }
    let(:patches) { nil }

    describe '#run' do
      subject { rubocop.run }

      context 'patches are nil' do
        it { should == [] }
      end

      context 'no patches' do
        let(:patches) { [] }
        it { should == [] }
      end
    end

    describe '#level' do
      subject { rubocop.level(severity) }

      ::RuboCop::Cop::Severity::NAMES.each do |severity|
        let(:severity) { severity }
        context "severity '#{severity}' conversion to Pronto level" do
          it { should_not be_nil }
        end
      end

      context 'when severity is customized' do
        let(:rubocop_customization) { {} }
        let(:severity) { :warning }

        before { rubocop.instance_variable_set(:@runner_config, rubocop_customization) }

        context 'when not specified' do
          it { should eq :warning }
        end

        context 'when overriden' do
          let(:rubocop_customization) { { 'severities' => { 'warning' => 'info' } } }

          it { should eq :info }
        end
      end
    end
  end
end
