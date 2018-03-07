module ApplicationHelper
  def size_array
    Product.all.map {|p| p.size }.uniq
  end

  def new_arrivals
    Product.last(8)
  end
end
