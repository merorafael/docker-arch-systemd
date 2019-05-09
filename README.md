# Arch Linux with systemd

This image uses [Arch Linux](https://www.archlinux.org/) with systemd support.
**You need to run in privileged mode.**

## Example
```
$ docker run --privileged -ti -v /sys/fs/cgroup:/sys/fs/cgroup:ro merorafael/arch-systemd
```
