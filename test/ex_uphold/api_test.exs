defmodule ExUphold.ApiTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "get_card_details/1" do
    test "gets details of an existing card" do
      use_cassette "get_card_details" do
        {:ok, card} = ExUphold.Api.get_card_details("12121ed6-4d1f-4fce-good-302a303bd234")

        assert %{"id" => _, "currency" => "EUR", "address" => %{}} = card
      end
    end

    test "fails to get details for non-existing cards" do
      use_cassette "get_invalid_card_details" do
        assert {:error, _} = ExUphold.Api.get_card_details("30298ed6")
      end
    end
  end

  describe "get_transaction_details/1" do
    test "gets details of an existing uphold transaction" do
      use_cassette "get_transaction_details" do
        {:ok, transaction} =
          ExUphold.Api.get_transaction_details("d5987c3d-ed88-4de0-b0c5-a31e67db3759")

        assert %{
                 "denomination" => %{
                   "amount" => "0.000066",
                   "currency" => "ETH"
                 },
                 "id" => "8feaa2c0-4897-4df6-9177-2f6bcfbfa23c",
                 "params" => %{
                   "currency" => "ETH",
                   "margin" => "0.00",
                   "pair" => "ETHETH",
                   "rate" => "1.00",
                   "txid" => "0x0cc8xe6b04ee56d010d09e91c0b5439ffb45f327196f4fe6ffaf2e29cd357a8d"
                 },
                 "status" => "completed",
                 "type" => "deposit",
                 "destination" => %{
                   "currency" => "ETH"
                 },
                 "origin" => %{
                   "currency" => "ETH"
                 }
               } = transaction
      end
    end

    test "fails to get details for non-existing transactions" do
      use_cassette "get_invalid_transaction_details" do
        assert {:error, _} = ExUphold.Api.get_transaction_details("30298ed6")
      end
    end
  end

  describe "list_card_transactions/1" do
    test "gets list of transactions for a given card" do
      use_cassette "get_eth_card_transactions" do
        {:ok, txs} = ExUphold.Api.list_card_transactions("d1cc6aad-9c96-4cc0-b5d0-313b9fffffff")

        tx =
          Enum.find(txs, fn
            %{
              "params" => %{
                "txid" => "0xd594a1ff5326dc34ace1950b768317bb70b64d518a306b6b4a22b66a430d015f"
              }
            } ->
              true

            _ ->
              false
          end)

        assert %{
                 "denomination" => %{"pair" => "ETHETH"},
                 "destination" => %{"amount" => "142.77"},
                 "params" => %{
                   "txid" => "0xd594a1ff5326dc34ace1950b768317bb70b64d518a306b6b4a22b66a430d015f"
                 }
               } = tx
      end
    end

    test "fails for invalid card IDs" do
      use_cassette "get_invalid_card_transactions" do
        assert {:error, _} = ExUphold.Api.list_card_transactions("invalid")
      end
    end
  end
end
