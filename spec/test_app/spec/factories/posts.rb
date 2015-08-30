# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :hstore
#  content    :json
#  price      :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :post do
    title(
      'en' => 'title_en', 'de' => 'title_de', 'fr' => 'title_fr',
      'es' => 'title_es'
    )
    content(
      'hr' => 'content_en', 'en' => 'content_en', 'de' => 'content_en',
      'es' => 'content_es'
    )
    price(
      'hr' => 'price_en', 'en' => 'price_en', 'de' => 'price_en',
      'es' => 'price_es'
    )
  end
end
