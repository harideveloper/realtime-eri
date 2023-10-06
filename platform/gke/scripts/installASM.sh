

ls -la
#curl -LO https://storage.googleapis.com/gke-release/asm/istio-1.18.2-asm.4-osx.tar.gz

# Extract the ASM package

tar -xzf istio-1.18.2-asm.4-osx.tar.gz
cd istio-1.18.2-asm.4
   
# Install ASM using istioctl
./bin/istioctl version

./bin/istioctl install --set profile=minimal -y
#./bin/istioctl install -f istio-operator.yaml

# Verify the installation
kubectl get pods -n istio-system
kubectl get svc -n istio-system