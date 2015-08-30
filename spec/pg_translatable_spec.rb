require 'rails_helper'

describe PgTranslatable do
  it 'has a version number' do
    expect(PgTranslatable::Version::STRING).not_to be nil
  end

  it 'includes it self in ActiveRecord::Base' do
    expect(ActiveRecord::Base.singleton_methods).to include(:translate)
  end
end
