import requests
import json

url = 'https://d788a255-4cd0-42d3-b76a-3df68a2787c4.webhook.eus.azure-automation.net/webhooks?token=gMQf75XAHZqeduk3dnesV7Vo2QBFYxTvlNW%2bcuLYw5Q%3d'

#data is build in json format
data =    {
        "vmnames": ["lnxgeewebsite103", "lnxgeewebsite104"],
        "VMResourceGroup": "rsgrwebsite001",
    }

#convert data as json.dumps
myobj = json.dumps(data)
print(myobj)

#use the 'headers' parameter to set the HTTP headers:
x = requests.post(url, data = myobj, headers = {"message":"StartedbyServicePortal"})

print(x.text)


