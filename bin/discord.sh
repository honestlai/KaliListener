curl \
    -H "Content-Type: application/json" \
    -d '{
 "content": null,
  "embeds": [
    {
      "description": "A connection to `KaliListener` has been established on port `444`\nConnect to the terminal to view. Type `show` to view new connections\n\nOn the command line type:\n`connect NUMBER-FOR-SESSION`\n\nThe final command to connect to the reverse shell should look like:\n`connect 113`",
      "color": 5814783,
      "author": {
        "name": "🚨 REVERSE SHELL EVENT 🚨"
      }
    }
  ],
  "avatar_url": "https://cdn.discordapp.com/avatars/895526897298059284/fe0980ecca1e363664e2cf94acf0b6bf.webp?size=80",
  "attachments": []
}' \
$WEBHOOK_URL
