#!/bin/bash



printf "{
    \"channel\": \"$SLACK_CHANNEL\",
    \"attachments\": [
        {
            \"color\": \"`cat ${1}/color`\",
            \"pretext\": \"`cat ${1}/pretext`\",
            \"author_name\": \"`cat ${1}/author`\",
            \"title\": \"`cat ${1}/project` (`cat ${1}/branch`)\",
            \"title_link\": \"$SLACK_BUILD_URL\",
            \"text\": \"`cat ${1}/commit`\",
            \"mrkdwn_in\": [\"text\"],
            \"footer\": \"$SLACK_FOOTER\",
            \"footer_icon\": \"$SLACK_FOOTER_ICON\",
            \"ts\": \"`date +%s`\"
        }
    ]
}" > notification.txt

curl -X POST -d @notification.txt $SLACK_NOTIFY_URL
