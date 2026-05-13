#!/bin/sh
set -eu

arch="${1:-}"
page_url="${2:-https://linux.weixin.qq.com/}"

if [ -z "$arch" ]; then
    arch="$(dpkg --print-architecture)"
fi

case "$arch" in
    amd64|x86_64)
        package_arch="x86_64"
        ;;
    arm64|aarch64)
        package_arch="arm64"
        ;;
    *)
        echo "Unsupported architecture: $arch" >&2
        exit 1
        ;;
esac

html="$(curl --silent --show-error --fail --location --retry 5 --retry-delay 10 --retry-all-errors --connect-timeout 30 "$page_url")"
url="$(printf '%s\n' "$html" | tr '"' '\n' | grep -E "^https://.*WeChatLinux_${package_arch}[.]deb$" | head -n 1 || true)"

if [ -z "$url" ]; then
    echo "Could not find WeChatLinux_${package_arch}.deb on $page_url" >&2
    exit 1
fi

printf '%s\n' "$url"
