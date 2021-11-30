# Platform Event Subscriber Config in Apex Test Context

Creating a [platform event subscriber config](https://developer.salesforce.com/docs/atlas.en-us.platform_events.meta/platform_events/platform_events_trigger_config.htm) for a platform event trigger subscriber allows you to change the running user from the Automated Process user to a different user within your organization.  This allows you to workaround issues that occur when logic is executed under the Automated Process user.

However, there is an issue when the platform event subscriber config is introduced, it is not respected in the Apex Unit Test context.  All code in Apex Unit tests is still executed with the Automated Process user.  This respository highlights this issue.

## Steps to Reproduce

1. Clone this repository
2. Create a scatch org using the default config from the repository
3. Replace the username in the `platformEventSubscriberConfigs/myEventHandlerConfig.platformEventSubscriberConfig-meta.xml` file with the default username that is created in your scratch org.  Place this between the `<user></user>` tags and save the file.
4. Push the source to the scratch org using `sfdx force:source:push`
5. Execute the apex script: `sfdx force:apex:execute -f ./scripts/apex/eventPublishTest.apex`
6. Download the Platform Event Trigger debug log and verify the Debug statment from the trigger show that the running user is the user configured in your platform event subscriber config.
```
08:20:10:003 USER_DEBUG [2]|INFO|The running user is: test-ytz7ewolqdcm@example.com
```
7. Execute the test class from the repository: `sfdx force:apex:test:run -n myEventHandlerTest -r human`
8. Download the test run log and verify that the same Debug statement from the trigger shows the Automated Process user and not the user from the platform event subscriber config.
```
08:21:02:041 USER_DEBUG [2]|INFO|The running user is: autoproc@00dj0000003p6vdmai
```
