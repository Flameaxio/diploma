# frozen_string_literal: true

resource 'columns', controller: ColumnsController do
  explanation 'Columns routines'

  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  before do
    login_user
  end

  let!(:workspace) { create(:workspace) }
  let!(:columns) { create_list(:column, 10, workspace: workspace) }

  put '/workspaces/:workspace_id/columns/:id' do
    let(:workspace_id) { workspace.id }
    let(:id) { columns.first.id }

    let(:raw_post) { { name: 'Test' }.to_json }

    example_request 'Update a column' do
      puts response_body if response_status != 200
      expect(response_status).to eq(200)

      expect(parsed_response.data&.attributes&.name).to eq('Tes')
    end
  end
end
