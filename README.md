# Rspec::Parameterized::Context

Generate interfaces like `RSpec::Parameterized` to support parameterized testing that is evaluated in transaction.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec-parameterized-context'
```

Then add this lines to files under `spec/support/`

```ruby
RSpec.configure do |config|
  config.extend RSpecParameterizedContext
end
```

## Usage

### Syntax

Provide interfaces like `RSpec::Parameterized`.

Pass `where` and `with_them` to `parameterized` method as one block and specify parameterized count as `size` keyword argument.

```ruby
describe "Addition" do
  parameterized do
    where(:a, :b, :answer, size: 3) do
      [
        [1 , 2 , 3],
        [5 , 8 , 13],
        [0 , 0 , 0]
      ]
    end

    with_them do
      it do
        expect(a + b).to eq answer
      end
    end
  end
end
```

### Feature

rspec-parameterized-context supports to evaluate block that given where method in transaction.

```ruby
# Assume today is 2020/9/9
describe 'Evaluting block that given to where in transaction' do
  let(:now) { Date.new(2020, 1, 1) }
  # And travel to 2020/1/1
  before { travel_to(now) }

  parameterized do
    where(:current_on, size: 1) do
      [
        [Date.current],
      ]
    end

    with_them do
      it do
        # current_on is evaluated as 2020/1/1
        expect(current_on).to eq now
      end
    end
  end
end
```


## Contributing

- Fork the project.
- Create feature branch.
- Commit and push.
- Make sure to add tests for it.
- Create pull request.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rspec::Parameterized::Context project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/rspec-parameterized-context/blob/master/CODE_OF_CONDUCT.md).
