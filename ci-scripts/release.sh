#!/usr/bin/env bash

parse_environment_variables() {
    TWINE_USERNAME=${PYPI_USER:?'PYPI_USER variable missing.'}
    TWINE_PASSWORD=${PYPI_PASS:?'PYPI_PASS variable missing.'}
}

semantic_release() {
    npm install --silent
    npm run semantic-release
}

pypi_release() {
    make release
}

parse_environment_variables

local current_tag=$(git describe --tags)
semantic_release

local new_tag=$(git describe --tags)
if [ current_tag != new_tag ]; then
    pypi_release
fi
