# Stop MicroK8s
sudo microk8s stop || true
# Remove the MicroK8s snap package
sudo snap remove microk8s --purge || true
# Delete all cali* interfaces
for intf in $(ip -o link | grep cali | awk -F’: ' ‘{print $2}‘); do
  sudo ip link delete $intf || true
done
# Flush iptables (Calico uses a lot of iptables rules)
sudo iptables -F
sudo iptables -t nat -F
sudo iptables -t mangle -F
sudo iptables -X
# Remove residual data
sudo rm -rf /run/containerd
sudo rm -rf /var/lib/cni
sudo rm -rf /opt/cni
sudo rm -rf /etc/cni/net.d
sudo rm -rf ~/.kube
sudo rm -rf /var/snap/microk8s
