FROM archlinux/base:latest
LABEL MAINTAINER="Rafael Mello <merorafael@gmail.com>, pan93412 <pan93412@gmail.com>"

# Arguments
ARG locale="pt_BR.UTF-8 UTF-8"
ARG mirrorCountry="Brazil"

# Arch settings
RUN echo -ne "\n$locale\n" >> /etc/locale.gen
RUN locale-gen

# Update Arch & Set up mirrors.
RUN pacman -Sy --noconfirm reflector
RUN reflector -c $mirrorCountry --sort age --sort rate --threads 100 --save /etc/pacman.d/mirrorlist
RUN pacman --noconfirm -S archlinux-keyring
RUN pacman --noconfirm -Su

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
