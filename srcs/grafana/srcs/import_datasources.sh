#Configurer les data_sources dans grafana et dans le container, run :
#mkdir -p data_sources && curl -s "http://localhost:3000/api/datasources"  -u admin:admin|jq -c -M '.[]'|split -l 1 - data_sources/
#>> exporte les data_sources
for i in import/data_sources/*; do \
    curl -X "POST" "http://localhost:3000/api/datasources" \
    -H "Content-Type: application/json" \
     --user admin:admin \
     --data-binary @$i
done
#>> importe les data_sources
