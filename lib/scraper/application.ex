defmodule Scraper.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: ProducerConsumerRegistry},
      PageProducer,
      Supervisor.child_spec({OnlinePageProducerConsumer, 1}, id: 1),
      Supervisor.child_spec({OnlinePageProducerConsumer, 2}, id: 2),
      PageConsumerSupervisor
    ]

    opts = [strategy: :one_for_one, name: Scraper.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
