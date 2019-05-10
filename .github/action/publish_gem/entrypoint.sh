#!/bin/ash -eu

action=$(jq -r '.action' $GITHUB_EVENT_PATH)
if [ "$action" != "published" ]; then
    exit 0
fi

cd $GITHUB_WORKSPACE

mkdir -p ~/.gem
cat <<EOF > ~/.gem/credentials
---
:rubygems_api_key: $RUBYGEMS_TOKEN
EOF
chmod 0600 ~/.gem/credentials

gem build *.gemspec
gem push *.gem
