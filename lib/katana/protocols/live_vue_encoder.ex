defmodule Katana.Protocols.LiveVueEncoder do
  @moduledoc """
  Protocol implementations for LiveVue.Encoder.

  This module contains implementations for third-party structs that we don't own
  but need to encode for LiveVue compatibility.
  """

  defimpl LiveVue.Encoder, for: Ecto.Schema.Metadata do
    def encode(metadata, opts) do
      metadata
      |> Map.take([:state, :source])
      |> LiveVue.Encoder.encode(opts)
    end
  end
end
