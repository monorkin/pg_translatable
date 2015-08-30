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

class Post < ActiveRecord::Base
  translate :title, :content, :price
end
