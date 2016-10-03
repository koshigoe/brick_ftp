require 'spec_helper'

RSpec.describe BrickFTP::APIComponent, type: :lib do
  let(:api_component) do
    described_class.new(
      '/api/rest/v1/folders/%{path}',
      %i(page per_page search sort_by[path] sort_by[size] sort_by[modified_at_datetime])
    )
  end

  let(:params) do
    {
      path: 'a/b/c.txt',
      page: 1,
      per_page: 1,
      search: 'a/',
     :'sort_by[path]' => 'asc',
     :'sort_by[size]' => 'asc',
     :'sort_by[modified_at_datetime]' => 'asc',
    }
  end

  describe '#path' do
    subject { api_component.path(params) }

    context 'params is a Hash' do
      it { is_expected.to eq '/api/rest/v1/folders/a%2Fb%2Fc.txt?page=1&per_page=1&search=a%2F&sort_by%5Bpath%5D=asc&sort_by%5Bsize%5D=asc&sort_by%5Bmodified_at_datetime%5D=asc' }
    end

    context 'params is not a Hash' do
      let(:params) { 1 }
      it { is_expected.to eq '/api/rest/v1/folders/1?page=1&per_page=1&search=1&sort_by%5Bpath%5D=1&sort_by%5Bsize%5D=1&sort_by%5Bmodified_at_datetime%5D=1' }
    end
  end

  describe '#build_path_params_from' do
    subject { api_component.build_path_params_from(params) }

    context 'params is a Hash' do
      it do
        is_expected.to eq(path: 'a/b/c.txt')
      end
    end

    context 'params is not a Hash' do
      let(:params) { 1 }
      it do
        is_expected.to eq(path: 1)
      end
    end
  end

  describe '#build_query_params_from' do
    subject { api_component.build_query_params_from(params) }

    context 'params is a Hash' do
      it do
        is_expected
          .to eq(
                page: 1,
                per_page: 1,
                search: 'a/',
                :'sort_by[path]' => 'asc',
                :'sort_by[size]' => 'asc',
                :'sort_by[modified_at_datetime]' => 'asc'
              )
      end
    end

    context 'params is not a Hash' do
      let(:params) { 1 }
      it do
        is_expected
          .to eq(
                page: 1,
                per_page: 1,
                search: 1,
                :'sort_by[path]' => 1,
                :'sort_by[size]' => 1,
                :'sort_by[modified_at_datetime]' => 1
              )
      end
    end
  end

  describe '#build_query_string_from' do
    subject { api_component.build_query_string_from(params) }

    context 'params is a Hash' do
      it do
        is_expected.to eq 'page=1&per_page=1&search=a%2F&sort_by%5Bpath%5D=asc&sort_by%5Bsize%5D=asc&sort_by%5Bmodified_at_datetime%5D=asc'
      end
    end

    context 'params is not a Hash' do
      let(:params) { 1 }
      it do
        is_expected.to eq 'page=1&per_page=1&search=1&sort_by%5Bpath%5D=1&sort_by%5Bsize%5D=1&sort_by%5Bmodified_at_datetime%5D=1'
      end
    end
  end

  describe '#except_path_and_query' do
    subject { api_component.except_path_and_query(params) }

    before { params[:attr] = 'a' }

    it { is_expected.to eq(attr: 'a') }
  end
end
