require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  def new_product(image_url)
    Product.new(title: 'My Book Title',
                description: 'yyy',
                price: 1,
                image_url: image_url)
  end

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test 'product price must be positive' do
    product = new_product('a.jpg')
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif.more fred.gife }

    ok.each do |url|
      assert new_product(url).valid?, "#{url} should be valid"
    end

    bad.each do |url|
      assert new_product(url).invalid?, "#{url} shouldn't be valid"
    end
  end

  test "product titles must be unique" do
    # product1 = new_product('abc.gif')
    # product1.valid?

    # product2 = new_product('abc.gif')
    # assert product2.invalid?
  end

end
