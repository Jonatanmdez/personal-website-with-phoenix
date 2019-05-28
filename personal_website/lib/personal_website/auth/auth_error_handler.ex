defmodule PersonalWebsite.Guardian.AuthErrorHandler do
  import PersonalWebsiteWeb.Gettext
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  
  def auth_error(conn, {_type, _reason}, _opts) do
    conn 
    |> put_flash(:error,gettext("You have to be lloged in to enter here."))
    |> redirect(to: "/session/new")
  end
end