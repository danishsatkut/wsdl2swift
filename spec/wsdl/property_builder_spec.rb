module WSDL
  RSpec.describe PropertyBuilder do
    subject(:builder) { described_class.new(node) }

    describe '#build' do
      subject { builder.build }

      context 'with element node' do
        let(:content) { '<element name="SourceID" nillable="true" type="xsd:string"/>' }
        let(:node) { Nokogiri::XML(content).children.first }

        it 'creates Property with correct name' do
          expect(subject.name).to eq('SourceID')
        end

        it 'creates Property with correct type' do
          expect(subject.type).to eq('string')
          expect(subject.tokenized_type).to eq('String')
        end
      end

      context 'without element node' do
        let(:node) { Nokogiri::XML('<type></type>') }

        it 'raises ArgumentError' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end
    end
  end
end
