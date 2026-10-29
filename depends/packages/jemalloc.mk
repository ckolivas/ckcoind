package=jemalloc
$(package)_version=5.3.0
$(package)_download_path=https://github.com/jemalloc/jemalloc/releases/download/$($(package)_version)/
$(package)_file_name=$(package)-$($(package)_version).tar.bz2
$(package)_sha256_hash=2db82d1e7119df3e71b7640219b6dfe84789bc0537983c3b7ac4f7189aecfeaa

define $(package)_set_vars
  $(package)_config_opts := --disable-shared --enable-static
  # jemalloc uses GNU C extensions (asm in the configure-time CPUID probe),
  # so override the depends-wide -std=c11.
  $(package)_cflags += -std=gnu11
endef

define $(package)_config_cmds
  $($(package)_autoconf)
endef

define $(package)_build_cmds
  $(MAKE) build_lib_static
endef

define $(package)_stage_cmds
  $(MAKE) DESTDIR=$($(package)_staging_dir) install_lib_static install_include install_lib_pc
endef
