require "rspec"

# when I run test for this file only it fails for some reason but works for all tests

describe "routings" do
  it "routes to signup form" do
    expect(:get => '/signup').to route_to(
      :controller =>'users',
      :action => 'new'
    )
  end
  it "routes to create user action" do
    expect(:post =>'/signup').to route_to(
      :controller => 'users',
      :action => 'create'
    )
  end
  it "routes to login" do
    expect(:get => '/login').to route_to(
      :controller => 'sessions',
      :action => 'new'
    )
  end
  it "routes to logout" do
    expect(:get => '/logout').to route_to(
      :controller => 'sessions',
      :action => 'destroy'
    )
  end
  it "does not expose a list of users" do
    expect(:get => '/users').not_to be_routable
  end
end