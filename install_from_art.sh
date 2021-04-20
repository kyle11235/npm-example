

# vi package-lock.json
# http://182.92.214.141:8082/artifactory/api/npm/npm

rm package-lock.json
rm -rf node_modules

npm cache clean --force
npm install

# npm cache clean --force
# npm install @types/echarts@4.9.7

# yarn cache clean
# yarn add @types/echarts@4.9.7