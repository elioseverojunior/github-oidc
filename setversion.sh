#!/usr/bin/env bash

dotnet-gitversion /output gitversion.json > givertions.json
jq -Sr '.InformationalVersion' givertions.json > .version
