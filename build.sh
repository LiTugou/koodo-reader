#!/bin/bash
latest_tag=$(git ls-remote --tags https://github.com/troyeguo/koodo-reader.git|tail -1)
tag=${latest_tag##*/}
git clone -b ${tag} https://github.com/troyeguo/koodo-reader.git
rm koodo-reader/.git -r
cd koodo-reader
npx browserslist@latest --update-db
yarn && yarn build
tar -czf koodo-reader-build.tar.gz -C ./build .
cd ../
shopt -s extglob
rm -rf !(\.*|*.sh|koodo-reader)
cp -r koodo-reader/build/* ./
