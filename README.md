# SIMPLE EVENTS CRUD

### What it is
This is simple CRUD written in Elixir/Phoenix. App works in Vagrant machine which has `192.168.2.202` IP. REST API stores object like:

`
{"event": 
	{
		"sensor": "(string)<sensor_name>", 
		"sensor_type": "(string)<sensor_type>", 
		"value": (float)<measured_value>
	}
}
`

and can be accessed at `192.168.2.202:4000/api/events/`.

Each record has 30 s TTL. 


### Requirements

Make sure you have installed these packages:
`
sudo apt update
sudo apt upgrade
sudo apt install vagrant git curl
`


### First run

Download repo and move to repo directory:

`
git clone https://github.com/postep/hiro
cd hiro
`

run Vagrant machine and let provisioner install elixir, phoenix and postgres
`
vagrant up
vagrant provision
`

you can login to machine and go to app code
`
vagrant ssh
cd /opt/hiro/sensor_db
`

app can be started by
`
mix phx.server
`


Machine can be killed when you log out ssh session and type:
`
vagrant halt
`



### Usage

To create record use:

`
curl --header "Content-Type: application/json" --request POST --data \
	'{"event": {"sensor": "living_room", "sensor_type": "termomether", "value": 20}}'  \
	http://192.168.2.202:4000/api/events
`

To read all records:
`
curl --request GET http://192.168.2.202:4000/api/events
`

To read only one record use:
`
curl --request GET http://192.168.2.202:4000/api/events/<sensor_id>
`

To update record use:
`
curl --header "Content-Type: application/json" --request PATCH --data \
	'{"event": {"value": 25}}'  \
	http://192.168.2.202:4000/api/events/<sensor_id>
`


To delete record use:
`curl --request DELETE http://192.168.2.202:4000/api/events/<sensor_id>
`

