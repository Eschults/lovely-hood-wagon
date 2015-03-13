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
end