window.addEventListener('message', function (e) {
    $("#container").stop(false, true);

    if (e.data.type === 'DisplayWM' && e.data.visible === true) { 
        const position = e.data.position || 'top-right';
        $("#container").removeClass("top-right bottom-left top-left").addClass(position);
        $("#container").css('display', 'flex').animate({
            opacity: "1.0"
        }, 700);
    } else {
        $("#container").animate({
            opacity: "0.0"
        }, 700, function () {
            $("#container").css('display', 'none');
        });
    }
});
