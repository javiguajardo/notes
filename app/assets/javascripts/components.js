$(document).ready(function () {
    // Bootstrap text editor for notes.
    $('.wysihtml5').each(function (i, elem) {
        $(elem).wysihtml5();
    });
});