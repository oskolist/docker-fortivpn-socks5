#!/bin/sh
/usr/bin/glider -listen :${PORT:-8443} &
echo "http/socks5 proxy server: $(hostname -i):${PORT:-8443}"
if [ -n "${SOCKET_PATH}" ]; then
  /usr/bin/glider -listen "unix://${SOCKET_PATH},socks5://" -forward socks5://127.0.0.1:${PORT:-8443} &
fi
exec "$@"
