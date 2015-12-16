module ApplicationHelper

  def make_url(addr)
    if addr.starts_with?("http")
      addr
    else
      addr = "http://" + addr
    end
  end

  def display_datetime(date)
    date.strftime("%m/%d/%Y %l:%M%P %Z")
  end
end
