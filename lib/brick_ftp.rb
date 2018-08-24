# frozen_string_literal: true

require 'deep_hash_transform'
require 'brick_ftp/version'
require 'brick_ftp/client'
require 'brick_ftp/utils'
require 'brick_ftp/utils/chunk_io'
require 'brick_ftp/types'
require 'brick_ftp/restful_api'

module BrickFTP
  # https://brickftp.com/redundancy/
  IP_ADDRESSES = %w[
    54.193.69.72
    54.193.69.200
    54.193.65.189
    54.193.69.198
    54.208.20.30
    54.209.242.244
    54.209.231.233
    54.208.198.60
    54.209.231.99
    54.209.246.178
    54.209.91.52
    54.208.63.151
    54.209.246.217
    54.209.222.205
    54.208.169.75
    52.8.210.89
    52.74.166.120
    52.64.2.88
    52.17.96.203
    52.28.101.76
    54.232.253.47
    54.64.240.152
    52.74.188.115
    52.64.6.120
    52.18.87.39
    52.29.176.178
    54.207.27.239
    52.68.4.44
  ].freeze
end
