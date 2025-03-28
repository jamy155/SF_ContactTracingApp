({
  updateStatus: function (conponent) {
    const recordId = conponent.get("v.recordId");

    const action = conponent.get("c.updateHealthStatus");
    action.setParams({
      personId: recordId
    });

    action.setCallback(this, function (response) {
      const state = response.getState();
      if (state === "SUCCESS") {
        this.showToast("Success", "Person health status updated", "success");
      }
    });
    $A.enqueueAction(action);
  },

  showToast: function (title, message, type) {
    const toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
      title,
      message,
      type
    });
    toastEvent.fire();
  }
});
