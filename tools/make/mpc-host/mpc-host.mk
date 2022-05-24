$(call TOOLS_INIT, 1.1.0)
$(PKG)_SOURCE:=mpc-$($(PKG)_VERSION).tar.gz
$(PKG)_SOURCE_SHA1:=b019d9e1d27ec5fb99497159d43a3164995de2d0
$(PKG)_SITE:=@GNU/mpc

$(PKG)_DESTDIR:=$(HOST_TOOLS_DIR)
$(PKG)_BINARY:=$($(PKG)_DESTDIR)/lib/libmpc.a
$(PKG)_DEPENDS:=gmp-host mpfr-host

$(PKG)_CONFIGURE_ENV += CC="$(TOOLCHAIN_HOSTCC)"
$(PKG)_CONFIGURE_ENV += CFLAGS="$(TOOLCHAIN_HOST_CFLAGS)"

$(PKG)_CONFIGURE_OPTIONS += --prefix=$(MPC_HOST_DESTDIR)
$(PKG)_CONFIGURE_OPTIONS += --build=$(GNU_HOST_NAME)
$(PKG)_CONFIGURE_OPTIONS += --host=$(GNU_HOST_NAME)
$(PKG)_CONFIGURE_OPTIONS += --disable-shared
$(PKG)_CONFIGURE_OPTIONS += --enable-static
$(PKG)_CONFIGURE_OPTIONS += --with-gmp=$(GMP_HOST_DESTDIR)
$(PKG)_CONFIGURE_OPTIONS += --with-mpfr=$(MPFR_HOST_DESTDIR)


$(TOOLS_SOURCE_DOWNLOAD)
$(TOOLS_UNPACKED)
$(TOOLS_CONFIGURED_CONFIGURE)

$($(PKG)_BINARY): $($(PKG)_DIR)/.configured | $(HOST_TOOLS_DIR)
	$(TOOLS_SUBMAKE) -C $(MPC_HOST_DIR) install

$(pkg)-precompiled: $($(PKG)_BINARY)


$(pkg)-clean:
	-$(MAKE) -C $(MPC_HOST_DIR) clean

$(pkg)-dirclean:
	$(RM) -r $(MPC_HOST_DIR)

$(pkg)-distclean: $(pkg)-dirclean
	$(RM) $(MPC_HOST_DESTDIR)/lib/libmpc* $(MPC_HOST_DESTDIR)/include/*mpc*.h

$(TOOLS_FINISH)
