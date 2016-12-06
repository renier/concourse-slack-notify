# Slack Notify Concourse.CI resource

Will send a formatted slack notification about a Concourse.CI build.

Parameters that should be injected:

* `slack_channel`
* `slack_notify_url` - You get this when you create the incoming webhook in Slack
* `slack_footer` - Will show in the footer of the notification.
* `slack_footer_icon` - URL to the icon to show beside the footer blurb.
* `values` - Directory name under the incoming project artifacts directory where the following files can be found:
    * `color` - Color block line for the notification. *good* means it was a successful build.
    * `pretext` - Subtitle for the notification.
    * `project` - Name of the project
    * `branch` -  Name of the code branch
    * `commit` - Should have the commit hash and message
    * `author` - Author of the commit
* `on_success` - _Optional_. true/false. false is default. If build was successful, send the slack notification. Keys off of *color* above.
* `on_failure` - _Optional_. true/false. true is default. If build failed, send the slack notification. Keys off of *color* above.

