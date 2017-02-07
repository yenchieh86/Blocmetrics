# Blocmetrics
## An analytics service and reporting tool that you can be used to track user activity and report results

###Features:
 - A client-side JavaScript snippet that allows a user to track events on their website.
 - A server-side API that captures and saves those events to a database.
 - A Rails application that displays the captured event data for a user in a chart and line graph form.

###Getting Started:

The client will add this script to their website/application

```javascript
var blocmetrics = {
  report: function(event_name) {
    var event = {
      name: event_name
    };
    
    var request = new XMLHttpRequest();
    request.open("POST", "https://bloc-final-project-yenchieh86.c9users.io/api/events", true);
    request.setRequestHeader('Content-Type', 'application/json');

    request.onreadystatechange = function() {
    };
    request.send(JSON.stringify(event));
  }
};
```


For a user to track an event, they need to do is add the snippet `blocmetrics.report('event_name')` wherever desired.

for example:

```javascript
$(document).ready(
  $('.btn-a').click(function() {
    blocmetrics.report('name_of_event');
  });
)
```


Screenshots
-----------

![Imgur](https://github.com/yenchieh86/Blocmetrics/blob/master/app/assets/images/ss1.png)
![Imgur](https://github.com/yenchieh86/Blocmetrics/blob/master/app/assets/images/ss2.png)
