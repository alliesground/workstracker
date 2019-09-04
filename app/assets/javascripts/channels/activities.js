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
          $('body').toast({
            message: data.message
          })
        }

      });
});

