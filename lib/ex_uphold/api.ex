defmodule ExUphold.Api do
  @type result_t :: {:ok, any} | {:error, Tesla.Env.t()}

  @spec get_card_details(binary()) :: result_t
  def get_card_details(card_id) do
    Tesla.get(client(), "v0/me/cards/#{card_id}")
    |> prepare_response()
  end

  @spec get_transaction_details(binary()) :: result_t
  def get_transaction_details(transaction_id) do
    Tesla.get(
      client(),
      "https://api.uphold.com/v0/reserve/transactions/#{transaction_id}"
    )
    |> prepare_response()
  end

  @spec list_card_transactions(binary()) :: result_t
  def list_card_transactions(card_id) do
    Tesla.get(client(), "v0/me/cards/#{card_id}/transactions")
    |> prepare_response()
  end

  defp client do
    Tesla.client(middlewares())
  end

  defp os_env!(name) do
    case System.get_env(name) do
      nil -> raise "OS ENV #{name} not set!"
      value -> value
    end
  end

  defp middlewares,
    do: [
      {Tesla.Middleware.BaseUrl, base_url(os_env!("UPHOLD_ENV"))},
      {Tesla.Middleware.JSON, []},
      {Tesla.Middleware.Headers,
       [{"Authorization", "Bearer #{os_env!("UPHOLD_ACCESS_TOKEN")}"}]}
    ]

  defp base_url("production"), do: "https://api.uphold.com"
  defp base_url(_), do: "https://api-sandbox.uphold.com"

  defp prepare_response({:ok, %Tesla.Env{status: 200, body: body}}),
    do: {:ok, body}

  defp prepare_response({:ok, response}), do: {:error, response}
  defp prepare_response({:error, _} = error), do: error
end
