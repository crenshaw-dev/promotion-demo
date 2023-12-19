#!/usr/bin/env bash

for env in "dev" "e2e" "prd"; do
  for region in "east" "west"; do
    app_name="argocd/my-app-${env}-${region}"
    mkdir -p "/tmp/${app_name}"
    commit_info=$(git log -1 --pretty='format:%H %an <%ae> %s')
    manifest_file="/tmp/${app_name}/manifest.yaml"
    echo "App: ${app_name} (https://localhost:8080/applications/${app_name})" > $manifest_file
    echo "Commit: ${commit_info}" >> $manifest_file
    kustomize build "${env}/${region}" >> $manifest_file
  done
done
