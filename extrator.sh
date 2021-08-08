for namespace_name in $(kubectl get namespaces -o name)
do
echo "Start processing in namespace: " $namespace_name
mkdir -p  $namespace_name
cd $namespace_name
for n in $(kubectl get -o=name pvc,configmap,serviceaccount,secret,ingress,service,deployment,statefulset,hpa,job,cronjob)
do
    echo "Now extracting : $n"
    mkdir -p $(dirname $n)
    kubectl get -o=yaml $n > $n.yaml
done
cd ../..
done
echo "Stop processing in namespace: " $namespace_name
