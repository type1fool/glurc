defmodule Glurc.Dexcom do
  use OAuth2.Strategy

  defp get_site(:dev), do: "https://sandbox-api.dexcom.com"
  defp get_site(:test), do: "https://sandbox-api.dexcom.com"
  defp get_site(_), do: "https://api.dexcom.com"

  def new do
    OAuth2.Client.new(
      strategy: __MODULE__,
      client_id: System.get_env("DEXCOM_CLIENT_ID"),
      client_secret: System.get_env("DEXCOM_CLIENT_SECRET"),
      site: get_site(Mix.env()),
      authorize_url: "/v2/oauth2/login",
      token_url: "/v2/oauth2/token",
      redirect_uri: "http://localhost/auth/callback",
      params: %{
        "grant_type" => "authorization_code",
        "state" => System.get_env("SECRET_KEY_BASE")
      }
    )
  end

  def authorize_url!(params \\ []) do
    new()
    |> put_header("scope", "offline_access")
    |> put_header("response_type", "code")
    |> OAuth2.Client.authorize_url!(params)
  end

  def get_token!(params \\ [], headers \\ []) do
    new()
    |> put_header("Content-Type", "application/x-www-form-urlencoded")
    |> put_header("cache-control", "no-cache")
    |> put_param("client_secret", System.get_env("DEXCOM_CLIENT_SECRET"))
    |> OAuth2.Client.get_token!(params, headers)
  end

  def authorize_url(client, params) do
    OAuth2.Strategy.AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_header("Accept", "application/json")
    |> OAuth2.Strategy.AuthCode.get_token(params, headers)
  end
end
