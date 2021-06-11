[Travis CI](https://travis-ci.org/) is currently known as the most prevalent cloud CI service. Although it does not have an official support for Common Lisp, roswell almost eliminates the otherwise huge amount of effort for testing your Common Lisp product.

[Circle CI](https://circleci.com) is another cloud CI service supported by roswell. It supports newer Ubuntu package and the tests runs generally faster than in Travis-CI.

[Coveralls](https://coveralls.io) is a web service used for recording the code coverage. Roswell works together with 
[cl-coveralls](https://github.com/fukamachi/cl-coveralls), a library which measure and post the code coverage results to Coveralls. Note that it runs only when `$COVERALLS` is set to true.

Read the corresponding pages for a detailed description of how to use each service.

## Using a fork of Roswell (for developers)

To choose where to get the source code of Roswell, configure these environment variables in `.travis.yml`.

- `ROSWELL_REPO`: Roswell repository to install. The default is `https://github.com/roswell/roswell`.
- `ROSWELL_BRANCH` Roswell branch or tag name to install. The default is `release`. (ex. `v0.0.3.41`)
