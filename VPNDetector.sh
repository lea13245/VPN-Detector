echo "=== CHEQUEO VPN macOS (SS) ==="

if scutil --nc list 2>/dev/null | grep -i "Connected" >/dev/null; then
  echo "[\!] VPN ACTIVA (servicio del sistema)"
else
  echo "[OK] No hay VPN conectada (sistema)"
fi

if ps aux | grep -Ei "openvpn|wireguard|tunnelblick|nordvpn|expressvpn|protonvpn|surfshark" | grep -v grep >/dev/null; then
  echo "[\!] VPN ACTIVA (aplicación detectada)"
else
  echo "[OK] No se detectan apps VPN"
fi

if profiles list 2>/dev/null | grep -i vpn >/dev/null; then
  echo "[\!] VPN CONFIGURADA (perfil instalado)"
else
  echo "[OK] No hay perfiles VPN"
fi
