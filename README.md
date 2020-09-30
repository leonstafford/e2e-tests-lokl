# E2E Tests Lokl

End to end tests for Lokl environment and included software.

Used for test driven development of new features and mitigation of regressions.

## Pseudo-design / thinking out loud / roadmap 

 - [x] shell scripts
 - [x] minimal dependencies
 - [ ] HTML assertions via some [CLI tools](https://github.com/dbohdan/structured-text-tools#xml-html)
 or small custom scripts
 - [ ] auto-build latest test suite into Lokl's `test` Docker tag
 - [ ] uses the `N` and `P` env vars available within tests
 - [-] setup / teardown to reset DB and filesystem to Lokl default state
 - [ ] include test dependencies within main Lokl Docker image (reduce complexity of
 maintaining different branches)
 - [-] WP-CLI used for all WordPress control vs more costly browser automation
 - [ ] `exit 0` early (with message) to skip tests
 - [ ] entrypoint test runner with flag to abort on any non-zero exit
 - [x] tests (`filename.test.sh`) organized within nested dirs for project/feature
 - [ ] all `filename.test.sh` are standalone, can run in any order
 - [ ] if long-running test, can source additional scripts (without `.test.sh`
 in filename so as not to be run by itself)
 - [x] `shellcheck` tests the tests

## Other considerations

Lokl containers are identical, apart from:
 - the hostname (defaults to container ID)
 - env vars (we have `P` and `N` set to our containers port and name, respectively)

This allows for ease of testing within consistent environment.


## Example test

 - install all WP2Static add-ons, assert they appear in add-ons list
   - setup (as per Lokl default state, all add-ons installed and activated)
   - `wp wp2static addons list`
   - parse the output:
```
+---------+------------------------------------+-------------------------------+-----------------------------------------------------------+----------------------------------------------------------------+
| Enabled | Slug                               | Name                          | Description                                               | Docs                                                           |
+---------+------------------------------------+-------------------------------+-----------------------------------------------------------+----------------------------------------------------------------+
| 0       | wp2static-addon-s3                 | S3 Deployment                 | Deploys to S3 with optional CloudFront cache invalidation | https://wp2static.com/addons/s3/                               |
| 0       | wp2static-addon-zip                | ZIP Deployment                | Deploys to ZIP archive                                    | https://wp2static.com/addons/zip/                              |
| 0       | wp2static-addon-cloudflare-workers | Cloudflare Workers Deployment | Deploys to Cloudflare Workers                             | https://wp2static.com/addons/cloudflare-workers/               |
| 0       | wp2static-addon-advanced-crawling  | Advanced Crawling             | Provides advanced crawling options                        | https://github.com/WP2Static/wp2static-addon-advanced-crawling |
+---------+------------------------------------+-------------------------------+-----------------------------------------------------------+----------------------------------------------------------------+
```
   - assert all expected addons appear (cmd output matches test's expected output file)
   - exit 0 or 1 exit 

## Example test dirs

For the above example test, directory tree may look like:

```
    e2e-tests-lokl
    └── wp22static
        └── addons
            └── default-available
                ├── default-addons-available.test.sh
                └── output
                    └── default-addons-list.clioutput
```

## Other tests this suits

 - static generated output involving other plugins modifying output
 (ie, Autoptimize)
 - testing SSG caching mechanisms
 - testing deployed static sites on AWS, Cloudflare, etc
 - testing cloud provisioning (TBA) features of plugins
