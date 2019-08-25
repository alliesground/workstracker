//= require cable
//= require_self
//= require_tree .

this.App = {};

App.cable = ActionCable.createConsumer();  

App.activities = App.cable.subscriptions.create('ActivitiesChannel', {  
  received: function(data) {
    $("#activities").removeClass('hidden')
    return $('#activities .list').prepend(this.renderMessage(data));
  },

  renderMessage: function(data) {
    return "<li class='item'>" + data.activity_message + "</li>";
  }
});
