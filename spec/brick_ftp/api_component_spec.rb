require 'spec_helper'

RSpec.describe BrickFTP::APIComponent, type: :lib do
  let(:api_component) do
    described_class.new(
      path_template,
      %i[page per_page search sort_by[path] sort_by[size] sort_by[modified_at_datetime]]
    )
  end

  let(:path_template) { '/api/rest/v1/folders/%{path}' }

  let(:params) do
    {
      path: 'a/b/c include spaces.txt',
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
      # rubocop:disable Metrics/LineLength
      it { is_expected.to eq '/api/rest/v1/folders/a%2Fb%2Fc%20include%20spaces.txt?page=1&per_page=1&search=a%2F&sort_by%5Bpath%5D=asc&sort_by%5Bsize%5D=asc&sort_by%5Bmodified_at_datetime%5D=asc' }
      # rubocop:enable Metrics/LineLength
    end

    context 'params is not a Hash' do
      let(:params) { 1 }
      # rubocop:disable Metrics/LineLength
      it { is_expected.to eq '/api/rest/v1/folders/1?page=1&per_page=1&search=1&sort_by%5Bpath%5D=1&sort_by%5Bsize%5D=1&sort_by%5Bmodified_at_datetime%5D=1' }
      # rubocop:enable Metrics/LineLength
    end

    context 'path_template is a proc' do
      let(:path_template) do
        ->(params) { params.key?(:path) ? '/a/b/%{path}' : '/a/b' }
      end

      context 'params has path key' do
        let(:params) { { path: 'c' } }
        it { is_expected.to eq '/a/b/c' }
      end

      context 'params does not have key' do
        let(:params) { {} }
        it { is_expected.to eq '/a/b' }
      end
    end
  end

  describe '#build_path_params_from' do
    subject { api_component.build_path_params_from(params) }

    context 'params is a Hash' do
      it do
        is_expected.to eq(path: 'a/b/c include spaces.txt')
      end
    end

    context 'params is not a Hash' do
      let(:params) { 1 }
      it do
        is_expected.to eq(path: 1)
      end
    end

    context 'path_template is a proc' do
      let(:path_template) do
        ->(params) { params.key?(:path) ? '/a/b/%{path}' : '/a/b' }
      end

      context 'params has path key' do
        let(:params) { { path: 'c' } }
        it { is_expected.to eq(path: 'c') }
      end

      context 'params does not have key' do
        let(:params) { {} }
        it { is_expected.to eq({}) }
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
        # rubocop:disable Metrics/LineLength
        is_expected.to eq 'page=1&per_page=1&search=a%2F&sort_by%5Bpath%5D=asc&sort_by%5Bsize%5D=asc&sort_by%5Bmodified_at_datetime%5D=asc'
        # rubocop:enable Metrics/LineLength
      end
    end

    context 'params is not a Hash' do
      let(:params) { 1 }
      it do
        # rubocop:disable Metrics/LineLength
        is_expected.to eq 'page=1&per_page=1&search=1&sort_by%5Bpath%5D=1&sort_by%5Bsize%5D=1&sort_by%5Bmodified_at_datetime%5D=1'
        # rubocop:enable Metrics/LineLength
      end
    end
  end

  describe '#except_path_and_query' do
    subject { api_component.except_path_and_query(params) }

    before { params[:attr] = 'a' }

    it { is_expected.to eq(attr: 'a') }

    context 'path_template is a proc' do
      let(:path_template) do
        ->(params) { params.key?(:path) ? '/a/b/%{path}' : '/a/b' }
      end

      context 'params has path key' do
        let(:params) { { path: 'c' } }
        it { is_expected.to eq(attr: 'a') }
      end

      context 'params does not have key' do
        let(:params) { {} }
        it { is_expected.to eq(attr: 'a') }
      end
    end
  end
end
