#!/bin/bash
latest_tag=$(git ls-remote --tags https://github.com/troyeguo/koodo-reader.git|tail -1)
tag=${latest_tag##*/}
git clone -b ${tag} https://github.com/troyeguo/koodo-reader.git
rm koodo-reader/.git -r
cd koodo-reader
# echo 'PUBLIC_URL="https://cdn.jsdelivr.net/gh/LiTugou/koodo-reader@main"' > .env
PUBLIC_URL="https://cdn.jsdelivr.net/gh/LiTugou/koodo-reader@main"
echo "PUBLIC_URL=${PUBLIC_URL}" > .env
#sed -i "s?\./assets?${PUBLIC_URL}/assets?g" launchUtil.tsx
yarn && yarn build || exit 0
sed -i "s?\./assets?${PUBLIC_URL}/assets?g" ./build/static/js/main.*.js
tar -czf koodo-reader-build.tar.gz -C ./build .
cd ../
shopt -s extglob
rm -rf !(\.*|*.sh|koodo-reader)
cp -r koodo-reader/build/* ./
