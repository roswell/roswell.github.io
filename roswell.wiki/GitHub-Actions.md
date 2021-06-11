[GitHub Actions](https://github.com/features/actions) is an automation service from GitHub. Its notable advantages are seamless GitHub integration and better OS support -- Ubuntu, macOS and Windows.

It's still in limited public beta and the API is likely to change. We're working on to improve its experience with Roswell, but please remember it is still quite experimental.

## Getting Started

Add a workflow YAML file at `.github/workflows/ci.yml` something like this:

```yaml
name: CI

on: [push]

jobs:
  test:
    name: ${{ matrix.lisp }} on ${{ matrix.os }}
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        lisp: [sbcl-bin]
        os: [ubuntu-latest, macOS-latest]

    steps:
      - uses: actions/checkout@v1
      - name: Install Roswell
        env:
          LISP: ${{ matrix.lisp }}
        run: |
          curl -L https://raw.githubusercontent.com/roswell/roswell/master/scripts/install-for-ci.sh | sh
      - name: Install Rove
        run: ros install rove
      - name: Run tests
        run: |
          PATH="~/.roswell/bin:$PATH"
          rove qlot.asd
```

## Known issues

* The latest `install-for-ci.sh` is required until [158bdeb6](https://github.com/roswell/roswell/commit/158bdeb63e0238b80a8e2cad7e9fd33011b732f3) will have been released.
* \[Windows\] `ROSWELL_INSTALL_DIR` has to be set `/c/roswell` on Windows
  * Because `/usr/local/bin` is not in PATH.
  * `/usr/bin` is in PATH, but its actual directory path is under `C:/Program Files/` and Roswell can't be executed when its pathname containing spaces.
  * Roswell exe file will be installed at `/c/roswell/bin/ros`.
* \[Windows\] Roswell scripts can't be executed with cmd.exe
  * Execute them through `ros` command like `C:\roswell\bin\ros %userprofile%\.roswell\bin\rove`
  * Use `bash` by setting `jobs.<job-id>.steps.shell` to `bash`.
* \[Windows\] ASDF configuration is not set
  * Set the source registry by yourself like `/c/roswell/bin/ros -S . -s rove -e ...`

## See Also

* [Automating your workflow with GitHub Actions - GitHub Help](https://help.github.com/en/categories/automating-your-workflow-with-github-actions) (Official document)