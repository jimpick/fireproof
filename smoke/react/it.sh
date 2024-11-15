#!/bin/sh
set -e
cd smoke/react
smokeDir=$(pwd)
tmpDir=$(mktemp -d)
rm -rf node_modules dist pnpm-lock.yaml
cp -pr * $tmpDir
cd $tmpDir
fp_core=$(echo $smokeDir/../../dist/fireproof-core/fireproof-core-*.tgz)
use_fp=$(echo $smokeDir/../../dist/use-fireproof/use-fireproof-*.tgz)
sed -e "s|FIREPROOF_CORE|file://$fp_core|g" \
    -e "s|USE_FIREPROOF|file://$use_fp|g" package-template.json > package.json
# cp package-template.json package.json
pnpm install
# pnpm install -f "file://$smokeDir/../../dist/fireproof-core/fireproof-core-*.tgz"
# pnpm install -f "file://$smokeDir/../../dist/use-fireproof/use-fireproof-*.tgz"
# pnpm run test > /dev/null 2>&1 || true
pnpm run test
rm -rf $tmpDir
