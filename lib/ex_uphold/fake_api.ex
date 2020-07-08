defmodule ExUphold.FakeApi do
  @fake_card %{
    "address" => %{
      "bitcoin" => "msbLNpBxiyyfFfPPnRAbnoNqFD9qNLSzmn",
      "wire" => "UH263F859C"
    },
    "available" => "0.00",
    "balance" => "0.00",
    "currency" => "EUR",
    "id" => "12121ed6-4d1f-4fce-good-302a303bd234",
    "label" => "uphold_api_unit_test_btc_address",
    "lastTransactionAt" => nil,
    "normalized" => [
      %{"available" => "0.00", "balance" => "0.00", "currency" => "CHF"}
    ],
    "settings" => %{"position" => 13, "protected" => false, "starred" => false},
    "wire" => [
      %{
        "accountName" => "Uphold Europe Limited",
        "address" => %{
          "line1" => "Tartu mnt 2",
          "line2" => "100000 Tallinn, Estonia"
        },
        "bic" => "ABCBEE22",
        "currency" => "EUR",
        "iban" => "BB12 7722 7711 0170 0110",
        "name" => "AS LHV Pank"
      },
      %{
        "accountName" => "Uphold HQ, Inc.",
        "accountNumber" => "0333224341",
        "address" => %{
          "line1" => "9959 Broadway",
          "line2" => "New York, NY 10012"
        },
        "bic" => "ABCDUS33",
        "currency" => "USD",
        "name" => "Metropolitan Bank",
        "routingNumber" => "026013312"
      }
    ]
  }
  @fake_transaction %{
    "application" => nil,
    "createdAt" => "2020-06-04T12:17:33.894Z",
    "denomination" => %{"amount" => "0.000066", "currency" => "ETH"},
    "destination" => %{
      "amount" => "0.000066",
      "base" => "0.000066",
      "commission" => "0.00",
      "currency" => "ETH",
      "fee" => "0.00",
      "rate" => "1.00"
    },
    "fees" => [],
    "id" => "8feaa2c0-4897-4df6-9177-2f6bcfbfa23c",
    "origin" => %{
      "amount" => "0.000066",
      "base" => "0.000066",
      "commission" => "0.00",
      "currency" => "ETH",
      "fee" => "0.00",
      "rate" => "1.00",
      "sources" => []
    },
    "params" => %{
      "currency" => "ETH",
      "margin" => "0.00",
      "pair" => "ETHETH",
      "rate" => "1.00",
      "txid" => "0x0cc8xe6b04ee56d010d09e91c0b5439ffb45f327196f4fe6ffaf2e29cd357a8d"
    },
    "priority" => "normal",
    "status" => "completed",
    "type" => "deposit"
  }
  @type result_t :: {:ok, any} | {:error, Tesla.Env.t()}

  @spec get_card_details(binary()) :: result_t
  def get_card_details(card_id) do
    {:ok, @fake_card}
  end

  @spec get_transaction_details(binary()) :: result_t
  def get_transaction_details(transaction_id) do
    {:ok, @fake_transaction}
  end

  @spec list_card_transactions(binary()) :: result_t
  def list_card_transactions(card_id) do
    {:ok, [@fake_transaction]}
  end
end
