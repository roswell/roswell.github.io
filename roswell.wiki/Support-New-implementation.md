
# support ``run`` subcommand


## preparation

### decide impl name
list of supported can be seen on [src/cmd-run.c](https://github.com/roswell/roswell/blob/1ccd22a7377deea9c4532ac989681b7a692ed30b/src/cmd-run.c#L6-L23)

this time ``mkcl``

### add to system
edit ``src/cmd-run.c`` ``src/cmd-run.h`` 

```
diff --git a/src/cmd-run.c b/src/cmd-run.c
index ab5f8ee..f23bffa 100644
--- a/src/cmd-run.c
+++ b/src/cmd-run.c
@@ -20,6 +20,7 @@ struct run_impl_t impls_to_run[]={
   {"acl",&cmd_run_acl},
   {"alisp",&cmd_run_acl},
   {"allegro",&cmd_run_acl},
+  {"mkcl",&cmd_run_mkcl},
 };
 
 struct proc_opt run;
diff --git a/src/cmd-run.h b/src/cmd-run.h
index 9808b58..6ffeef7 100644
--- a/src/cmd-run.h
+++ b/src/cmd-run.h
@@ -22,6 +22,7 @@ extern char** cmd_run_ecl(int argc,char** argv,struct sub_command* cmd);
 extern char** cmd_run_abcl(int argc,char** argv,struct sub_command* cmd);
 extern char** cmd_run_cmu(int argc,char** argv,struct sub_command* cmd);
 extern char** cmd_run_acl(int argc,char** argv,struct sub_command* cmd);
+extern char** cmd_run_mkcl(int argc,char** argv,struct sub_command* cmd);
 extern LVal register_runtime_options();
 int setup(char* target,char* env);
 #define SETUP_SYSTEM(sys,msg) {\
```

copy ``src/cmd-run-sbcl.c`` to ``src/cmd-run-mkcl.c``

edit ``Makefile.am``
```
diff --git a/src/Makefile.am b/src/Makefile.am
index 534e4a2..fbae016 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -14,7 +14,7 @@ ros_SOURCES = ros.c opt.c download.c download_windows.c archive.c archive_window
        register-commands.c html.c html-sbcl-bin.c \
        $(ros_utils) \
        cmd-internal.c cmd-script.c \
-       cmd-run.c cmd-run-sbcl.c cmd-run-ccl.c cmd-run-clasp.c cmd-run-clisp.c cmd-run-ecl.c cmd-run-abcl.c cmd-run-cmu.c cmd-run-acl.c \
+       cmd-run.c cmd-run-sbcl.c cmd-run-ccl.c cmd-run-clasp.c cmd-run-clisp.c cmd-run-ecl.c cmd-run-abcl.c cmd-run-cmu.c cmd-run-acl.c cmd-run-mkcl.c \
        cmd-install.c install-sbcl-bin.c install-sbcl-bin_windows.c
 
 if WITH_WIN_ICON
```

edit ``src/cmd-run-mkcl.c``

```
--- cmd-run-sbcl.c	2018-01-22 00:37:32.961614871 +0900
+++ cmd-run-mkcl.c	2018-02-27 18:29:13.276712741 +0900
@@ -1,7 +1,7 @@
 /* -*- tab-width : 2 -*- */
 #include "cmd-run.h"
 
-char** cmd_run_sbcl(int argc,char** argv,struct sub_command* cmd) {
+char** cmd_run_mkcl(int argc,char** argv,struct sub_command* cmd) {
   char* home=configdir();
   char* arch=uname_m();
   char* os=uname();
```
### test build
[[https://github.com/roswell/roswell/wiki/Installation#building-from-source]](FYI)

test no error occure with build.

## install mkcl to try.

[tbd]

### check mkcl command lines 

# support ``install`` subcommand

tbd
