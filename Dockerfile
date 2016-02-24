FROM base/archlinux:latest
MAINTAINER Rafael Mello <merorafael@gmail.com>
ENV container docker

# Arch settings
COPY etc/locale.gen /etc/
COPY etc/pacman.d/mirrorlist /etc/pacman.d/

# Update Arch
RUN pacman --noconfirm -Sy archlinux-keyring
RUN pacman --noconfirm -Sy \
        pacman \
        pacman-mirrorlist \
    && rm -rf /etc/pacman.d/mirrorlist.pacnew \
    && pacman-db-upgrade \
    && pacman --noconfirm -Syu

# Clean services
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/sbin/init"]