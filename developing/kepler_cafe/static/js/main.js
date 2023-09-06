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
    $(document).on("click", ".star_question", function () {
        const self = this;
        $(".star_question").removeAttr("style").promise().done(function () {
            $(self).css("color", "#ffc107");
            const data_rating = $(self).attr("data-rating");
            // console.log(data_rating);
            $(".star_question").css("color", "#ffc107");
            if (data_rating === "4") {
                $("#star5").removeAttr("style");
            } else if (data_rating === "3") {
                $("#star4").removeAttr("style");
                $("#star5").removeAttr("style");
            } else if (data_rating === "2") {
                $("#star3").removeAttr("style");
                $("#star4").removeAttr("style");
                $("#star5").removeAttr("style");
            } else if (data_rating === "1") {
                $("#star2").removeAttr("style");
                $("#star3").removeAttr("style");
                $("#star4").removeAttr("style");
                $("#star5").removeAttr("style");
            }
            $("#score").val(data_rating);
        });
    })
})