step "there are the following products:" do |table|
  @products = table.hashes.each_with_object({}) do |product_values, products_hash|
    product = Checkout::Product.new(product_values)
    products_hash[product.code] = product
  end
end
