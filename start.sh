#!/bin/sh

meta=`curl 169.254.170.2/v2/metadata -s`
col=`echo $meta | jq .TaskARN | tr -d '"' | tail -c 7`

cd /opt/www

cluster=`echo $meta | jq .Cluster | tr -d '"' | cut -f2 -d'/'`
taskarn=`echo $meta | jq .TaskARN | tr -d '"' | cut -f2 -d'/'`
taskip=`echo $meta | jq .Containers[1].Networks[0].IPv4Addresses | tr -d '"'`
cname=`echo $meta | jq .Containers[1].Name | tr -d '"'`
did=`echo $meta | jq .Containers[1].DockerId | tr -d '"'`
if [ "$(echo $cname)" = "~internal~ecs~pause" ]; then
    cname=`echo $meta | jq .Containers[0].Name | tr -d '"'`
    taskip=`echo $meta | jq .Containers[0].Networks[0].IPv4Addresses | tr -d '"'`
    did=`echo $meta | jq .Containers[0].DockerId | tr -d '"'`
fi

echo "<html>"  > middle.html
echo "<body style=\"background-color: #$col;\">" >> middle.html
echo "<h1 align=\"center\">Fargate task information</h1>" >> middle.html
echo "<hr>" >> middle.html
echo "<p align=\"center\">" >> middle.html
echo "<font size=\"3\" face=\"Arial\">" >> middle.html
echo "<table border=\"2\" bgcolor=\"white\">"  >> middle.html
echo "<tr><td>Cluster </td><td> $cluster </td></tr>"  >> middle.html
echo "<tr><td>TaskID </td><td> $taskarn </td></tr>"  >> middle.html
echo "<tr><td>Container Name </td><td> $cname </td></tr>"  >> middle.html
echo "<tr><td>IPv4 </td><td> $taskip </td></tr>"  >> middle.html
echo "</table>"  >> middle.html
echo "<hr>" >> middle.html
echo "</p>"  >> middle.html
echo "</font>"  >> middle.html
echo "</body>"  >> middle.html
echo "</html>"  >> middle.html

cat middle.html > index.html
nginx && tail -f /dev/null


## wait command waits for any background jobs so docker stuff hangs around or do the tail /dev/null trick
#wait
