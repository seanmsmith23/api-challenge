require 'rails_helper'

RSpec.describe QueriesController, :type => :controller do
  before :each do
    AwsS3.stub(:get_results).and_return([
      {:filename=>"opposites.txt", :key=>"Led Zeppelin", :value=>"lameness"},
      {:filename=>"opposites.txt", :key=>"platypuses", :value=>"likely things"},
      {:filename=>"opposites.txt", :key=>"Led Zeppelin", :value=>"Maroon 5"},
      {:filename=>"opposites.txt", :key=>"Boulder, CO", :value=>"Houston"},
      {:filename=>"second.txt", :key=>"Kenya", :value=>"Nairobi"},
      {:filename=>"second.txt", :key=>"Uganda", :value=>"Kampala"},
      {:filename=>"second.txt", :key=>"Tanzania", :value=>"Dar es Salaam"},
      {:filename=>"second.txt", :key=>"Ghana", :value=>"Accra"}
    ])
  end

  it "should return sorted JSON" do
    response = get("show")

    expect(response.body).to eq("[{\"filename\":\"opposites.txt\",\"key\":\"Boulder, CO\",\"value\":\"Houston\"},{\"filename\":\"opposites.txt\",\"key\":\"Led Zeppelin\",\"value\":\"Maroon 5\"},{\"filename\":\"opposites.txt\",\"key\":\"Led Zeppelin\",\"value\":\"lameness\"},{\"filename\":\"opposites.txt\",\"key\":\"platypuses\",\"value\":\"likely things\"},{\"filename\":\"second.txt\",\"key\":\"Ghana\",\"value\":\"Accra\"},{\"filename\":\"second.txt\",\"key\":\"Kenya\",\"value\":\"Nairobi\"},{\"filename\":\"second.txt\",\"key\":\"Tanzania\",\"value\":\"Dar es Salaam\"},{\"filename\":\"second.txt\",\"key\":\"Uganda\",\"value\":\"Kampala\"}]")
  end

  
end
