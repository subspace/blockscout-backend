<<<<<<<< HEAD:apps/explorer/lib/explorer/chain/polygon_zkevm/batch_transaction.ex
defmodule Explorer.Chain.PolygonZkevm.BatchTransaction do
  @moduledoc "Models a list of transactions related to a batch for zkEVM."
========
defmodule Explorer.Chain.ZkSync.BatchTransaction do
  @moduledoc "Models a list of transactions related to a batch for ZkSync."
>>>>>>>> master:apps/explorer/lib/explorer/chain/zksync/batch_transaction.ex

  use Explorer.Schema

  alias Explorer.Chain.{Hash, Transaction}
<<<<<<<< HEAD:apps/explorer/lib/explorer/chain/polygon_zkevm/batch_transaction.ex
  alias Explorer.Chain.PolygonZkevm.TransactionBatch
========
  alias Explorer.Chain.ZkSync.TransactionBatch
>>>>>>>> master:apps/explorer/lib/explorer/chain/zksync/batch_transaction.ex

  @required_attrs ~w(batch_number hash)a

  @primary_key false
<<<<<<<< HEAD:apps/explorer/lib/explorer/chain/polygon_zkevm/batch_transaction.ex
  typed_schema "polygon_zkevm_batch_l2_transactions" do
    belongs_to(:batch, TransactionBatch, foreign_key: :batch_number, references: :number, type: :integer, null: false)
========
  schema "zksync_batch_l2_transactions" do
    belongs_to(:batch, TransactionBatch, foreign_key: :batch_number, references: :number, type: :integer)
    belongs_to(:l2_transaction, Transaction, foreign_key: :hash, primary_key: true, references: :hash, type: Hash.Full)
>>>>>>>> master:apps/explorer/lib/explorer/chain/zksync/batch_transaction.ex

    belongs_to(:l2_transaction, Transaction,
      foreign_key: :hash,
      primary_key: true,
      references: :hash,
      type: Hash.Full,
      null: false
    )

    timestamps(null: false)
  end

  @doc """
    Validates that the `attrs` are valid.
  """
  @spec changeset(Ecto.Schema.t(), map()) :: Ecto.Schema.t()
  def changeset(%__MODULE__{} = transactions, attrs \\ %{}) do
    transactions
    |> cast(attrs, @required_attrs)
    |> validate_required(@required_attrs)
    |> foreign_key_constraint(:batch_number)
    |> unique_constraint(:hash)
  end
end
