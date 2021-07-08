# NPM Example

- repo 
        
        - structure

                - taobao remote
                https://registry.npm.taobao.org/
                        
                .npm
                .npm/npm-example
                .npm/npm-example/package.json  （include all versions, e.g. below two）
                .npm/npm-example/npm-example-0.0.3.json  
                .npm/npm-example/npm-example-0.0.4.json （include download url）
                        http://182.92.214.141:8081/api/npm/npm-local/npm-example/-/npm-example-0.0.4.tgz (ali is not - , but called download)

                npm-example
                npm-example/-
                npm-example/-/npm-example-0.0.3.tgz
                npm-example/-/npm-example-0.0.4.tgz

                npm-example/download
                npm-example/download/npm-example-0.0.0.tgz
                npm-example/download/npm-example-0.0.1.tgz

        - metadata API

                - art
                http://182.92.214.141:8081/artifactory/api/npm/npm/npm-example
                (this virtual includes local & remote pkg)

                http://182.92.214.141:8081/artifactory/api/npm/npm/npm-example/0.0.4
                http://182.92.214.141:8081/artifactory/api/npm/npm/npm-example/0.0.1

                - npmjs.com
                https://registry.npmjs.com/npm-example
                https://registry.npmjs.com/npm-example/0.0.1

                - alibaba
                https://registry.npm.taobao.org/npm-example
                https://registry.npm.taobao.org/npm-example/0.0.1

- local build

        - guide
        
                https://www.kdocs.cn/l/shqQB0HKf?f=501

        - install
                        
                install nodejs & npm
                wget https://npm.taobao.org/mirrors/node/v14.15.4/node-v14.15.4-linux-x64.tar.xz
                xz xxx.xz
                tar -xvf xxx.gz
                set node path in /etc/profile

        - config

                - npm
                        
                        npm config set registry https://registry.npmjs.org/
                        npm config set registry https://registry.npm.taobao.org
                        npm config set registry http://182.92.214.141:8081/artifactory/api/npm/npm/
                        npm config set always-auth true
                        npm login
                        kyle/password

                                - error
                                401

                                - fix
                                vi .npmrc
                                always-auth=true
                                
                                e.g.
                                //182.92.214.141:8081/artifactory/api/npm/npm/:_authToken.....
                                //182.92.214.141:8081/artifactory/api/npm/npm/:always-auth=true

                - yarn
                
                        yarn config set registry http://182.92.214.141:8081/artifactory/api/npm/npm/
                        yarn login

        - test
        
                - install
                
                        cd npm-example
                        npm install

                - publish
                
                        cd  node_modules/ms
                        npm publish --registry http://182.92.214.141:8081/artifactory/api/npm/npm/
                        (ending npm is a virtual repo)

                - install version

                        npm cache clean --force
                        npm install accepts@1.3.7

                - install version by yarn 

                        yarn cache clean
                        yarn add accepts@1.3.7

- xray npm

        must be a virtual repo
        npm config set registry http://182.92.214.141:8081/artifactory/api/npm/npm/
        npm login
        cd /Users/kyle/workspace/npm-example
        npm audit

        e.g.
        found 0 vulnerabilities
        in 19 scanned packages
                

- npm pipeline

        - guide
        
                https://www.kdocs.cn/l/sUfn8115n?f=501

        - install
        
                install nodejs plugin
                node directory = /usr/local/bin

        - test
        
                npm.groovy


## Overview
Artifactory provides full support for managing npm packages and ensures optimal and reliable access to npmjs.org. It also allows aggregating multiple npm registries under a virtual repository Artifactory, which provides access to all your npm packages through a single URL for both upload and download.

You may store exhaustive build information in Artifactory by running your npm builds with [JFrog CLI](https://www.jfrog.com/confluence/display/CLI/JFrog+CLI). 
JFrog CLI collects build-info from your build agents and then publishes it to Artifactory. Once published, the build info can be viewed in the Build Browser under Builds.
For more details on npm build integration using JFrog CLI, please refer to [Building npm Packages](https://www.jfrog.com/confluence/display/CLI/CLI+for+JFrog+Artifactory#CLIforJFrogArtifactory-BuildingNpmPackages) in the JFrog CLI User Guide.  

## This Example
This example demonstrates how to build an npm project using JFrog CLI. The build does the following:
1. Downloads its npm depedencies from Artifactory.
2. Packs and uploads the built package to Artifactory.
3. Records and publishes build-info to Artifactory.

# Prerequisite
1. Make sure your local machine has *npm* version 5.4.0 or above installed and that *npm* is included in the PATH. To verify this, run ```npm -v```.
2. Make sure your local machine has [JFrog CLI](https://jfrog.com/getcli/) version 1.13.1 or above installed and that *jfrog* is included in the PATH. To verify this, run ```jfrog -v```.
2. Make sure you're using a non-OSS JFrog Artifactory with version 5.5.2 or above.

# Creating Repositories
Create the following repositories on your Artifactory instance.
1. A remote npm repository named *npm-remote*. Make sure the repository has *https://registry.npmjs.org* configured as its URL (this is the default when creating the repository).
2. A local repository named *npm-local*.
3. A virtual repository named *npm*. 
4. Include the *npm-remote* and *npm-local* repositories as part of the new *npm* virtual repository.
5. Set *npm-local* as the **Default Deployment Repository** of the new *npm* virtual repository.

# Running the Example
CD to the root project directory.
```
Configure Artifactory:
> jfrog rt c

Build the project and record the depedencies as part of the build-info.
> jfrog rt npmi npm --build-name my-npm-build --build-number 1

Add environment variables to the build-info.
> jfrog rt bce my-npm-build 1

Add git information to the build-info.
> jfrog rt bag my-npm-build 1

Pack and publish the npm package to Artifactory, while recording it as artifact in the build-info.
> jfrog rt npmp npm  --build-name my-npm-build --build-number 1

Publish the build info to Artifactory.
> jfrog rt bp my-npm-build 1
```

