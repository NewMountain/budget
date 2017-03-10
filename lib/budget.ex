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
  end

  defp parse(string) do
    CSV.parse_string(string)
  end

  defp filter(rows) do
    Enum.map(rows, &Enum.drop(&1, 1))
  end

end
