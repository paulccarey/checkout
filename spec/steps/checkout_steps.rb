# frozen_string_literal: true

step 'there are the following products:' do |table|
  @products = table.hashes.each_with_object({}) do |product_values, products_hash|
    product = Checkout::Product.new(product_values)
    products_hash[product.code] = product
  end
end

step 'there is a promotion giving :percent% off when you spend over :amount' do |percent, amount|
  percent_discount_proc = proc { |total| total - (total * ((1 * 100) - percent.to_i) / 100) }
  @promotions ||= []
  @promotions <<
    Checkout::Promotions::ThresholdDiscountPromotion.new(
      discount_threshold: Monetize.parse(amount),
      discount_proc: percent_discount_proc,
      description: "%#{percent} off when you spend over #{amount}"
    )
end
