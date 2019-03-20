#!/bin/ash -eu

# Get previous GitHub Release.
curl --fail -s \
     -u $GITHUB_ACTOR:$GITHUB_TOKEN \
     https://api.github.com/repos/$GITHUB_REPOSITORY/releases \
    | jq -r '.[1]' \
     > previous_release.json
previous_published_date=$(jq -r '.published_at' previous_release.json)

# Get latest published date.
latest_published_date=$(jq -r '.release.published_at' $GITHUB_EVENT_PATH)

# Get latest GitHub Release ID.
latest_release_id=$(jq -r '.release.id' $GITHUB_EVENT_PATH)

# Get merged PRs
merged_pr_list=$(
    curl --fail -s \
         -u $GITHUB_ACTOR:$GITHUB_TOKEN \
         "https://api.github.com/search/issues?q=repo:${GITHUB_REPOSITORY}+is:pr+base:master+merged:${previous_published_date}..${latest_published_date}" \
        | jq -r '.items[] | ["- #" + (.number | tostring) + " " + .title] | @tsv' \
        | sort -k 3)

# Get comparable tags
previous_tag_name=$(jq -r '.tag_name' previous_release.json)
latest_tag_name=$(jq -r '.release.tag_name' $GITHUB_EVENT_PATH)

# Make release note.
release_note=$(cat <<EOF | sed ':a;N;$!ba;s/\n/\\n/g')
https://github.com/$GITHUB_REPOSITORY/compare/${previous_tag_name}...${latest_tag_name}

### Merged

$merged_pr_list
EOF

# Update body of latest GitHub Release.
curl --fail -s \
     -u $GITHUB_ACTOR:$GITHUB_TOKEN \
     -X PATCH \
     -d "{\"body\":\"${release_note}\"}" \
     https://api.github.com/repos/$GITHUB_REPOSITORY/releases/$latest_release_id
