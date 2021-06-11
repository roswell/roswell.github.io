# Step 1 -- stop loading Quicklisp

Despite its speed, scripting in Common Lisp usually have to face its startup time.

```
$ time fact.ros 10
Factorial 10 = 3628800
fact.ros 10  0.74s user 0.21s system 95% cpu 0.994 total
```

This very simple program took 0.74s to print the answer. Considering that all Common Lispers can easily compute the factorial of 10 in less than 1 sec, it is unbearably slow.

The first easy step to reduce the startup time is to skip loading Quicklisp, as it's not necessary for this program. Replace `-Q` flag by `+Q` in the `ros` command:

```diff
#!/bin/sh
#|-*- mode:lisp -*-|#
#|
-exec ros -Q -- $0 "$@"
+exec ros +Q -- $0 "$@"
|#
```

Retry `time` command to see how it worked:

```diff
$ time fact.ros 10
Factorial 10 = 3628800
-fact.ros 10  0.74s user 0.21s system 95% cpu 0.994 total
+fact.ros 10  0.57s user 0.19s system 97% cpu 0.780 total
```

It's mildly better.

# Step 2 -- Making Executables (dump)

Roswell also provides a command to convert a script into an executable, `ros build`:

```
$ ros build fact.ros
[undoing binding stack and other enclosing state... done]
[saving current Lisp image into fact:
writing 4976 bytes from the read-only space at 0x20000000
writing 3168 bytes from the static space at 0x20100000
writing 52330496 bytes from the dynamic space at 0x1000000000
done]
```

It generates an executable named as `fact`. If your script doesn't have a file extension `.ros`, Roswell overrides your file and the behaviour is unknown.

Try `time` for the executable:

```diff
$ time fact 10
Factorial 10 = 3628800
-fact.ros 10  0.57s user 0.19s system 97% cpu 0.780 total
+fact 10  0.00s user 0.02s system 96% cpu 0.024 total
```

Well, is it fast enough now? :)

# Step 3 -- disable core compression

`ros build` enables core compression by default in order to significantly reduce your binary size (from about 120MB to 30MB), but this adds a non-insignificant overhead to startup times of about 150ms.

Disable core compression with `ros build --disable-compression <app.ros>`.