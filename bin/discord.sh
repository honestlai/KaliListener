export WEBHOOK_URL=https://discord.com/api/webhooks/1067734584470544404/IkPAi4i2m4BpKxaoIXUD4gDxMfUMHHHZRPQv8mZcnwJ_mblEn7b1Lb2C5JD5v6M9LCnu
curl \
    -H "Content-Type: application/json" \
    -X POST -d "{
 \"content\": null,
  \"embeds\": [
    {
      \"description\": \"A connection to \`KaliListener\` has been established on port \`465\`\nAt the terminal type \`show\` to view new connections\n\nType the below to connect to the session:\n\`connect $1\`\",
      \"color\": 5814783,
      \"author\": {
        \"name\": \"🚨 REVERSE SHELL EVENT 🚨\"
    }
  }
],
  \"avatar_url\": \"https://cdn.discordapp.com/avatars/895526897298059284/fe0980ecca1e363664e2cf94acf0b6bf.webp?size=80\",
  \"attachments\": []
}" \
$WEBHOOK_URL
