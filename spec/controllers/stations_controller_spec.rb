require 'rails_helper'

RSpec.describe StationsController, type: :controller do

  let(:valid_attributes) {
    {latitude: 45.50708, longitude: -73.56917}
  }

  let(:valid_session) { {} }

  let(:valid_params) { {radius: 0.5, latitude: 45.506318, longitude: -73.569021, empty: 'true'} }

  before do
   [
     valid_attributes.merge(name: "Empty Station", available_bikes: 0, latitude: 45.50537693, longitude: -73.5676195),
     valid_attributes.merge(name: "Far Station", available_bikes: 5, latitude: 45.5567079151363, longitude: -73.6706337332726),
     valid_attributes.merge(name: "Near Station", available_bikes: 5),
   ].each do |s|
     Station.create! s
   end
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: valid_params, session: valid_session, format: "json"
      expect(response).to be_success
    end

    it "do not return far away stations and order by distance" do
      get :index, params: valid_params, session: valid_session, format: "json"
      stations = assigns(:stations).to_a
      expect(stations.count).to eq(2)
      expect(stations.first.name).to eq('Near Station')
      expect(stations.last.name).to eq('Empty Station')
    end

    it "do not return empty stations when empty param is false" do
      get :index, params: valid_params.merge(empty: 'false'), session: valid_session, format: "json"
      stations = assigns(:stations).to_a
      expect(stations.count).to eq(1)
      expect(stations.first['name']).to eq('Near Station')
    end

    it "returns far stations when the radius param is provided" do
      get :index, params: valid_params.merge(radius: 10), session: valid_session, format: "json"
      stations = assigns(:stations).to_a
      expect(stations.count).to eq(3)
      expect(stations[0].name).to eq('Near Station')
      expect(stations[1].name).to eq('Empty Station')
      expect(stations[2].name).to eq('Far Station')
    end

    context 'bad parameters' do
      it "respond with an error" do
        get :index, params: valid_params.merge(radius: "lol"), session: valid_session, format: "json"
        expect(response.code).to eq("422")
        expect(JSON.parse(response.body)).to eq({"error"=>"Radius is not a number"})
      end
    end
  end
end
