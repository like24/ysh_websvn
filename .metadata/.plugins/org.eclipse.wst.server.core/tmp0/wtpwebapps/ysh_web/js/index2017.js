var getCodeAvailable = false,
    getting = false,
    submitAvailable = false,
    confirmAvailable = false,
    hasSubmit = false,
    hasConfirm = false,
    status = 3; //status是验票结果，1为成功，2为失败，3为已签到



$('#phoneNum').blur(function() {
    var phoneNum = $(this).val();
    if (!(/^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/.test(phoneNum))) {
        $('#warning').removeClass('hide').children('p').text('请输入正确的手机号');
        getCodeAvailable = false;
        $('#getCode').css('background-color', '#d6d6d6');
    } else {
        $('#warning').addClass('hide');
        getCodeAvailable = true;
        $('#getCode').css('background-color', '#fc734b');
    }
});
 
function checkSubmit() {
    hasSubmit = false;
    $('#flow').removeClass('hide');
    $('#conference').removeClass('hide');
    var phoneNum = $('#phoneNum').val();
    if ($('#name').val() == '') {
        submitAvailable = false;
        $('#submit').css('background-color', '#d6d6d6');
        return false;
    }
    if ($('#code').val() == '') {
        submitAvailable = false;
        $('#submit').css('background-color', '#d6d6d6');
        return false;
    }
    if (!(/^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/.test(phoneNum))) {
        submitAvailable = false;
        $('#submit').css('background-color', '#d6d6d6');
        return false;
    }
    $('#submit').css('background-color', '#fc734b');
    submitAvailable = true;
}

function checkConfirm() {
    hasConfirm = false;
    var phoneNum = $('#phoneNum').val();
    if (!(/^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/.test(phoneNum))) {
        confirmAvailable = false;
        $('#confirm').css('background-color', '#d6d6d6');
        return false;
    }
    if ($('#code').val() == '') {
        confirmAvailable = false;
        $('#confirm').css('background-color', '#d6d6d6');
        return false;
    }
    $('#confirm').css('background-color', '#fc734b');
    confirmAvailable = true;
}


$('#confirm').click(function() {
    if (!hasConfirm) {
        if (status == 1) {
            $('#popUp').removeClass('confirm-fail confirm-done').addClass('confirm-success');
        } else if (status == 2) {
            $('#popUp').removeClass('confirm-success confirm-done').addClass('confirm-fail');
        } else {
            $('#popUp').removeClass('confirm-success confirm-fail').addClass('confirm-done');
        }
        $('#popUp').removeClass('hide');
        hasConfirm = true;
    }
});
$('#close').click(function() {
    if (status == 2) {
        $('#popUp').addClass('hide');
    } else {
        $('#popUp').addClass('hide');
        window.location.href = 'enter.html';
    }
});
$('#checkbox').on('click', '.item', function() {
    $(this).children('.checkmark').toggleClass('checked');
});
