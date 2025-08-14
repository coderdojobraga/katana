# 🚀 Getting Started

These instructions will get you a copy of the project up and running on your
local machine for development and testing purposes.

## 📥 Prerequisites

The following software is required to be installed on your system:

- [Erlang 27+](https://www.erlang.org/downloads)
- [Elixir 1.18+](https://elixir-lang.org/install.html)
- [Node.js 22.13.1](https://nodejs.org/en/download/) (LTS version)

We recommend using [asdf](https://asdf-vm.com/) to install and manage all
the programming languages' requirements. Alternatives like [mise](https://mise.jdx.dev/) will suffice as well.

Moreover, a PostgreSQL database is required to run this project. You can
install it from your package manager or use a Docker container. For the latter, check the [section](#-docker) below.

## 🔧 Setup

First, clone the repository:

```
git clone git@github.com:coderdojobraga/katana.git
cd katana
```
> [!NOTE]
> The following script makes sure you have all the required dependencies installed, compiles the project, and sets up the database. That being said, it is required the database is up and running before executing it.

```
bin/setup
```

Then you should change the `.env` file as needed. You might have to run this script again. For environment loading we recommend using [direnv](https://direnv.net/), which you can activate by simply running `direnv allow .` in the root of the project.

## 🔨 Development

| Command | Action |
| ------- | ------ |
| `mix phx.server` | Starts the server at `http://localhsot:4000` |
| `mix format.all` | Formats the code using the project's formatter |
| `mix test` | Runs the tests |

Check the [mix.exs](mix.exs) file `aliases` section for more commands.

## 🐳 Docker

If you want to setup the required database using docker containers you can
easily do it with [docker-compose](https://docs.docker.com/compose/install/).

Create and start the database containers. You should use `linux.yml` if running on Linux and `darwin.yml` if running on macOS.

```
cp .env .env.dev
docker-compose -f docker-compose.dev.yml -f {linux,darwin}.yml up db
```

Start the previously created containers.

```
docker-compose -f docker-compose.dev.yml -f {linux,darwin}.yml start
```

Stop the containers.

```
docker-compose -f docker-compose.dev.yml -f {linux,darwin}.yml stop
```

Destroy the containers and volumes created.

> [!WARNING]
> This is a destructive operation and will remove all data in the database.

```
docker-compose -f docker-compose.dev.yml -f {linux,darwin}.yml down -v
```

## 🔗 References

You can use these resources to learn more about the technologies this project
uses.

- [Getting Started with Elixir](https://elixir-lang.org/getting-started/introduction.html)
- [Phoenix LiveView Documentation](https://hexdocs.pm/phoenix_live_view)
- [Phoenix LiveVue Documentation](https://hexdocs.pm/phoenix_live_vue)
- [Vue.js Documentation](https://vuejs.org/guide/introduction.html)
- [Ecto Documentation](https://hexdocs.pm/ecto)
