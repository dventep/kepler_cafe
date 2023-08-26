$(document).ready(function() {
    const csrftoken =  window.CSRF_TOKEN;
    $(document).on("click", "#about_us", function () {
        $(this).css("background", "red");
        let identification = $("#identification").val();
        $.ajax({
            type: "POST",
            url: "accounts/me/",
            data: {csrfmiddlewaretoken : csrftoken, identification: identification},
            complete: function(html) {
                console.log("hola")
            }
        });
    })
})