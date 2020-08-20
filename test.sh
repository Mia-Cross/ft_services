echo "Getting IP for FTPS, it will be running shortly..."
echo "Waiting a few moments before launching dashboard..."
sleep 10
screen -dmS dashboard minikube dashboard
echo ""
while [[ $(env | grep FTPS_IP | grep .) = '' ]]
do
    sleep 1
done
echo "FTPS Service accessible via Filezilla @ $FTPS_IP"
echo "Thank you for waiting :)"
