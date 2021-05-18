@MLP-606
  Feature: Push Notifications to social application

    Description:
    Stack and/or Hipchat (used in ASG) are good targets. End of load, creation of business data, etc. are good example of events to be notified of.

    Tehnically:
    * events are send to RabbitMQ as they happen (for example, the Tags service can throw a tag create event containing the name of the tag and its database id).
    * A service could connect to RabbitMQ and listens to the events it's interesting in. For each event, it would send a notification to the configured social app. Check the Workflow service or the MessageLogger service to see how to connect to RabbitMQ.
    * The configuration: event -> what message to send (with parameters) -> to which app (connection details) should be stored as a configuration item in the db.
    * Part of the configuration would be the message text to send (the key into a resource file). This text will of course take parameters: A new tag $\{event.tagName} has been created! You can use the Apache common beanutils library to extract fields from the event instance (see WorkflowBinding.DynamicValue class (in platform) for an example.

    Hints for QA testing:
    * please ask [~yuriia] for a manual test scenario

    @positive
    Scenario:MLP-606: To get the list of Social apps
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "settings/socialnotifiers"
    Then Status code 200 must be returned

