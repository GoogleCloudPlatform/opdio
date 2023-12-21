#!/usr/bin/env bash

# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

### Ref: http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -exo pipefail

### Import Environment Variables & arguments
ENV_GITHUB_RUN_ID="${GITHUB_RUN_ID}"
ARG_DIR_SOURCE="${DIR_GHP}"
ARG_SCRIPT_BUILD=bin/compile_docs.sh
set -u

DIR_WORKSPACE="$(pwd)"
DIR_TMP_GHP="/tmp/${DIR_GHP}"
CURRENT_BRANCH=$(git branch --show-current)

npx @redocly/cli build-docs omio.yml -o "${DIR_GHP}/index.html"

if [[ -n "${ENV_GITHUB_RUN_ID}" ]]; then
  git config user.name "${GITHUB_ACTOR}"
  git config user.email "${GITHUB_ACTOR}@github.com"
fi

### Ensure the 'gh-pages' orphan branch exists
! git checkout --orphan gh-pages >> /dev/null
if [[ ${PIPESTATUS[0]} -eq 0 ]]; then
  git reset --hard
  git commit --allow-empty -m "Initial gh-pages commit"
  git checkout "${CURRENT_BRANCH}"
  echo "Orphan branch 'gh-pages' created."
fi

if [ ! -d "${ARG_DIR_SOURCE}" ] || [ ! -r "${ARG_DIR_SOURCE}" ]; then
  echo "Source directory must exist and be readable, path must be relative to the root of the project."
  exit 3
fi

### Clean up worktree and /tmp dir
! rm -rf "${DIR_TMP_GHP}" >> /dev/null
! git worktree remove "${DIR_TMP_GHP}" >> /dev/null

### Copy gh-pages source to worktree
git worktree add "${DIR_TMP_GHP}" gh-pages
rm -rf "${DIR_TMP_GHP:?}/*"
cp -r "${ARG_DIR_SOURCE:?}"/* "${DIR_TMP_GHP}/"

### Publish gh-pages
cd "${DIR_TMP_GHP}"
echo omio.scales.cloud >> CNAME
git add --all

### Allow the commit to fail, as not all commits alter the GitHub Pages
! git commit -m "action-ghp-sync update"
if [[ ${PIPESTATUS[0]} -eq 0 ]]; then
  git push -f origin gh-pages
  echo "✅ GitHub Pages published successfully!"
else
  echo "☑ No changes detected"
fi

