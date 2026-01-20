clear
echo "======================================="
echo "   DETECTOR AUTOMATICO DE VPN macOS"
echo "======================================="

VPN_FOUND=0
VPN_NAME="Desconocida"

echo ""
echo "[1] Revisando servicios VPN del sistema..."

scutil --nc list 2>/dev/null | grep "Connected" >/dev/null
if [ $? -eq 0 ]; then
    echo "[DETECTADO] Servicio VPN del sistema activo"
    VPN_FOUND=1
fi

echo ""
echo "[2] Revisando interfaces de red..."

ifconfig | grep -E "utun[0-9]|ppp[0-9]|ipsec[0-9]" >/dev/null
if [ $? -eq 0 ]; then
    echo "[DETECTADO] Interfaz VPN activa"
    VPN_FOUND=1
fi

echo ""
echo "[3] Revisando procesos VPN..."

check_proc () {
    ps aux | grep -i "$1" | grep -v grep >/dev/null
}

if check_proc nord || check_proc nordvpn; then
    VPN_FOUND=1
    VPN_NAME="NordVPN"
    echo "[DETECTADO] Proceso NordVPN"
fi

if check_proc proton; then
    VPN_FOUND=1
    VPN_NAME="ProtonVPN"
    echo "[DETECTADO] Proceso ProtonVPN"
fi

if check_proc express; then
    VPN_FOUND=1
    VPN_NAME="ExpressVPN"
    echo "[DETECTADO] Proceso ExpressVPN"
fi

if check_proc surfshark; then
    VPN_FOUND=1
    VPN_NAME="Surfshark"
    echo "[DETECTADO] Proceso Surfshark"
fi

if check_proc tunnelblick; then
    VPN_FOUND=1
    VPN_NAME="Tunnelblick / OpenVPN"
    echo "[DETECTADO] Proceso Tunnelblick"
fi

if check_proc wireguard; then
    VPN_FOUND=1
    VPN_NAME="WireGuard"
    echo "[DETECTADO] Proceso WireGuard"
fi

if check_proc tailscale; then
    VPN_FOUND=1
    VPN_NAME="Tailscale"
    echo "[DETECTADO] Proceso Tailscale"
fi

echo ""
echo "[4] Revisando servicios cargados..."

launchctl list | grep -Ei "vpn|nord|proton|express|surf|wireguard|tailscale" >/dev/null
if [ $? -eq 0 ]; then
    echo "[DETECTADO] Servicio VPN cargado en el sistema"
    VPN_FOUND=1
fi

echo ""
echo "---------------------------------------"

if [ "$VPN_FOUND" -eq 1 ]; then
    echo "RESULTADO FINAL: VPN DETECTADA"
    echo "VPN IDENTIFICADA: $VPN_NAME"
else
    echo "RESULTADO FINAL: NO SE DETECTA VPN"
fi

echo "---------------------------------------"
