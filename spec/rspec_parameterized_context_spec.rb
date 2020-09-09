RSpec.describe RspecParameterizedContext do
  describe 'InstanceMethods' do
    describe '#parameterized' do
      extend RSpecParameterizedContext

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
  end
end
