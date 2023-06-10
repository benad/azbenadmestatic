---toml
date = "2018-07-17T20:55:00-04:00"
title = "Python 3.7 on CentOS 6"
permalink = "blog/2018/07/17/python-3.7-on-centos-6/"
---

The latest [Python 3.7](https://www.python.org/downloads/release/python-370/) at last upped its version requirement for OpenSSL, though it sadly means that out of the box it cannot use the version of OpenSSL available with (the now rather old) CentOS 6. Sure, you *can* set up Python 3.7 without the `ssl` module, but you won’t be able to install anything with `pip` since HTTPS is required for downloading modules.

Here’s what I did. This is from a minimal install of CentOS 6.10, though it should work with older versions of CentOS 6. For my setup, I installed OpenSSL 1.1.0h under `/usr/local/openssl11` and Python 3.7.0 under `/usr/local/python37`. The trick is to use the `rpath` option for the linker (in GCC, that means `-Wl,rpath=...`) to point to the custom location of OpenSSL, otherwise you’d have to set `LD_LIBRARY_PATH` each time. Also, there are a bunch of `*-devel` packages that are needed for Python’s optional modules.

```
# yum install -y xz
# yum groupinstall -y 'Development Tools'
# curl -LO 'https://www.openssl.org/source/openssl-1.1.0h.tar.gz'
# tar -xf openssl-1.1.0h.tar.gz
# cd openssl-1.1.0h
# ./config shared --prefix=/usr/local/openssl11 --openssldir=/usr/local/openssl11 && make && make install
# cd ..
# curl -LO 'https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tar.xz'
# tar -xf Python-3.7.0.tar.xz
# cd Python-3.7.0
In Modules/Setup.dist, edit the following, making sure you remove the leading pound characters:
SSL=/usr/local/openssl11
_ssl _ssl.c \
        -DUSE_SSL -I$(SSL)/include -I$(SSL)/include/openssl \
        -L$(SSL)/lib -lssl -lcrypto
# yum install -y libffi-devel bzip2-devel ncurses-devel gdbm-devel xz-devel sqlite-devel readline-devel zlib-devel libuuid-devel
# LDFLAGS="-Wl,-rpath=/usr/local/openssl11/lib" ./configure --prefix=/usr/local/python37 --with-openssl=/usr/local/openssl11 --with-system-ffi && make && make install
# ln -s /usr/local/python37/bin/*3.7* /usr/local/bin
```

