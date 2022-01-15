curl -s \
-X POST \
--user "$MAILJET_TOKEN" \
https://api.mailjet.com/v3.1/send \
-H 'Content-Type: application/json' \
-d '{
  "Messages":[
    {
      "From": {
        "Email": "mail@makifdb.com",
        "Name": "Mehmet Akif"
      },
      "To": [
        {
          "Email": "mail@makifdb.com",
          "Name": "Mehmet Akif"
        }
      ],
      "Subject": "Production Build Successful",
      "TextPart": "Production Build Successful",
      "HTMLPart": "May the force be with you!",
      "CustomID": "AppGettingStartedTest"
    }
  ]
}'
