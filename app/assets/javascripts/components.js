$(document).ready(function () {
    // Bootstrap text editor for notes.
    $('.wysihtml5').each(function (i, elem) {
        $(elem).wysihtml5();
    });

    // Bootstrap datepicker.
    var nowDate = new Date();
    var today = new Date(nowDate.getFullYear(), nowDate.getMonth(), nowDate.getDate(), 0, 0, 0, 0);

    $('.datepicker').datepicker({
        autoclose: true,
        format: "yyyy-mm-dd",
        weekStart: 1,
        startDate: today
    });
});