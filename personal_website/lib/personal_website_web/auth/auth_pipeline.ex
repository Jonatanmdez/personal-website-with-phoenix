defmodule PersonalWebsiteWeb.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline,
   otp_app: :personal_website,
   module: PersonalWebsite.Guardian,
   error_handle: PersonalWebsite.Guardian.AuthErrorHandler

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, allow_blank: true
end