//= require cable
//= require_self
//= require_tree .

$(function(){
  App.activities = App.cable.subscriptions.create(
      { 
        channel: 'ActivitiesChannel',
        project_id: $('#activities').data('project-id')
      }, {
        received: function(data) {
          $("#activities").removeClass('hidden')
          return $('#activities .list').prepend(this.renderMessage(data));
        },

        renderMessage: function(data) {
          return "<li class='item'>" + data.activity_message + "</li>";
        }

      });
});

