#!/bin/bash

# 修改默认IP
sed -i 's/192.168.1.1/11.1.1.1/g' package/base-files/files/bin/config_generate
# 禁用ipv6
sed -i "/ip6assign='60'/d" package/base-files/files/bin/config_generate

# 更改默认 Shell 为 zsh
# sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

# TTYD 自动登录
sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/files/ttyd.config

# 移除要替换的包
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/net/msd_lite
rm -rf feeds/packages/net/smartdns
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/luci/applications/luci-app-netdata

# kenzok8依赖清除，防止冲突
rm -rf feeds/packages/net/{xray*,v2ray*,v2ray*,sing*,passwall*,smartdns}



# ------------------------Alan的插件-----------------------------1.仓库根目录用 git clone           
# ---------------------------------------------------------------2.多目录指定或要进下级目录 用 svn export
# ---------------------------------------------------------------3.依赖包用echo指定到feeds，会自动安装依赖，clone 或者 svn export 指定luci插件
# 腾讯云DDNS
git clone --depth=1 https://github.com/Alan-tantcw/luci-app-tencentddns package/luci-app-tencentddns
# ipsec插件
svn export https://github.com/Lienol/openwrt-package/trunk/luci-app-ipsec-server package/luci-app-ipsec-server
# softEther (不启用)
svn export https://github.com/Lienol/openwrt-package/trunk/luci-app-softethervpn package/luci-app-softethervpn
# 引用其他源-----------------------------------------------luci-app-passwall-----------------------------------------------
# 科学上网插件
# git clone --depth=1 -b main https://github.com/fw876/helloworld package/luci-app-ssr-plus
# git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall
# git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall package/luci-app-passwall
# git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2 package/luci-app-passwall2
# git_sparse_clone master https://github.com/vernesong/OpenClash luci-app-openclash
svn export https://github.com/NueXini/NueXini_Packages/trunk/luci-app-passwall package/luci-app-passwall
svn export https://github.com/NueXini/NueXini_Packages/trunk/hysteria package/hysteria
svn export https://github.com/NueXini/NueXini_Packages/trunk/NaiveProxy package/NaiveProxy
svn export https://github.com/NueXini/NueXini_Packages/trunk/shadowsocks-rust package/shadowsocks-rust
svn export https://github.com/NueXini/NueXini_Packages/trunk/shadowsocksr-libev package/shadowsocksr-libev
svn export https://github.com/NueXini/NueXini_Packages/trunk/trojan package/trojan
svn export https://github.com/NueXini/NueXini_Packages/trunk/tuic-client package/tuic-client
svn export https://github.com/NueXini/NueXini_Packages/trunk/v2ray-geodata package/v2ray-geodata
svn export https://github.com/NueXini/NueXini_Packages/trunk/v2raya package/v2raya
svn export https://github.com/NueXini/NueXini_Packages/trunk/v2ray-plugin package/v2ray-plugin
svn export https://github.com/NueXini/NueXini_Packages/trunk/xray-core package/xray-core
svn export https://github.com/NueXini/NueXini_Packages/trunk/xray-plugin package/xray-plugin
svn export https://github.com/NueXini/NueXini_Packages/trunk/chinadns-ng package/chinadns-ng
svn export https://github.com/NueXini/NueXini_Packages/trunk/luci-app-haproxy-tcp package/luci-app-haproxy-tcp
svn export https://github.com/NueXini/NueXini_Packages/trunk/naiveproxy package/naiveproxy
svn export https://github.com/NueXini/NueXini_Packages/trunk/pdnsd-alt package/pdnsd-alt
svn export https://github.com/NueXini/NueXini_Packages/trunk/simple-obfs package/simple-obfs

# 添加额外插件
git clone --depth=1 https://github.com/kongfl888/luci-app-adguardhome package/luci-app-adguardhome
# git clone --depth=1 https://github.com/Jason6111/luci-app-netdata package/luci-app-netdata
# svn export https://github.com/syb999/openwrt-19.07.1/trunk/package/network/services/msd_lite package/msd_lite


# Themes
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon

# 更改 Argon 主题背景
cp -f $GITHUB_WORKSPACE/images/bg1.jpg package/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg

# SmartDNS
git clone --depth=1 -b lede https://github.com/pymumu/luci-app-smartdns package/luci-app-smartdns
git clone --depth=1 https://github.com/pymumu/openwrt-smartdns package/smartdns

# msd_lite
git clone --depth=1 https://github.com/ximiTech/luci-app-msd_lite package/luci-app-msd_lite
git clone --depth=1 https://github.com/ximiTech/msd_lite package/msd_lite

# MosDNS
svn export https://github.com/sbwml/luci-app-mosdns/trunk/luci-app-mosdns package/luci-app-mosdns
svn export https://github.com/sbwml/luci-app-mosdns/trunk/mosdns package/mosdns

# Alist
git clone --depth=1 https://github.com/sbwml/luci-app-alist package/luci-app-alist

# iStore
git_sparse_clone main https://github.com/linkease/istore-ui app-store-ui
git_sparse_clone main https://github.com/linkease/istore luci

# 在线用户
svn export https://github.com/haiibo/packages/trunk/luci-app-onliner package/luci-app-onliner
sed -i '$i uci set nlbwmon.@nlbwmon[0].refresh_interval=2s' package/lean/default-settings/files/zzz-default-settings
sed -i '$i uci commit nlbwmon' package/lean/default-settings/files/zzz-default-settings
chmod 755 package/luci-app-onliner/root/usr/share/onliner/setnlbw.sh

# x86 型号只显示 CPU 型号
sed -i 's/${g}.*/${a}${b}${c}${d}${e}${f}${hydrid}/g' package/lean/autocore/files/x86/autocore

# 修改本地时间格式
sed -i 's/os.date()/os.date("%a %Y-%m-%d %H:%M:%S")/g' package/lean/autocore/files/*/index.htm

# 修改版本为编译日期
date_version=$(date +"%y.%m.%d")
orig_version=$(cat "package/lean/default-settings/files/zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
sed -i "s/${orig_version}/R${date_version} by Alan.Tan/g" package/lean/default-settings/files/zzz-default-settings

# 修复 hostapd 报错
cp -f $GITHUB_WORKSPACE/scripts/011-fix-mbo-modules-build.patch package/network/services/hostapd/patches/011-fix-mbo-modules-build.patch

# 修改 Makefile
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/..\/..\/luci.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/..\/..\/lang\/golang\/golang-package.mk/$(TOPDIR)\/feeds\/packages\/lang\/golang\/golang-package.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=@GHREPO/PKG_SOURCE_URL:=https:\/\/github.com/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=@GHCODELOAD/PKG_SOURCE_URL:=https:\/\/codeload.github.com/g' {}

# 取消主题默认设置
find package/luci-theme-*/* -type f -name '*luci-theme-*' -print -exec sed -i '/set luci.main.mediaurlbase/d' {} \;

# 调整 Docker 到 服务 菜单
sed -i 's/"admin"/"admin", "services"/g' feeds/luci/applications/luci-app-dockerman/luasrc/controller/*.lua
sed -i 's/"admin"/"admin", "services"/g; s/admin\//admin\/services\//g' feeds/luci/applications/luci-app-dockerman/luasrc/model/cbi/dockerman/*.lua
sed -i 's/admin\//admin\/services\//g' feeds/luci/applications/luci-app-dockerman/luasrc/view/dockerman/*.htm
sed -i 's|admin\\|admin\\/services\\|g' feeds/luci/applications/luci-app-dockerman/luasrc/view/dockerman/container.htm

# 调整 ZeroTier 到 服务 菜单
# sed -i 's/vpn/services/g; s/VPN/Services/g' feeds/luci/applications/luci-app-zerotier/luasrc/controller/zerotier.lua
# sed -i 's/vpn/services/g' feeds/luci/applications/luci-app-zerotier/luasrc/view/zerotier/zerotier_status.htm

# 取消对 samba4 的菜单调整
# sed -i '/samba4/s/^/#/' package/lean/default-settings/files/zzz-default-settings

./scripts/feeds update -a
./scripts/feeds install -a
