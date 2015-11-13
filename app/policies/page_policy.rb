class PagePolicy < Struct.new(:user, :page)
  def home?
    true
  end

  def legal?
    true
  end

  def terms?
    true
  end

  def poster?
    user.admin?
  end

  def early_birds_poster?
    true
  end

  def sitemap?
    true
  end

  def raclette?
    true
  end
end