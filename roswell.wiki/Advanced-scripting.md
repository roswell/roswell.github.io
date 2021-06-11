
TBP

# installation hook

During the installation of the quicklisp library using `ros install [system]`, `roswell` adds `:ros.installing` to `*features*`, and also calls `ros:*build-hook*` when `ql:quickload` is complete. You can set this hook to a function with no arguments.

