require "spec_helper"

describe "Reserve a username" do
  
  reserve_url = "http://0.0.0.0:3000"
  
  it "presents a title and a form" do
    #capybara
    visit reserve_url
    #rspec  to or not_to
    expect(page).to have_text("Reserve your username")
    expect(page).to have_text("Youhou.co/")           
  end
  
  it "stores username into database if not exists" do
    #capybara
    #visit reserve_url
  end
  
  it "alerts user if username exists" do
    User.create(username: "orlando",email: "lizongshenglzs@gmail.com")
    #capybara
    visit reserve_url
  end
end