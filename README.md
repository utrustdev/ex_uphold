# ExUphold

Elixir client for Uphold API

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_uphold` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_uphold, "~> 0.0.2"}
  ]
end
```

### Environment variables

- **UPHOLD_ACCESS_TOKEN**: Uphold API token (obtained in Uphold settings)
- **UPHOLD_ENV**: Uphold API environment (production, sandbox) 

## Tests
- For tests you can use [ExUphold.FakeApi](lib/ex_uphold/fake_api.ex)

## TODO: 

- [ ] Add support for more API requests (cards, transactions, etc.)

- [ ] Add Github Actions tests

- [ ] Complete README