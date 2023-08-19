$(document).ready(function() {
    $(".special-novelty-selector").select2({
        width: 'style'
    });
    let timeCronometer_user;
    var sec_user = 0;
    var min_user = 0;
    var hrs_user = 0;
    const tickCronometer_user = function() {
        sec_user++;
        if (sec_user >= 60) {
            sec_user = 0;
            min_user++;
            if (min_user >= 60) {
                min_user = 0;
                hrs_user++;
            }
        }
    };    
    const timerCronometer_user = function() {
        timeCronometer_user = setTimeout(addCronometer_user, 1000);
    };
    const addCronometer_user = function() {
        tickCronometer_user();
        $(".timer-wait").html(`${(hrs_user > 9 ? hrs_user : "0" + hrs_user)}:${(min_user > 9 ? min_user : "0" + min_user)}:${(sec_user > 9 ? sec_user : "0" + sec_user)}`);
        timerCronometer_user();
    }; 
    const reset_timer_user = function() {     
        sec_user = 0;
        min_user = 0;
        hrs_user = 0;
        $(".timer-wait").html(`00:00:00`);
    };
      
    // var timeCronometer_user;
    // var sec_user = 0;
    // var min_user = 0;
    // var hrs_user = 0;
    // const tickCronometer_user = function() {
    //     sec_user++;
    //     if (sec_user >= 60) {
    //         sec_user = 0;
    //         min_user++;
    //         if (min_user >= 60) {
    //             min_user = 0;
    //             hrs_user++;
    //         }
    //     }
    // };    
    // const addCronometer_user = function() {
    //     tickCronometer_user();

    //     console.log(`${hrs_user}:${min_user}:${sec_user}`);

    //     $(".timer-wait").html(`${(hrs_user > 9 ? hrs_user : "0" + hrs_user)}:${(min_user > 9 ? min_user : "0" + min_user)}:${(sec_user > 9 ? sec_user : "0" + sec_user)}`);
    //     timerCronometer_user();
    // };    
    // const timerCronometer_user = function() {
    //     if ($(".container-load").is(":visible")) {
    //         timeCronometer_user = setTimeout(addCronometer_user, 1000);   
    //     }     
    //     if ($(".container-message").is(":visible")) {
    //         $(".container-load").removeAttr("style");
    //         reset_timer_user();
    //     }
    // };
    // const reset_timer_user = function() {
    //     sec_user = 0;
    //     min_user = 0;
    //     hrs_user = 0;
    //     $(".timer-wait").html(`00:00:00`);
    //     clearTimeout(timeCronometer_user);
    //     timeCronometer_user = null;
    // };
    const resetErrors = () => {
        $(".container-message").remove();
        $(".container-errors").remove();
        $(".sect-errors").attr("class", "sect-errors");
        $(".content-errors").html(`<span class="num-errors">0</span>
        <i class="fas fa-exclamation-triangle"></i>`);
    };
    var timeOut_Message;
    const timer_plusMessage  = function() {
        $(".container-message").slideUp("fast", function() {
            $(".container-message").remove();
            clearTimeout(timeOut_Message);
            timeOut_Message = null;
        });
    };
    const timer_resetMessage = function() {
        console.log(timeOut_Message);
        if(timeOut_Message != undefined) {
            clearTimeout(timeOut_Message);
            timeOut_Message = null;
        }
        timeOut_Message = setTimeout(timer_plusMessage, 15000);
    }



    $(document).on("click", ".close-article", function() {
        if ($(".article-error").length <= 1) {            
            resetErrors();
        } else {
            let id = $(this).attr("id");        
            $(`#article_${id}`).fadeOut(70,"linear", function() {
                $(`#article_${id}`).remove();

                let title = $(`.errors-container`).html();
                if (title && title.includes("Errores (") && title.includes(")")) {
                    let errors_count = (title.split("Errores (")[1]).replace(")", "");
                    newCountErrors(errors_count);
                }
            });
        }
    });
    const newCountErrors = (num) => {
        if (num >= 0) {
            newNum = parseInt(num)-1;
            $(`.errors-container`).html(`Errores (${newNum})`);
            if (newNum > 9) {
                $(`.num-errors`).html("9+");
            } else {
                $(`.num-errors`).html(newNum);
            }
            if (newNum == 0) {
                $(`.errors-exist span`).attr("style", "background-color:#6D6D6D !important");
                $(`.errors-exist svg`).attr("style", "color: #989898 !important");
                $(`.errors-exist p`).attr("style", "color: #6D6D6D !important");
            }
        }
    }
    $(document).on("click", "#btnLoadCenters", function(e) {            
        e.preventDefault();
        const csrftoken =  window.CSRF_TOKEN;
        reset_timer_user();
        resetErrors();
        $(".container-load").css("display","flex");   
        timerCronometer_user();
        
        $.ajax({
            type: "POST",
            url: "/colaboradores/",
            data: {'action':"all", csrfmiddlewaretoken:csrftoken},
            success: function(returned) {
                $(".container-load").css("display","none");  
                clearTimeout(timeCronometer_user);
                let containerErrors;
                let content;
                let signMessage;
                if ($(".container-form").length) {
                    containerErrors = ".container-form";
                } else if ($(".sections-container").length) {
                    containerErrors = ".sections-container";
                } else {
                    containerErrors = ".container-div";
                }
                if (returned.message[0] == "Done") {
                    signMessage = "fa-check-circle";
                } else if (returned.message[0] == "Done_Error") {
                    signMessage = "fa-exclamation-circle";
                } else {
                    signMessage = "fa-times-circle";
                }

                if (Object.keys(JSON.parse(returned.failed_users)).length) {

                    content = `<div class="container-message">
                        <h4 class="message-h4">${returned.message[1]}</h4>
                        <span class="icon-message">
                            <i class="fas ${signMessage}"></i>
                        </span>          
                        <div class="time_date">
                            <span class="time-duration">
                                ${returned.time_duration}
                            </span>
                            <div class="timer_schedulle">
                                <span> </span>
                            </div>
                        </div>

                    </div>
                    <div class="container-errors">
                        <section class="errors-container">Errores (${returned.quantity_failed})</section>
                        <section class="list-errors">
                            ${loopErrors(JSON.parse(returned.failed_users))}
                        </section>
                    </div>`;
                    
                    $(".sect-errors").attr("class", "sect-errors errors-exist");
                    let quantity_failed;
                    if (returned.quantity_failed > 9) {
                        quantity_failed = "9+";
                    } else if (returned.quantity_failed <= 9) {
                        quantity_failed = returned.quantity_failed;
                    }
                    $(".num-errors").html(quantity_failed);
                } else {
                    content = `<div class="container-message">
                        <h4 class="message-h4">${returned.message[1]}</h4>
                        <span class="icon-message">
                            <i class="fas ${signMessage}"></i>
                        </span>         
                        <div class="time_date">
                            <span class="time-duration">
                                ${returned.time_duration}
                            </span>
                        </div>      
                        <div class="timer_schedulle">
                            <span> </span>
                        </div>
                    </div>`;
                    timer_resetMessage();
                }
                $(containerErrors).after(content);
            },
            error: function(error) {
                $(".container-load").css("display","none");          
                clearTimeout(timeCronometer_user);      
                console.log(error);
            }
        });
    });

    const loopErrors = function (listErrors) {
        let htmlErrors = "";
        listErrors.forEach((element, i) => {
            htmlErrors += `<article class="article-error" id="article_${i}">
                <p class="title-errors"><b>${element[0]}</b><b class="close-article" id="${i}">X</b></p>
                <p>${element[1]}</p>
            </article>`
        });
        return htmlErrors
    };
})