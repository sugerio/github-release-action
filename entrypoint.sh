#!/bin/bash
# Manually run command: sh entrypoint.sh

latest_version=$(hub release -L 1 -f "%T")
echo $latest_version

latest_version_no_v=$(echo $latest_version | grep -Eo '([0-9]+\.){2}[0-9]+')
echo $latest_version_no_v

commit_message=${1}
echo "commit_message:" $commit_message
DEFAULT_BUMP_TYPE="minor"
bump_type=""
# Get Bump Type based on git message.
if grep -q "major-release" <<< "$commit_message"; then
    bump_type="major"
elif grep -q "minor-release" <<< "$commit_message"; then
    bump_type="minor"
elif grep -q "patch-release" <<< "$commit_message"; then
    bump_type="patch"
else 
    bump_type=$DEFAULT_BUMP_TYPE
fi
echo "bump_type:" $bump_type

# Get bumped version based on bump_type.
split_version=(${latest_version_no_v//./ })
if [[ $bump_type == "major" ]]; then
    bump=$(expr ${split_version[0]} + 1)
    bumped_version_no_v=$bump.0.0
elif [[ $bump_type == "minor" ]]; then
    bump=$(expr ${split_version[1]} + 1)
    bumped_version_no_v=${split_version[0]}.$bump.0
elif [[ $bump_type == "patch" ]]; then
    bump=$(expr ${split_version[2]} + 1)
    bumped_version_no_v=${split_version[0]}.${split_version[1]}.$bump
fi
echo "bumped_version_no_v:" $bumped_version_no_v

bumped_version=v$bumped_version_no_v
echo "bumped_version:" $bumped_version

hub release create -m ${commit_message} $bumped_version

new_version=$(hub release -L 1 -f "%T")
echo "newly released version:" $new_version