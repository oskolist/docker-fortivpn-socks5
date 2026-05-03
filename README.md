# fortivpn-socks5-container

Connect to a Fortinet SSL-VPN via HTTP/SOCKS5 proxy.  
Fork of [Tosainu/fortivpn-socks5](https://github.com/Tosainu/docker-fortivpn-socks5) with a GitHub Actions workflow that automatically publishes a new container when a new version of [openfortivpn](https://github.com/adrienverge/openfortivpn) is available.

## Usage

NOTE: I only tested this image on Linux-based systems. It might not work on macOS.

1. Create an openfortivpn configuration file:

    ```
    $ cat /path/to/config
    host = vpn.example.com
    port = 443
    username = foo
    password = bar
    ```

These environment variables are also available:

- `PORT`: set the SOCKS5 proxy port. By default it uses `8443`.
- `SOCKET_PATH`: when set, the container will also listen on the specified Unix socket (e.g., `/run/fortivpn-to-socks/fortivpn-to-socks.sock`).

2. Run the following command to start the container:

    ```
    $ docker container run \
        --cap-add=NET_ADMIN \
        --device=/dev/ppp \
        --rm \
        -v /path/to/config:/etc/openfortivpn/config:ro \
        ghcr.io/oskolist/fortivpn-socks5-container:latest
    ```

3. Now you can use the SSL-VPN via `http://<container-ip>:8443` or `socks5://<container-ip>:8443`.

    ```
    $ http_proxy=http://172.17.0.2:8443 curl http://example.com

    $ ssh -o ProxyCommand="nc -x 172.17.0.2:8443 %h %p" foo@example.com
    ```

## License

[MIT](https://github.com/oskolist/fortivpn-socks5-container/blob/master/LICENSE)
