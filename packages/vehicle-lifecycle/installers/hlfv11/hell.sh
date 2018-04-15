export ip="$(ifconfig | grep -v 'eth0:' | grep -A 1 'eth0' | tail -1 | cut -d ':' -f 2 | cut -d ' ' -f 1)"
echo "For composer playground: ${ip}:8080"
echo "$ip"
