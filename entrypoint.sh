#!/bin/sh

# structure_message $content $formatted_content (optional)
structure_message() {
  parsed="$(echo "$1" | markdown)"
  body=$(jq -Rs --arg body "$1" --arg formatted_body "$parsed" '{"msgtype": "m.text", $body, "format": "org.matrix.custom.html", $formatted_body}' < /dev/null)
  echo "$body"
}

# send_message $body (json formatted) $room_id $access_token
send_message() {
  out="$(curl -XPOST -d "$1" "https://$INPUT_SERVER/_matrix/client/r0/rooms/$2/send/m.room.message?access_token=$3")"
  if [ "$(echo "$out" | jq .errcode)" = "null" ]; then
    echo "[+] Message sent!"
  else
    echo '[!] Something went wrong sending the message'
    echo "$out" | jq '.error'
    exit 1
  fi
}
echo "$INPUT_MESSAGE"
send_message "$(structure_message "$INPUT_MESSAGE")" "$INPUT_ROOM_ID" "$INPUT_ACCESS_TOKEN"
