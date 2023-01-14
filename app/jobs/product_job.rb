class ProductJob < ApplicationJob
  queue_as :default

  def perform(product)
    # Do something later
    product.delete
    puts "--> Product #{product.name} deleted"
  end
end
