

rm package-lock.json
rm -rf node_modules

npm cache clean --force
npm install --registry=https://registry.npmjs.org

# npm install --registry=https://registry.npm.taobao.org
