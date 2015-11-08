$(document).ready(function () {
    /* initialize the calendar
     -----------------------------------------------------------------*/
    $('#calendar').fullCalendar({
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        buttonText: {
            today: 'today',
            month: 'month',
            week: 'week',
            day: 'day'
        },
        events: '/tasks.json',
        eventRender: function(event, element) {
            element.attr("data-toggle", "modal");
            element.attr("data-target", "#"+event.title);
        },
        editable: true
    });
});