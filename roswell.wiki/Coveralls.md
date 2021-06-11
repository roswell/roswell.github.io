[Coveralls](https://coveralls.io) is another web service to record the code coverage, and [cl-coveralls](https://github.com/fukamachi/cl-coveralls) is a library which communicates and posts the results to the service. It works with both Travis-CI and Circle CI. Note that it runs only when `$COVERALLS` is set to true.

```diff
language: common-lisp
sudo: required

env:
  global:
    - PATH=~/.roswell/bin:$PATH
  matrix:
+    - LISP=sbcl-bin COVERALLS=true
    - LISP=ccl-bin
    - LISP=abcl
    - LISP=clisp
    - LISP=ecl

matrix:
  allow_failures:
    - env: LISP=clisp

install:
  - curl -L https://raw.githubusercontent.com/roswell/roswell/release/scripts/install-for-ci.sh | sh

script:
+  - ros -s prove -s cl-coveralls
+        -e '(or (coveralls:with-coveralls (:exclude (list "t"))
+                  (prove:run :quri-test))
+                (uiop:quit -1))'
```

`run-prove` command has a special support for it:

```diff
language: common-lisp
sudo: required

env:
  global:
    - PATH=~/.roswell/bin:$PATH
+    - COVERAGE_EXCLUDE=t/
  matrix:
    - LISP=sbcl-bin COVERALLS=true
    - LISP=ccl-bin
    - LISP=abcl
    - LISP=clisp
    - LISP=ecl

matrix:
  allow_failures:
    - env: LISP=clisp

install:
  - curl -L https://raw.githubusercontent.com/roswell/roswell/release/scripts/install-for-ci.sh | sh

script:
+  - run-prove quri-test.asd
```
