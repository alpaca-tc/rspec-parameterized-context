RSpec.describe RspecParameterizedContext do
  describe 'InstanceMethods' do
    describe '#parameterized' do
      extend RSpecParameterizedContext

      context 'basic' do
        parameterized do
          where(:a, :b, :expected, size: 1) do
            [
              [1, 2, 3]
            ]
          end

          with_them do
            it { expect(a + b).to eq(expected) }
          end
        end
      end

      context 'subject/let/context' do
        parameterized do
          subject do
            expected
          end

          let(:a) do
            'a'
          end

          where(:expected, size: 1) do
            [
              [a]
            ]
          end

          with_them do
            it { expect(expected).to eq(expected) }

            context 'with context' do
              let(:a) do
                'b'
              end

              it { is_expected.to eq(a) }
            end
          end
        end
      end
    end
  end
end
