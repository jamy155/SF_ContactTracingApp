({
  createRecord: function (component, event, helper) {
    const scope = component.get("v.scope");
    var createRecordEvent = $A.get("e.force:createRecord");

    createRecordEvent.setParams({
      entityApiName: scope === "person" ? "Person__c" : "Location__c"
    });
    createRecordEvent.fire();
  }
});
