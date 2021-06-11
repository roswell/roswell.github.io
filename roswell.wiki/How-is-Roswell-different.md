*You might have already noticed that there are bunch of "command
line interface" libraries for Common Lisp. What's the difference!?*

Below is a brief comparison of different libraries. The evaluation
thoroughly depends on my (Masataro Asai aka guicho271828) personal taste
and not subject to rigorous tests, however I hope it would give you a grasp of the relationship / dominance between these libraries.

<!-- Obscure feature is almost equivalent to be nonexistent. -- a bit too strong, since other people may know of those features. -->

See also: [State of the Common Lisp Ecosystem, 2015](http://borretti.me/article/common-lisp-sotu-2015)

| Feature                                                  | Roswell | CIM                            | cl-launch             | buildapp   |
|----------------------------------------------------------|---------|--------------------------------|-----------------------|------------|
| --- **Implementation Management**                          |         |                                |                       |            |
| Launching a script with different lisp impls             | ✔       | ✔                              | ✔                     | ⚠         |
| Managing (install, switch) lisp impls                    | ✔       | ✔                              |                       |            |
| Managing (install, switch) lisp impls+versions           | ✔       | ✔                              |                       |            |
| --- **Supported Impl**                                     |         |                                |                       |            |
| sbcl                                                     | ✔       | ✔                              | ✔                     | ✔          |
| ccl                                                      | ✔       | ✔                              | ✔                     | ✔          |
| ecl                                                      | ✔       | ✔                              | ✔                     |            |
| clisp                                                    | ✔       | ✔                              | ✔                     |            |
| lispworks                                                |         |                                | ✔                     |            |
| abcl                                                     | ✔       | ✔                              | ✔2                    |            |
| cmucl                                                    | ✔       | ✔                              | ✔                     |            |
| alisp (allegro)                                          | ✔       | ✔                              | ✔1                    |            |
| gcl (obsoleted, not ANSI anyway)                         |         |                                | ✔1 (ANSI mode)        |            |
| scienner (who cares?)                                    |         |                                | ✔1                    |            |
| xcl (seems dead: last update 2010 Oct)                   |         |                                | ✔2                    |            |
| --- **Scripting**                                          |         |                                |                       |            |
| Script templates                                         | ✔       |                                |                       |            |
| Managing several script templates                        | ✔       |                                |                       |            |
| Managing scripts                                         | ✔       |                                |                       |            |
| Bundling/installing a script to/from a quicklisp library | ✔       |                                |                       |            |
| Shell integration (e.g. bash completion)                 | ✔       | ✔                              |                       |            |
| --- **Dumping**                                            |         |                                |                       |            |
| Dump feature                                             | ✔       |                                | ✔                     | ✔          |
| Managing dumped images                                   | ✔       |                                |                       |            |
| --- **CI integration**                                     |         |                                |                       |            |
| Local installation (no sudo)                             | ✔       |                                |                       |            |
| Helper scripts                                           | ✔       | ⚠ (via cl-travis)             |                       |            |
| --- **Quality**                                            |         |                                |                       |            |
| Documentation                                            | ✔ organized manpage | ✔ organized man page           | ⚠ Overlength manual @ [--help / cliki](http://www.cliki.net/cl-launch)     | ✔ [web page](http://www.xach.com/lisp/buildapp/) |
| Code Quality                                             | clean?  | "sh circus" (シェル芸) (keens) | ["Hard to Hack"](https://gitlab.common-lisp.net/xcvb/cl-launch/blob/master/89INTERNALS#L9) (fare) | clean?     |
| CI-Tested                                                | ✔       |                                |                       |            |
| --- **Others**                                             |         |                                |                       |            |
| Windows support                                          | ✔       |                                |                       |            |
| Easy Upgrade                                             |         | ✔ cim get                      |                       |            |
| Practical Use Case (reputation)                          | good    | mainly on CI?                  | fair?                 | good       |
| Implemented in                                           | C+lisp  | sh+lisp                        | sh+lisp               | lisp       |

Re: Shelly, the author (Fukamachi) declared (to be precise, "I think I heard him saying") it as deprecated and "dead" by himself.


