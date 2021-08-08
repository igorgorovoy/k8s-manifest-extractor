for namespace_name in $(kubectl get namespaces -o name)
do
echo "Start processing in namespace: " $namespace_name
mkdir -p  $namespace_name
cd $namespace_name
nsnm=$(echo $namespace_name | sed 's+namespace/++g')
echo "CURRENT TAG is " $nsnm
for n in $(kubectl get -o=name pvc,configmap,serviceaccount,secret,ingress,service,deployment,statefulset,hpa,job,cronjob -n $nsnm)
do
    echo "Now extracting : $n"
    mkdir -p $(dirname $n)
    kubectl get -o=yaml -n $nsnm $n > $n.yaml
done
cd ../..
done
echo "Stop processing in namespace: " $namespace_name
