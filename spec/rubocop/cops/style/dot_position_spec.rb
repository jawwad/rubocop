# encoding: utf-8

require 'spec_helper'

module Rubocop
  module Cop
    module Style
      describe DotPosition do
        let(:cop) { DotPosition.new }

        context 'Leading dots style' do
          before { DotPosition.config = { 'Style' => 'Leading' } }

          it 'registers an offence for trailing dot in multi-line call' do
            inspect_source(cop, ['something.',
                                 '  method_name'])
            expect(cop.offences.size).to eq(1)
          end

          it 'accepts leading do in multi-line method call' do
            inspect_source(cop, ['something',
                                 '  .method_name'])
            expect(cop.offences).to be_empty
          end

          it 'does not err on method call with no dots' do
            inspect_source(cop, ['puts something'])
            expect(cop.offences).to be_empty
          end
        end

        context 'Trailing dots style' do
          before { DotPosition.config = { 'Style' => 'Trailing' } }

          it 'registers an offence for leading dot in multi-line call' do
            inspect_source(cop, ['something',
                                 '  .method_name'])
            expect(cop.offences.size).to eq(1)
          end

          it 'accepts trailing dot in multi-line method call' do
            inspect_source(cop, ['something.',
                                 '  method_name'])
            expect(cop.offences).to be_empty
          end

          it 'does not err on method call with no dots' do
            inspect_source(cop, ['puts something'])
            expect(cop.offences).to be_empty
          end
        end

        context 'Unknown style' do
          before { DotPosition.config = { 'Style' => 'test' } }

          it 'raises an exception' do
            expect do
              inspect_source(cop, ['something.top'])
            end.to raise_error(RuntimeError)
          end
        end
      end
    end
  end
end
