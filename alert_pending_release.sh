#!/bin/bash

# structure_message $content $formatted_content (optional)
structure_message() {
  if [ -z "$2" ]; then
    body=$(jq -Rs --arg body "$1" '{"msgtype": "m.text", $body}' < /dev/null)
  else
    body=$(jq -Rs --arg body "$1" --arg formatted_body "$2" '{"msgtype": "m.text", $body, "format": "org.matrix.custom.html", $formatted_body}' < /dev/null)
  fi
  echo $body
}

# send_message $body (json formatted) $room_id $access_token
send_message() {
curl -XPOST -d "$1" "https://$server/_matrix/client/r0/rooms/$2/send/m.room.message?access_token=$3"
}

# Format and send message to #polkadot channel
msg_body=$(cat <<EOF
EOF
)

# Created formatted body for clients that support it (???)
formatted_msg_body=$(cat <<EOF
EOF
)

send_message "$(structure_message "$message" "$formatted_message")" $room_id $access_token
