#
# Copyright (C) 2006-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=snapcast
PKG_VERSION:=0.17.1
PKG_RELEASE:=1

PKG_SOURCE_URL:=https://github.com/badaix/snapcast.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=7a585267368e6da620a0bbfd5b2bd956ee1c57d8	# GIT commit hash

PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

# Default entry in menu
define Package/snapcast/Default
	SECTION := multimedia
	CATEGORY := Multimedia
	TITLE := snapcast
	DEPENDS := +libstdcpp +libavahi-client +libatomic +libogg +libflac +boost +libopus +libvorbis
endef

define Package/snapcast/description/Default
	Synchronous audio player
endef

define Package/snapcast
	$(call Package/snapcast/Default)
	TITLE += packages
endef

define Package/snapcast/description
	$(call Package/snapcast/description/Default)
	Multi-room client-server audio player
	Include Server and Client
endef


# Snapserver entry as submenu
define Package/snapserver
	$(call Package/snapcast/Default)
	TITLE += snapserver
	HIDDEN := 1
endef

define Package/snapserver/description
	$(call Package/snapcast/description/Default)
	Snapcast server
endef


# Snapclient entry as submenu
define Package/snapclient
	$(call Package/snapcast/Default)
	TILE += snapclient
	DEPENDS += +alsa-lib +libvorbisidec
	HIDDEN := 1
endef

define Package/snapclient/description
	$(call Package/snapcast/description/Default)
	Snapcast client
endef


# Menu to choose options in package snapcast
define Package/snapcast/config
 	menu "Select snapcast options"
		depends on PACKAGE_snapcast
		comment "Choose server or client to compile"
		config PACKAGE_snapserver
			prompt "Compile snapserver"
			help
				Compile Snapcast server
			default n

		config PACKAGE_snapclient
			prompt "Compile snapclient"
			help
				Compile Snapcast client
			default n
	endmenu
endef


# Copy needed parts of downloaded file into build_dir
define Build/Prepare
	$(call Build/Prepare/Default)
	# copy package config file for tremor, 
	# as this is not done by the original package and snapcast relies on it
	$(INSTALL_DIR) $(STAGING_DIR)/usr/lib/pkgconfig/
	$(INSTALL_DATA) ./files/vorbisidec.pc $(STAGING_DIR)/usr/lib/pkgconfig/	
endef


define Package/snapcast/Default/install
#	true
endef


define Package/snapserver/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/server/snapserver $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/snapserver.init $(1)/etc/init.d/snapserver
	# The default file of the current version did not work for me, because of missing autostart
	$(INSTALL_DIR) $(1)/etc/default
	$(INSTALL_BIN) ./files/snapserver.default $(1)/etc/default/snapserver
	# Set snapserver to enabled
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/set-snapserver-enabled.sh $(1)/etc/uci-defaults/set-snapserver-enabled.sh
endef


define Package/snapclient/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/client/snapclient $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/snapclient.init $(1)/etc/init.d/snapclient
	# The default file of the current version did not work for me, because of missing autostart
	$(INSTALL_DIR) $(1)/etc/default
	$(INSTALL_BIN) ./files/snapclient.default $(1)/etc/default/snapclient
	# Set snapclient to enabled
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/set-snapclient-enabled.sh $(1)/etc/uci-defaults/set-snapclient-enabled.sh
endef


$(eval $(call BuildPackage,snapserver))
$(eval $(call BuildPackage,snapclient))
$(eval $(call BuildPackage,snapcast))

