//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require moment 
//= require fullcalendar
//= require fullcalendar/locale-all
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
$(document).ready(function() {
  $("#calendar").fullCalendar();
});
document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');

  var calendar = new Calendar(calendarEl, {
    plugins: [ dayGridPlugin ]
  });

  calendar.render();
});