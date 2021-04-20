
- npm sha512

        2017 - Npm changes to use sha512 checksum - https://blog.npmjs.org/post/161081169345/v500

- so why sha1 -> sha512?

        - why not sha1

                https://github.com/npm/npm/issues/4938
                https://thehackernews.com/2017/02/sha1-collision-attack.html

        - Hash collision attacks

                Digests are only as strong as the hash function used to generate them. It is recommended that user agents refuse to support known-weak hashing functions and limit supported algorithms to those known to be collision resistant. Examples of hashing functions that are not recommended include MD5 and SHA-1. At the time of writing, SHA-384 is a good baseline.

- what is art using?

        1. art can use sha256 for storage path? sha256 is enough?

                need special configuration?

        2. any chance for art npm repo to have corrupted pkg stored?

                e.g. network shake
                how does art npm repo check work now?

- how is integrity field used to work?

        - guide
                
                https://w3c.github.io/webappsec-subresource-integrity/
                integrity = shaxxx-base64(shaxxx(content))

        - sha512 / sha1 in pkg metadata
        
                check dist field in below response
                integrity -> sha512
                shasum -> sha1

                - npmjs
                https://registry.npmjs.com/d3-selection/1.4.0

                - art -> npmjs
                http://182.92.214.141:8081/artifactory/api/npm/npm-remote/d3-selection/1.4.0

                - taobao
                https://registry.npm.taobao.org/d3-selection/1.4.0

                - art -> taobao
                http://182.92.214.141:8081/artifactory/api/npm/npm/d3-selection/1.4.0

        - npm install, verify order = sha512 -> sha1

                https://npm.community/t/support-q-how-does-npm-generate-the-shasum-for-a-publish-npm-package/1119

        - integrity recorded in package-lock.json

                - guide
                https://docs.npmjs.com/cli/v6/configuring-npm/package-lock-json#integrity

                - if npm install from npmjs.org directly
                "integrity": "sha512-EYVwBxQGEjLCKF2pJ4+yrErskDnz5v403qvAid96cNdCMr8rmCYfY5RGzWz24mdIbxmDf6/4EAH+K9xperD5jg=="

                - if npm install from art proxying any npm registry
                "integrity": "sha1-q5rB5mTPln6/G0ecwH4ozpkIxHQ="

        - get integrity of a file
       
                cat d3-selection-1.4.0.tgz | openssl dgst -sha512 -binary | openssl base64 -A
                EYVwBxQGEjLCKF2pJ4+yrErskDnz5v403qvAid96cNdCMr8rmCYfY5RGzWz24mdIbxmDf6/4EAH+K9xperD5jg==

        - get hash only
        
                - sha512
                cat d3-selection-1.4.0.tgz | openssl dgst -sha512

                1185700714061232c2285da9278fb2ac4aec9039f3e6fe34deabc089df7a70d74232bf2b98261f639446cd6cf6e267486f19837faff81001fe2bdc697ab0f98e

                - sha1
                cat d3-selection-1.4.0.tgz | openssl dgst -sha1
                ab9ac1e664cf967ebf1b479cc07e28ce9908c474

        - get real file location of npm cache by hash
              
                - sha512
                /Users/kyle/.npm/_cacache/content-v2/sha512/11/85/700714061232c2285da9278fb2ac4aec9039f3e6fe34deabc089df7a70d74232bf2b98261f639446cd6cf6e267486f19837faff81001fe2bdc697ab0f98e

                ...


