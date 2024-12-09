#!/bin/bash

# 修改默认IP
sed -i 's/192.168.1.1/11.1.1.1/g' package/base-files/files/bin/config_generate
# 禁用ipv6
sed -i "/ip6assign='60'/d" package/base-files/files/bin/config_generate

# 更改默认 Shell 为 zsh
# sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd



./scripts/feeds update -a
./scripts/feeds install -a
make -j4
