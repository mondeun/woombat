# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :woombat,
  ecto_repos: [Woombat.Repo]

# Configures the endpoint
config :woombat, WoombatWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "K1YQapIfnCnYmvRLMPmDhIkVIz3l9YufTqi/kbUoe5fzAmeANUpIDN2GSMm7bASS",
  render_errors: [view: WoombatWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Woombat.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Woombat.Coherence.User,
  repo: Woombat.Repo,
  module: Woombat,
  web_module: WoombatWeb,
  router: WoombatWeb.Router,
  messages_backend: WoombatWeb.Coherence.Messages,
  logged_out_url: "/",
  email_from_name: "Your Name",
  email_from_email: "yourname@example.com",
  opts: [:authenticatable, :recoverable, :lockable, :trackable, :unlockable_with_token, :invitable, :registerable]

config :coherence, WoombatWeb.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "your api key here"
# %% End Coherence Configuration %%

config :extwitter, :oauth, [
  consumer_key: "WhU3glrOCmfr5ymK6b6zdiNXo",
  consumer_secret: "6jrhGNIjT4qVCMz0BmcUVIAKNyo7uKRUEzOA8iHS73lV3qs0ix",
  access_token: "2372099119-AtqYGahkA5pA4Ep9CmzDMlZVVgPY3rCArHhYdLV",
  access_token_secret: "5kVCiagFhsw31ewOpAsBNJbo5bJwVjVrBT67igg6FgotN"
]
