#!/bin/sh

notification=`cat $SLACK_TEXT | sed -E ':a;N;$!ba;s/\r{0,1}\n/\\n/g' | sed -e 's/&/\&amp;/g' | sed -e 's/</\&lt;/g' | sed -e 's/>/\&gt;/g'`
echo "{\"channel\":\"$SLACK_CHANNEL\",\"text\":\"$notification\"}" > notification.txt
curl -X POST -d @notification.txt $SLACK_NOTIFY_URL
