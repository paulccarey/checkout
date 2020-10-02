# frozen_string_literal: true

step 'there are the following products:' do |table|
  @products = table.hashes.each_with_object({}) do |product_values, products_hash|
    product = Checkout::Product.new(product_values)
    products_hash[product.code] = product
  end
end

step 'there is a promotion giving :percent% off when you spend over £:amount' do |percent, amount|
  fractional = (100 - percent.to_f) / 100
  percent_discount_proc = proc { |total| total - (total * fractional) }
  @promotions ||= []
  @promotions <<
    Checkout::Promotions::ThresholdDiscountPromotion.new(
      discount_threshold: Monetize.parse("£#{amount}"),
      discounting_proc: percent_discount_proc,
      description: "%#{percent} off when you spend over £#{amount}"
    )
end

step 'there is a promotion reducing the price of ":product_name" / :product_code down when buying '\
      ':quantity_threshold or more to :amount' do |product_name, product_code, quantity_threshold, discounted_price|
  @promotions ||= []
  @promotions <<
    Checkout::Promotions::ProductDiscountPromotion.new(
      product_code: product_code,
      discounted_price: Monetize.parse(discounted_price),
      quantity_threshold: quantity_threshold.to_i,
      description: "#{product_name} discount to #{discounted_price} when buying #{quantity_threshold} or more"
    )
end
