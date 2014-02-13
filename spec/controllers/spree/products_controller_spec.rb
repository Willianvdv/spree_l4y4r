require 'spec_helper'

describe Spree::ProductsController do
  describe '#after_show' do
    let(:product) { create :product }
    let!(:variant_service) { double }

    before do
      controller.stub(try_spree_current_user: user)
      controller.stub spree_current_user: user
      controller.stub(:variant_service).and_return(variant_service)
    end

    context 'has user' do
      let(:user) { create(:user) }

      it 'pushes the show event to layer' do
        expect(variant_service).to receive(:push_to_layer).once
        spree_get :show, id: product.slug
      end
    end

    context 'has no user' do
      let(:user) { nil }

      it 'doesnt crash' do
        spree_get :show
      end
    end
  end
end