require "rails_helper"

describe ContactsController do
  describe "GET index" do
    subject(:get_contacts) { get :index, format: :json }

    it "returns proper response" do
      get_contacts
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("[]")
    end
  end

  describe "POST create" do
    subject(:post_contact) { post :create, params: params, format: :json }

    let(:params) do
      {
        contact: {
          email: 'test@test.com',
          name: 'Adam',
          first_name: 'Adam',
          last_name: 'Nowak',
          addresses_attributes: [
            { city: 'Miasto_1', street: 'Ulica_1', street_number: 1 },
            { city: 'Miasto_2', street: 'Ulica_2', street_number: 2 }
          ]
        }
      }
    end

    it "returns proper response code" do
      post_contact
      expect(response).to have_http_status(:created)
    end

    it "creates new contact" do
      expect { post_contact }.to change { Contact.count }.by(1)
    end

    it 'creates new contact with attributes' do
      post_contact
      expect(response_body[:first_name]).to eq('Adam')
      expect(response_body[:last_name]).to eq('Nowak')
    end

    it 'create associated addresses' do
      expect { post_contact }.to change { Address.count }.by(2)

      expect(response_body[:addresses].length).to eq(2)

      expect(response_body[:addresses][0][:city]).to eq('Miasto_1')
      expect(response_body[:addresses][0][:street]).to eq('Ulica_1')
      expect(response_body[:addresses][0][:street_number]).to eq(1)

      expect(response_body[:addresses][1][:city]).to eq('Miasto_2')
      expect(response_body[:addresses][1][:street]).to eq('Ulica_2')
      expect(response_body[:addresses][1][:street_number]).to eq(2)
    end
  end

  describe "POST mass_create" do
    subject(:post_mass_create) { post :mass_create, format: :json }

    let(:start_time) { Time.now.to_i }
    let(:end_time) { Time.now.to_i }

    # refactor needed
    it "creates new contacts" do
      p "Start at: #{start_time}"

      expect { post_mass_create }.to change { Contact.count }.by(10_000)
      expect(response).to have_http_status(:created)

      p "End at: #{end_time}"
      p "Delta: #{end_time - start_time} seconds"
    end

    it "returns contacts with expected keys" do
      post_mass_create
      response_body.each do |contact|
        expect(contact).to have_key(:id)
        expect(contact).to have_key(:name)
        expect(contact).to have_key(:email)
      end
    end
  end

  describe "GET show" do
    subject(:show_contacts) { get :show, params: params, format: :json }

    let(:params) { { id: contact.id } }
    let(:contact) { create(:contact) }

    it "returns proper response" do
      show_contacts
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH update" do
    subject(:patch_contact) { patch :update, params: params, format: :json }

    let(:params) { { id: contact.id, contact: { email: "test2@test.com", name: "Adam" } } }
    let(:contact) { create(:contact) }

    it "returns proper response code" do
      patch_contact
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE destroy" do
    subject(:delete_contact) { delete :destroy, params: params, format: :json }

    let(:params) { { id: contact.id } }
    let(:contact) { create(:contact) }

    before { contact }

    it "returns proper response code" do
      delete_contact
      expect(response).to have_http_status(:no_content)
    end

    it "deletes contanct" do
      expect { delete_contact }.to change { Contact.count }.by(-1)
    end
  end

  private

    def response_body
      JSON.parse(response.body, symbolize_names: true)
    end
end
