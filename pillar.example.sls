aptcacherng:
  configs:
    acng.conf:
      content: |
        # This file managed by Salt, do not edit by hand!
        CacheDir: /data/cache/apt-cacher-ng
        LogDir: /var/log/apt-cacher-ng
        Port:3142
        Remap-debrep: file:deb_mirror*.gz /debian ; file:backends_debian # Debian Archives
        Remap-uburep: file:ubuntu_mirrors /ubuntu ; file:backends_ubuntu # Ubuntu Archives
        Remap-debvol: file:debvol_mirror*.gz /debian-volatile ; file:backends_debvol # Debian Volatile Archives
        ReportPage: acng-report.html
        AdminAuth: admin:{{ current.aptcacher.pass }}
        ExTreshold: 4
    backends_ubuntu:
      content: |
        http://mirror.switch.ch/ftp/mirror/ubuntu/
        http://ubuntu.fastbull.org/ubuntu/
        ftp://ftp.uni-stuttgart.de/ubuntu/
        http://ftp.halifax.rwth-aachen.de/ubuntu/
        http://ftp.uni-kl.de/pub/linux/ubuntu/
        http://mirror.netcologne.de/ubuntu/
        http://vesta.informatik.rwth-aachen.de/ftp/pub/Linux/ubuntu/ubuntu/
        ftp://ftp.belnet.be/mirror/ubuntu.com/ubuntu/
        http://ubuntu.supp.name/ubuntu/
        http://de.archive.ubuntu.com/ubuntu/
    backends_debian:
      content: |
        http://ftp.debian.org/debian/
    backends_debvol:
      content: |
        http://ftp.halifax.rwth-aachen.de/debian-volatile/
        http://ftp.uni-kl.de/debian-volatile/
        http://debian.inode.at/debian-volatile/
