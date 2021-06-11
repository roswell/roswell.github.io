CircleCI is another continuous integration framework.
It's test runs much faster than in Travis-CI, which is very convenient.
Another pros are that it supports much wider apt-packages than in Travis-CI, including newer/backported Ubuntu/Debian packages in 14.04. If you pay, it also supports concurrent builds.
Below is a sample CircleCI yaml script from [eazy-opencl](https://github.com/guicho271828/eazy-opencl) .

```yaml
machine:
  environment:
    PATH: ~/.roswell/bin:$PATH
    LLVM_CONFIG: /usr/lib/llvm-3.6/bin/llvm-config

dependencies:
  pre:
    - sudo bash -c 'echo "deb http://mirrors.kernel.org/ubuntu vivid main universe" >> /etc/apt/sources.list'
    - sudo apt-get update
    - apt-cache search pocl 
    - apt-cache search icd
    - apt-cache search opencl
    - sudo apt-get install -y libltdl3-dev libhwloc-dev ocl-icd-opencl-dev g++-4.8 clang-3.6 libclang-3.6-dev llvm-3.6-dev libedit-dev
    - ./build-pocl.sh
    - sudo make -C pocl install
    - curl -L https://raw.githubusercontent.com/roswell/roswell/master/scripts/install-for-ci.sh | sh
    - ros install ccl-bin
    - git clone https://github.com/cffi/cffi.git ~/lisp/cffi
  post:
    - ros install cffi
    - ros install cffi-grovel
    - ros install eazy-opencl
  cache_directories:
    - ~/.roswell/
    - pocl

test:
  override:
    - ros -L sbcl-bin testscr.ros
    - ros -L ccl-bin testscr.ros
```
