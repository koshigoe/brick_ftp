require 'spec_helper'

RSpec.describe BrickFTP::API::FileOperation::Upload, type: :lib do
  before { BrickFTP.config.api_key = 'xxxxxxxx' }

  describe '.create' do
    subject { described_class.create(path: 'NewFile.txt', source: source) }

    context 'success' do
      let(:source) { open('spec/data/file_upload/source.txt') }

      let(:step1) do
        {
          "ref" => "put-378670",
          "path" => "NewFile.txt",
          "action" => "put/write",
          "ask_about_overwrites" => false,
          "http_method" => "PUT",
          "upload_uri" => "https://s3.amazonaws.com/objects.brickftp.com/metadata/1/6eee7ad0-bf75-0131-71fc-0eeabbd7a8b4?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIEWLY3MN4YGZQOWA%2F20140516%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20140516T221456Z&X-Amz-Expires=180&X-Amz-SignedHeaders=host&partNumber=1&uploadId=xQDI8q.aDdWdWIvSpRGLOFqnPQqJoMGZ88r9g_q7z2gW6U4rNZx8Zb_Wh9m07TDJM1x4rCTM18UCzdXaYjJu.SBH89LAiA4ye698TfMPyam4BO7ifs7HLuiBPrEW.zIz&X-Amz-Signature=69bc7be37c8c42096e78aa4ff752f073ea890481c5f76eac5ad40a5ab9466997",
          "partsize" => 5242880,
          "part_number" => 1,
          "available_parts" => 10000,
          "send" => {
            "partsize" => "required-parameter Content-Length",
            "partdata" => "body"
          },
          "headers" => {},
          "parameters" => {}
        }
      end

      let(:step3) do
        {
          "id" => 1,
          "path" => "NewFile.txt",
          "type" => "file",
          "size" => 412,
          "mtime" => "2014-05-17T05:14:35+00:00",
          "crc32" => nil,
          "md5" => nil
        }
      end

      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/files/NewFile.txt')
          .with(basic_auth: ['xxxxxxxx', 'x'], body: { action: 'put' }.to_json)
          .to_return(status: 200, body: step1.to_json)

        stub_request(:put, "https://s3.amazonaws.com/objects.brickftp.com/metadata/1/6eee7ad0-bf75-0131-71fc-0eeabbd7a8b4?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIEWLY3MN4YGZQOWA%2F20140516%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20140516T221456Z&X-Amz-Expires=180&X-Amz-SignedHeaders=host&partNumber=1&uploadId=xQDI8q.aDdWdWIvSpRGLOFqnPQqJoMGZ88r9g_q7z2gW6U4rNZx8Zb_Wh9m07TDJM1x4rCTM18UCzdXaYjJu.SBH89LAiA4ye698TfMPyam4BO7ifs7HLuiBPrEW.zIz&X-Amz-Signature=69bc7be37c8c42096e78aa4ff752f073ea890481c5f76eac5ad40a5ab9466997")
          .with(body: "This is a test upload file to BrickFTP.\n")
          .to_return(status: 200, body: '')

        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/files/NewFile.txt')
          .with(basic_auth: ['xxxxxxxx', 'x'], body: { action: 'end', ref: 'put-378670' }.to_json)
          .to_return(status: 200, body: step3.to_json)
      end

      it 'return instance of BrickFTP::API::FileOperation::Upload' do
        is_expected.to be_an_instance_of BrickFTP::API::FileOperation::Upload
      end

      it 'set attributes' do
        upload = subject
        expect(upload.ref).to eq 'put-378670'
        expect(upload.path).to eq 'NewFile.txt'
        expect(upload.action).to eq 'put/write'
        expect(upload.ask_about_overwrites).to eq false
        expect(upload.http_method).to eq 'PUT'
        expect(upload.upload_uri).to eq "https://s3.amazonaws.com/objects.brickftp.com/metadata/1/6eee7ad0-bf75-0131-71fc-0eeabbd7a8b4?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIEWLY3MN4YGZQOWA%2F20140516%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20140516T221456Z&X-Amz-Expires=180&X-Amz-SignedHeaders=host&partNumber=1&uploadId=xQDI8q.aDdWdWIvSpRGLOFqnPQqJoMGZ88r9g_q7z2gW6U4rNZx8Zb_Wh9m07TDJM1x4rCTM18UCzdXaYjJu.SBH89LAiA4ye698TfMPyam4BO7ifs7HLuiBPrEW.zIz&X-Amz-Signature=69bc7be37c8c42096e78aa4ff752f073ea890481c5f76eac5ad40a5ab9466997"
        expect(upload.partsize).to eq 5242880
        expect(upload.part_number).to eq 1
        expect(upload.available_parts).to eq 10000
        expect(upload.send).to eq("partsize" => "required-parameter Content-Length", "partdata" => "body")
        expect(upload.headers).to eq({})
        expect(upload.parameters).to eq({})
        expect(upload.id).to eq 1
        expect(upload.type).to eq 'file'
        expect(upload.size).to eq 412
        expect(upload.mtime).to eq '2014-05-17T05:14:35+00:00'
        expect(upload.crc32).to eq nil
        expect(upload.md5).to eq nil
      end
    end

    context 'failure' do
      let(:source) { '' }

      before do
        stub_request(:post, 'https://koshigoe.brickftp.com/api/rest/v1/files/NewFile.txt')
          .with(basic_auth: ['xxxxxxxx', 'x'])
          .to_return(status: 500, body: { 'error' => 'xxxxxxxx', 'http-code' => '500' }.to_json)
      end

      it 'raise BrickFTP::HTTPClient::Error' do
        expect { subject }.to raise_error BrickFTP::HTTPClient::Error
      end
    end
  end
end
