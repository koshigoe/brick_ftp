require 'spec_helper'

RSpec.describe BrickFTP::API::FileOperation::UploadingSession, type: :lib do
  before { BrickFTP.config.api_key = 'xxxxxxxx' }

  describe '.create' do
    subject { described_class.create(path: 'NewFile.txt') }

    context 'success' do
      let(:source) { open('spec/data/file_upload/source.txt') }
      let(:body) do
        {
          'ref' => 'put-378670',
          'path' => 'NewFile.txt',
          'action' => 'put/write',
          'ask_about_overwrites' => false,
          'http_method' => 'PUT',
          'upload_uri' => 'https://s3.amazonaws.com/objects.brickftp.com/metadata/1/6eee7ad0-bf75-0131-71fc-0eeabbd7a8b4?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIEWLY3MN4YGZQOWA%2F20140516%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20140516T221456Z&X-Amz-Expires=180&X-Amz-SignedHeaders=host&partNumber=1&uploadId=xQDI8q.aDdWdWIvSpRGLOFqnPQqJoMGZ88r9g_q7z2gW6U4rNZx8Zb_Wh9m07TDJM1x4rCTM18UCzdXaYjJu.SBH89LAiA4ye698TfMPyam4BO7ifs7HLuiBPrEW.zIz&X-Amz-Signature=69bc7be37c8c42096e78aa4ff752f073ea890481c5f76eac5ad40a5ab9466997',
          'partsize' => 5_242_880,
          'part_number' => 1,
          'available_parts' => 10_000,
          'send' => {
            'partsize' => 'required-parameter Content-Length',
            'partdata' => 'body',
          },
          'headers' => {},
          'parameters' => {},
        }
      end

      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/files/NewFile.txt')
          .with(basic_auth: %w[xxxxxxxx x], body: { action: 'put' }.to_json)
          .to_return(status: 200, body: body.to_json)
      end

      it 'return instance of BrickFTP::API::FileOperation::UploadingSession' do
        is_expected.to be_an_instance_of BrickFTP::API::FileOperation::UploadingSession
      end

      it 'set attributes' do
        upload = subject
        expect(upload.ref).to eq 'put-378670'
        expect(upload.path).to eq 'NewFile.txt'
        expect(upload.action).to eq 'put/write'
        expect(upload.ask_about_overwrites).to eq false
        expect(upload.http_method).to eq 'PUT'
        expect(upload.upload_uri).to eq 'https://s3.amazonaws.com/objects.brickftp.com/metadata/1/6eee7ad0-bf75-0131-71fc-0eeabbd7a8b4?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIEWLY3MN4YGZQOWA%2F20140516%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20140516T221456Z&X-Amz-Expires=180&X-Amz-SignedHeaders=host&partNumber=1&uploadId=xQDI8q.aDdWdWIvSpRGLOFqnPQqJoMGZ88r9g_q7z2gW6U4rNZx8Zb_Wh9m07TDJM1x4rCTM18UCzdXaYjJu.SBH89LAiA4ye698TfMPyam4BO7ifs7HLuiBPrEW.zIz&X-Amz-Signature=69bc7be37c8c42096e78aa4ff752f073ea890481c5f76eac5ad40a5ab9466997'
        expect(upload.partsize).to eq 5_242_880
        expect(upload.part_number).to eq 1
        expect(upload.available_parts).to eq 10_000
        expect(upload.properties['send']).to eq('partsize' => 'required-parameter Content-Length', 'partdata' => 'body')
        expect(upload.headers).to eq({})
        expect(upload.parameters).to eq({})
      end
    end

    context 'failure' do
      let(:source) { '' }
      let(:chunk_size) { nil }

      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/files/NewFile.txt')
          .with(basic_auth: %w[xxxxxxxx x])
          .to_return(status: 500, body: { 'error' => 'xxxxxxxx', 'http-code' => '500' }.to_json)
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end
    end
  end

  describe '#at' do
    subject { uploading_session.at(3) }

    let(:uploading_session) { described_class.create(path: 'NewFile.txt') }
    let(:body) do
      {
        'ref' => 'put-378670',
        'path' => 'NewFile.txt',
        'action' => 'put/write',
        'ask_about_overwrites' => false,
        'http_method' => 'PUT',
        'upload_uri' => 'https://s3.amazonaws.com/objects.brickftp.com/metadata/1/6eee7ad0-bf75-0131-71fc-0eeabbd7a8b4?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIEWLY3MN4YGZQOWA%2F20140516%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20140516T221456Z&X-Amz-Expires=180&X-Amz-SignedHeaders=host&partNumber=1&uploadId=xQDI8q.aDdWdWIvSpRGLOFqnPQqJoMGZ88r9g_q7z2gW6U4rNZx8Zb_Wh9m07TDJM1x4rCTM18UCzdXaYjJu.SBH89LAiA4ye698TfMPyam4BO7ifs7HLuiBPrEW.zIz&X-Amz-Signature=69bc7be37c8c42096e78aa4ff752f073ea890481c5f76eac5ad40a5ab9466997',
        'partsize' => 5_242_880,
        'part_number' => 1,
        'available_parts' => 10_000,
        'send' => {
          'partsize' => 'required-parameter Content-Length',
          'partdata' => 'body',
        },
        'headers' => {},
        'parameters' => {},
      }
    end

    before do
      stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/files/NewFile.txt')
        .with(basic_auth: %w[xxxxxxxx x], body: { action: 'put' }.to_json)
        .to_return(status: 200, body: body.to_json)
    end

    context 'success' do
      before do
        body3 = body.merge('part_number' => 3)
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/files/NewFile.txt')
          .with(basic_auth: %w[xxxxxxxx x], body: { action: 'put', ref: 'put-378670', part: 3 }.to_json)
          .to_return(status: 200, body: body3.to_json)
      end

      it 'return instance of BrickFTP::API::FileOperation::UploadingSession' do
        is_expected.to be_an_instance_of BrickFTP::API::FileOperation::UploadingSession
      end

      it 'set attributes' do
        upload = subject
        expect(upload.ref).to eq 'put-378670'
        expect(upload.path).to eq 'NewFile.txt'
        expect(upload.action).to eq 'put/write'
        expect(upload.ask_about_overwrites).to eq false
        expect(upload.http_method).to eq 'PUT'
        expect(upload.upload_uri).to eq 'https://s3.amazonaws.com/objects.brickftp.com/metadata/1/6eee7ad0-bf75-0131-71fc-0eeabbd7a8b4?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIEWLY3MN4YGZQOWA%2F20140516%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20140516T221456Z&X-Amz-Expires=180&X-Amz-SignedHeaders=host&partNumber=1&uploadId=xQDI8q.aDdWdWIvSpRGLOFqnPQqJoMGZ88r9g_q7z2gW6U4rNZx8Zb_Wh9m07TDJM1x4rCTM18UCzdXaYjJu.SBH89LAiA4ye698TfMPyam4BO7ifs7HLuiBPrEW.zIz&X-Amz-Signature=69bc7be37c8c42096e78aa4ff752f073ea890481c5f76eac5ad40a5ab9466997'
        expect(upload.partsize).to eq 5_242_880
        expect(upload.part_number).to eq 3
        expect(upload.available_parts).to eq 10_000
        expect(upload.properties['send']).to eq('partsize' => 'required-parameter Content-Length', 'partdata' => 'body')
        expect(upload.headers).to eq({})
        expect(upload.parameters).to eq({})
      end
    end

    context 'failure' do
      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/files/NewFile.txt')
          .with(basic_auth: %w[xxxxxxxx x], body: { action: 'put', ref: 'put-378670', part: 3 }.to_json)
          .to_return(status: 500, body: '')
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end
    end
  end

  describe '#each' do
    let(:uploading_session) { described_class.create(path: 'NewFile.txt') }
    let(:body) do
      {
        'ref' => 'put-378670',
        'path' => 'NewFile.txt',
        'action' => 'put/write',
        'ask_about_overwrites' => false,
        'http_method' => 'PUT',
        'upload_uri' => 'https://s3.amazonaws.com/objects.brickftp.com/metadata/1/6eee7ad0-bf75-0131-71fc-0eeabbd7a8b4?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIEWLY3MN4YGZQOWA%2F20140516%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20140516T221456Z&X-Amz-Expires=180&X-Amz-SignedHeaders=host&partNumber=1&uploadId=xQDI8q.aDdWdWIvSpRGLOFqnPQqJoMGZ88r9g_q7z2gW6U4rNZx8Zb_Wh9m07TDJM1x4rCTM18UCzdXaYjJu.SBH89LAiA4ye698TfMPyam4BO7ifs7HLuiBPrEW.zIz&X-Amz-Signature=69bc7be37c8c42096e78aa4ff752f073ea890481c5f76eac5ad40a5ab9466997',
        'partsize' => 5_242_880,
        'part_number' => 1,
        'available_parts' => 3,
        'send' => {
          'partsize' => 'required-parameter Content-Length',
          'partdata' => 'body',
        },
        'headers' => {},
        'parameters' => {},
      }
    end

    before do
      stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/files/NewFile.txt')
        .with(basic_auth: %w[xxxxxxxx x], body: { action: 'put' }.to_json)
        .to_return(status: 200, body: body.to_json)
    end

    context 'success' do
      before do
        body2 = body.merge('part_number' => 2)
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/files/NewFile.txt')
          .with(basic_auth: %w[xxxxxxxx x], body: { action: 'put', ref: 'put-378670', part: 2 }.to_json)
          .to_return(status: 200, body: body2.to_json)

        body3 = body.merge('part_number' => 3)
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/files/NewFile.txt')
          .with(basic_auth: %w[xxxxxxxx x], body: { action: 'put', ref: 'put-378670', part: 3 }.to_json)
          .to_return(status: 200, body: body3.to_json)
      end

      context 'without block' do
        it 'return an Enumerator' do
          expect(uploading_session.each).to be_an_instance_of(Enumerator)
        end

        it 'iterate 3 times' do
          enum = uploading_session.each

          count = 0
          enum.each { count += 1 }
          expect(count).to eq 3
        end

        it 'gives instance of BrickFTP::API::FileOperation::UploadingSession to block' do
          enum = uploading_session.each

          enum.each do |obj|
            expect(obj).to be_an_instance_of(BrickFTP::API::FileOperation::UploadingSession)
          end
        end

        it 'update attribute' do
          enum = uploading_session.each

          enum.each.with_index(1) do |obj, n|
            expect(obj.part_number).to eq n
          end
        end
      end

      context 'with block' do
        it 'iterate 3 times' do
          count = 0
          uploading_session.each { count += 1 }
          expect(count).to eq 3
        end

        it 'gives instance of BrickFTP::API::FileOperation::UploadingSession to block' do
          uploading_session.each do |obj|
            expect(obj).to be_an_instance_of(BrickFTP::API::FileOperation::UploadingSession)
          end
        end

        it 'update attribute' do
          enum = uploading_session.each

          enum.each.with_index(1) do |obj, n|
            expect(obj.part_number).to eq n
          end
        end
      end
    end
  end

  describe '#commit' do
    let(:uploading_session) { described_class.create(path: 'NewFile.txt') }
    let(:body) do
      {
        'ref' => 'put-378670',
        'path' => 'NewFile.txt',
        'action' => 'put/write',
        'ask_about_overwrites' => false,
        'http_method' => 'PUT',
        'upload_uri' => 'https://s3.amazonaws.com/objects.brickftp.com/metadata/1/6eee7ad0-bf75-0131-71fc-0eeabbd7a8b4?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIEWLY3MN4YGZQOWA%2F20140516%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20140516T221456Z&X-Amz-Expires=180&X-Amz-SignedHeaders=host&partNumber=1&uploadId=xQDI8q.aDdWdWIvSpRGLOFqnPQqJoMGZ88r9g_q7z2gW6U4rNZx8Zb_Wh9m07TDJM1x4rCTM18UCzdXaYjJu.SBH89LAiA4ye698TfMPyam4BO7ifs7HLuiBPrEW.zIz&X-Amz-Signature=69bc7be37c8c42096e78aa4ff752f073ea890481c5f76eac5ad40a5ab9466997',
        'partsize' => 5_242_880,
        'part_number' => 1,
        'available_parts' => 3,
        'send' => {
          'partsize' => 'required-parameter Content-Length',
          'partdata' => 'body',
        },
        'headers' => {},
        'parameters' => {},
      }
    end

    before do
      stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/files/NewFile.txt')
        .with(basic_auth: %w[xxxxxxxx x], body: { action: 'put' }.to_json)
        .to_return(status: 200, body: body.to_json)
    end

    context 'success' do
      it 'delegate BrickFTP::API::FileOperation::UploadingResult.create' do
        result = double(BrickFTP::API::FileOperation::UploadingResult)
        expect(BrickFTP::API::FileOperation::UploadingResult)
          .to receive(:create).with(path: 'NewFile.txt', ref: 'put-378670').and_return(result)

        expect(uploading_session.commit).to eq result
      end
    end
  end
end
