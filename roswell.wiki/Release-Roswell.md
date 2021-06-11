# What for this document?
Intend to share way to release Roswell at the end of 2017.
# When to release?
more than once in a month(it doesn't mean the days between release less than 31 days. if a release done 1st day of a month the next release could associated the last day of the next month.)
For release decision, check CI result ... (must be green?)

# Who'll release.
Anyone who have access right to Roswell repository.

# How

1. prepare Changelog

```
make release-changelog
```

2. edit Changelog

with seeing [commit log](https://github.com/roswell/roswell/commits/master).

3. decide new version

```
make release-prepare
```

version asked. just press enter.


4. release

```
make release-commit
```

5. push.

```
make release-push
```

then type push commands which are shown.

```

```