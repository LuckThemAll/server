SET(OPT CONC_)

IF (CMAKE_BUILD_TYPE STREQUAL "Debug")
  SET(CONC_WITH_RTC ON)
ENDIF()

SET(CONC_WITH_SIGNCODE ${SIGNCODE})
SET(SIGN_OPTIONS ${SIGNTOOL_PARAMETERS})
SET(CONC_WITH_EXTERNAL_ZLIB ON)

IF(SSL_DEFINES MATCHES "YASSL")
  IF(WIN32)
    SET(CONC_WITH_SSL "SCHANNEL")
  ELSE()
    SET(CONC_WITH_SSL "GNUTLS") # that's what debian wants, right?
  ENDIF()
ELSE()
  SET(CONC_WITH_SSL "OPENSSL")
  SET(OPENSSL_FOUND TRUE)
ENDIF()

SET(CONC_WITH_CURL OFF)
SET(CONC_WITH_MYSQLCOMPAT ON)

IF (INSTALL_LAYOUT STREQUAL "RPM")
  SET(CONC_INSTALL_LAYOUT "RPM")
ELSE()
  SET(CONC_INSTALL_LAYOUT "DEFAULT")
ENDIF()

SET(PLUGIN_INSTALL_DIR ${INSTALL_PLUGINDIR})
SET(MARIADB_UNIX_ADDR ${MYSQL_UNIX_ADDR})

SET(CLIENT_PLUGIN_PVIO_NPIPE STATIC)
SET(CLIENT_PLUGIN_PVIO_SHMEM STATIC)
SET(CLIENT_PLUGIN_PVIO_SOCKET STATIC)

MESSAGE("== Configuring MariaDB Connector/C")
ADD_SUBDIRECTORY(libmariadb)

#remove after merging libmariadb > v3.0.9
IF(TARGET caching_sha2_password AND CMAKE_C_FLAGS_DEBUG MATCHES "-Werror")
  TARGET_COMPILE_OPTIONS(caching_sha2_password PRIVATE -Wno-error=unused-function)
ENDIF()
