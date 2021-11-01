#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.99.1/g' package/base-files/files/bin/config_generate

#添加Lean的luci

#svn co --force https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-arpbind package/luci-app-arpbind && svn revert -R package/luci-app-arpbind
#svn co --force https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-autoreboot package/luci-app-autoreboot && svn revert -R package/luci-app-autoreboot
#svn co --force https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-filetransfer package/luci-app-filetransfer && svn revert -R package/luci-app-filetransfer
#svn co --force https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-frpc package/luci-app-frpc && svn revert -R package/luci-app-frpc
#svn co --force https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-ipsec-vpnd package/luci-app-arpbind && svn revert -R package/luci-app-ipsec-vpnd
#svn co --force https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-turboacc package/luci-app-turboacc && svn revert -R package/luci-app-turboacc
#svn co --force https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-vlmcsd package/luci-app-vlmcsd && svn revert -R package/luci-app-vlmcsd
#svn co --force https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-webadmin package/luci-app-webadmin && svn revert -R package/luci-app-webadmin

#passwall-package 
git clone https://github.com/xiaorouji/openwrt-passwall.git  package/passwall

git clone https://github.com/Swiftfrog/openwrt-package package/frog

# add upx
mkdir -p tools/ucl && wget -P tools/ucl https://raw.githubusercontent.com/coolsnowwolf/lede/master/tools/ucl/Makefile 
mkdir -p tools/upx && wget -P tools/upx https://raw.githubusercontent.com/coolsnowwolf/lede/master/tools/upx/Makefile
sed -i '23a\tools-y += ucl upx' tools/Makefile
sed -i '/builddir dependencies/a\$(curdir)/upx/compile := $(curdir)/ucl/compile' tools/Makefile

#update golang
pushd feeds/packages/lang
rm -rf golang && svn co https://github.com/openwrt/packages/trunk/lang/golang
popd
