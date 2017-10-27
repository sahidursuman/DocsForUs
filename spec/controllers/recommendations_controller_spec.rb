require 'rails_helper'

RSpec.describe RecommendationsController, type: :controller do
  let!(:doctor) { Doctor.create(full_name: 'Elizabeth Blackwell', first_name: 'Elizabeth', last_name: 'Blackwell') }

  describe 'GET #new' do
    it 'visits the new recommendation page' do
      get :new
      expect(response).to have_http_status 200
    end

    it 'creates an instance of a new recommendation' do
      get :new
      expect(assigns(:recommend)).to be_a Recommendation
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    it "responds with a status code of 204" do
      post :create, { params: { search: "Elizabeth Blackwell" } }
      expect(response).to have_http_status 204
    end

    it "checks database for existing doctors in database" do
      post :create, { params: { search: "Elizabeth Blackwell" } }
        expect(assigns(:doctor)).to be_a Doctor
    end

    it 'will return nil if no doctor is found in database' do
      post :create, { params: { search: "Elesa Yihdego" } }
      expect(assigns(:doctor)).to be_nil
    end

    it 'redirects the new doctor template if doctor is not in database' do
      post :create, { params: { search: "Elesa Yihdego" } }
      expect(response.body).to eq('hello')
    end
  end

end