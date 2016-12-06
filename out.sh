#!/bin/bash

set -e
exec 3>&1
exec 1>&2

set +x
PATH=/usr/local/bin:$PATH
payload=$(mktemp /tmp/resource-in.XXXXXX)
cat > "${payload}" <&0

slack_notify_url="$(jq -rcM '.source.slack_notify_url' < "${payload}")"
[ "${slack_notify_url}" != "null" ] && export SLACK_NOTIFY_URL="${slack_notify_url}"

slack_channel="$(jq -rcM '.params.slack_channel' < "${payload}")"
[ "${slack_channel}" != "null" ] && export SLACK_CHANNEL="${slack_channel}"

slack_footer="$(jq -rcM '.params.slack_footer' < "${payload}")"
[ "${slack_footer}" != "null" ] && export SLACK_FOOTER="${slack_footer}"

slack_footer_icon="$(jq -rcM '.params.slack_footer_icon' < "${payload}")"
[ "${slack_footer_icon}" != "null" ] && export SLACK_FOOTER_ICON="${slack_footer_icon}"

export SLACK_BUILD_URL="${ATC_EXTERNAL_URL}/builds/${BUILD_ID}"

on_success="$(jq -rcM '.params.on_success // "false"' < "${payload}")"
on_failure="$(jq -rcM '.params.on_failure // "true"' < "${payload}")"

values="$(jq -rcM '.params.values' < "${payload}")"

if [ "$(cat ${1}/${values}/color)" == "good" ]; then
    echo "Build succeeded"
    if [ "${on_success}" == "true" ]; then
        notify "${1}/${values}"
        echo "Slack notification sent"
    else
        echo "on_success is false, so not sending notification"
    fi
else
    echo "Build failed"
    if [ "${on_failure}" == "true" ]; then
        notify "${1}/${values}"
        echo "Slack notification sent"
    else
        echo "on_failure is false, so not sending notification"
    fi
fi

jq -n "{version:{timestamp:\"$(date +%s)\"}}" >&3
