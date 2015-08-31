require 'rails_helper'

RSpec.describe PgTranslatable, type: :model do
  it 'has a version number' do
    expect(PgTranslatable::Version::STRING).not_to be nil
  end

  it 'includes it self in ActiveRecord::Base' do
    expect(ActiveRecord::Base.singleton_methods).to include(:translate)
  end

  context 'when attached to model' do
    let!(:post) { build(:post) }

    describe '#translate' do
      it 'attaches class methods to model' do
        expect(Post.singleton_methods).to(
          include(
            :title_fields, :content_fields, :price_fields
          )
        )
      end

      # For some reason this rases a false negative if any formatter gets
      # overridden
      #
      # it 'attaches instance methods to model' do
      #   expect(post.methods).to(
      #     include(
      #       :title_en, :title_de, :title_fr, :title_es,
      #       :title_en=, :title_de=, :title_fr=, :title_es=,
      #       :title_formatter,
      #
      #       :content_en, :content_de, :content_fr, :content_es,
      #       :content_en=, :content_de=, :content_fr=, :content_es=,
      #       :content_formatter,
      #
      #       :price_en, :price_de, :price_fr, :price_es,
      #       :price_en=, :price_de=, :price_fr=, :price_es=,
      #       :price_formatter,
      #
      #       :title, :titles, :titles=,
      #       :content, :contents, :contents=,
      #       :price, :prices, :prices=
      #     )
      #   )
      # end
    end

    describe '#title_en' do
      it 'returns the english translation' do
        expect(post.title_en).to eq('title_en')
      end
    end

    describe '#title_de' do
      it 'returns the german translation' do
        expect(post.title_de).to eq('title_de')
      end
    end

    describe '#title_fr' do
      it 'returns the french translation' do
        expect(post.title_fr).to eq('title_fr')
      end
    end

    describe '#title_es' do
      it 'returns the spanish translation' do
        expect(post.title_es).to eq('title_es')
      end
    end

    describe '#title_en=' do
      it 'sets the english translation' do
        post.title_en = 'test'
        expect(post.title_en).to eq('test')
      end

      it 'saves translations' do
        post.title_en = 'test'
        post.save
        post.reload

        expect(post.title_en).to eq('test')
      end
    end

    describe '#title_de=' do
      it 'sets the german translation' do
        post.title_de = 'test'
        expect(post.title_de).to eq('test')
      end
    end

    describe '#title_fr=' do
      it 'sets the french translation' do
        post.title_fr = 'test'
        expect(post.title_fr).to eq('test')
      end
    end

    describe '#title_es=' do
      it 'sets the spanish translation' do
        post.title_es = 'test'
        expect(post.title_es).to eq('test')
      end
    end

    describe '#content_en' do
      it 'uses the formatter' do
        expect(post.content_en).to eq('ne_tnetnoc')
      end
    end

    describe '#title_fields' do
      it 'returns an array' do
        expect(Post.title_fields).to be_a(Array)
      end

      it 'returns a list of strong parameters fields' do
        expect(Post.title_fields).to include(
          :title_en, :title_de, :title_fr, :title_es
        )
      end
    end

    describe '#title' do
      context 'when the default language is english' do
        it 'returns the english translation' do
          I18n.locale = :en
          expect(post.title).to eq('title_en')
        end
      end

      context 'when the default language is german' do
        it 'returns the german translation' do
          I18n.locale = :de
          expect(post.title).to eq('title_de')
        end
      end
    end
  end
end
