defmodule Budget do
  @moduledoc """
  Documentation for Budget.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Budget.hello
      :world

  """
  alias NimbleCSV.RFC4180, as: CSV

  def list_transactions do
    File.read!("lib/transactions.csv")
      |> parse
      |> filter
      |> normalize
  end

  defp parse(string) do
    string
    |> String.replace("\r", "")
    |> CSV.parse_string
  end

  defp filter(rows) do
    Enum.map(rows, &Enum.drop(&1, 1))
  end

  defp normalize(rows) do
    Enum.map(rows, &parse_amount(&1))
  end

  defp parse_amount([date, description, amount]) do
    [date, description, parse_to_float(amount)]
  end

  defp parse_to_float(string) do
    string
    |> String.to_float
  end

end
