function only_num(event)
{
 	var key, keyChar;
	if(!event) var event = window.event;
	
	if (event.keyCode) key = event.keyCode;
	else if(event.which) key = event.which;


	if(key==null || key==0 || key==8 || key==13 || key==37 || key==39 || key==46 || key==9) return true;
	keyChar=String.fromCharCode(key);

	if(!/\d/.test(keyChar))	return false;
}


function show_unblock_window(){
    $('#unblock_station').show(400,function(){$('#unblock_code').focus();});
    return false;
    }
    
function hide_unblock_window(){
    $('#unblock_station').hide(600);
    return false;
    }


function show_change_password_window(){
    $('#change_password').show(400);
    setTimeout("$('#old_password').focus();",800);
    return false;
    }
    
function hide_change_password_window(){
    $('#change_password').hide(600);
    return false;
    }

function show_messages(data){
    $('#messages_content').text(data);
    $('#messages').show(400);
    return false;
    }
    
function hide_show_messages(){
    $('#messages').hide(600);
    return false;
    }

function start_work_click(){
	$.post(
	  "/main.html", 
		{action: "logon", 
		 login: $('#text_login').val(), 
		 password: $('#text_password').val(),
		 cost: "cost"
	}); 
    return false;
    }

function disconnect_click(){
    $.post(
	  "/main.html", 
		{action: "logoff", 
		 cost: "cost"
	});
    return false;
    }


function hide_all_block(){
    $('#login').hide(300);
    $('#login_info').hide(300);
    $('#div_session_booking').hide(300);
    $('#div_session_info').hide(300);
    $('#div_eula').hide(300);
    $('#session_info').hide(300);
}

function gcclient_set_state(state){
    hide_all_block();
    
    switch (state) {
        case 1: // ���������� ���� ������ 
            $('#login').show(600);
             setTimeout("$('#text_login').focus();",800);
             setTimeout("$('#text_password').val('');",800);
            break;
        case 2: // ��������� ������ 
            $('#login_info').show(600);
            $('#div_session_booking').show(600);
            $.post("/main.html",
                {action: "get_tariffs", 
                cost: "cost"
                });
            break;
        case 3:
            $('#login_info').show(600);
            $('#session_info').show(600);
            $('#div_session_info').show(600);
            break;
        case 4: // ������������ ����������
            $('#do_not_accept_eula').show(1);            
            $('#div_eula').show(600);
            break;
        case 5:
            $('#session_info').show(600);
            break;
        case 6: // ������������ ����������
            $('#do_not_accept_eula').hide(1);            
            $('#div_eula').show(600);
            break;

        default:
    }
}

function etdSumm_edit(){
    $.post(
	  "/main.html", 
		{action: "querytimecost", 
		 tariff: $('#select_booking_tariff option:selected').text(), 
		 money: $('#text_booking_money').val(),
		 cost: "cost"
	});
    return false;     
}

function cbTariff_edit(){
    $('#text_booking_money').val('1');
    etdSumm_edit();
    $.post(
	  "/main.html", 
		{action: "changetariff", 
		 tariff: $('#select_booking_tariff option:selected').text(),
		 cost: "cost"
	});     
    return false;
}

function start_session_click(){
    $.post("/main.html", 
        {action: "start_session", 
        tariff: $('#select_booking_tariff option:selected').text(), 
        money: $('#text_booking_money').val(),
        cost: "cost"
    });     
    return false;
}


function etdAddSumm_edit(){
    $.post(
	  "/main.html", 
		{action: "queryaddtimecost", 
		 money: $('#text_add_money').val(),
		 cost: "cost"
	});     
    return false;
}

function add_time_click(){
    $.post(
	  "/main.html", 
		{action: "addmoney", 
		 money: $('#text_add_money').val(),
		 cost: "cost"
	});     
    return false;
}

function etdAddTrafficSumm_edit(){
    $.post(
	  "/main.html", 
		{action: "queryaddtrafficcost", 
		 money: $('#text_add_money_traffic').val(),
		 cost: "cost"
	});     
    return false;
}

function add_traffic_click(){
    $.post(
	  "/main.html", 
		{action: "addtraffic", 
		 money: $('#text_add_money_traffic').val(),
		 cost: "cost"
	});     
    return false;
}



function stop_session_click(){
    $.post("/main.html", 
        {action: "stop_session", 
        cost: "cost"
    });     
    return false;
}

function accept_eula_click(){
    $.post("/main.html", 
        {action: "accept_eula", 
        cost: "cost"
    });     
    return false;
}

function no_accept_eula_click(){
    $.post("/main.html", 
        {action: "no_accept_eula", 
        cost: "cost"
    });     
    return false;
}

function do_change_password_click(){
    if ($('#new_password').val()!=$('#retype_password').val()) {
        show_messages('������ �� ���������');
        exit;
    } else {
        $.post("/main.html", 
            {action: "change_password", 
            old_password: $('#old_password').val(),
            new_password: $('#new_password').val() ,
            cost: "cost"
        });
        hide_change_password_window();
    }     

    return false;
}


function unblock_click(){
    $.post("/main.html", 
        {action: "unblock", 
        unblock_code: $('#unblock_code').val(),
        cost: "cost"
    });
    
    return false;
}

function test(){
    update_booking_info({"time":"10:10:10","time_start":"1:0:0","time_stop":"11:10:10"});
    update_info({"login":"ololo", "balance":"10", "accumulated":"20"});
    update_info({"tariffs":{"1":"test","2":"test2","4":"test4"}});
    update_info({"comp_num":"10"});
    
}

function update_booking_info(data){
    $('#text_booking_time').val(data.time);
    $('#text_booking_time_start').val(data.time_start);
    $('#text_booking_time_stop').val(data.time_stop);
}

function update_info(data){
    if ('comp_num' in data){$('#comp_num').text(data.comp_num);}

    if ('login' in data){$('span.label_login').text(data.login);}
    if ('balance' in data){$('#label_balance').text(data.balance);}
    if ('accumulated' in data){
        $('#label_accumulated').text(data.accumulated);
        if (data.accumulated>0){
            $('.accumulated').show(1);
        } else {
            $('.accumulated').hide(1) ;
        }

    }

    if ('booking_time' in data){$('#text_booking_time').val(data.booking_time);}
    if ('booking_time_start' in data){$('#text_booking_time_start').val(data.booking_time_start);}
    if ('booking_time_stop' in data){$('#text_booking_time_stop').val(data.booking_time_stop);}

    if ('booking_add_time' in data){$('#text_add_time').val(data.booking_add_time);}
    if ('booking_add_traffic' in data){$('#text_add_traffic').val(data.booking_add_traffic);}

    if ('show_add_traffic_block' in data){
        if (data.show_add_traffic_block == "1"){
            $('.add_traffic_block').show(1);
        } else {
            $('.add_traffic_block').hide(1);
        }

    }

    if ('enable_start_session' in data){
        if (data.enable_start_session == "1"){
            $('#do_start_session').removeAttr("disabled");
        } else {
            $('#do_start_session').attr("disabled","disabled") ;
        }

    }
    if ('enable_add_money' in data){
        if (data.enable_add_money == "1"){
            $('#do_add_times').removeAttr("disabled");
        } else {
            $('#do_add_times').attr("disabled","disabled") ;
        }

    }

//���������� � ������
    if ('session_info' in data){
		$('#session_info_content').html(data.session_info);
	}

    
// ���������� �������
    if ('tariffs' in data){
            $('#select_booking_tariff option').remove();
            $.each(data.tariffs, function(index,item){
                $('#select_booking_tariff').append($('<option>')
                    .text(item)
                    .attr('value', index));
            cbTariff_edit();
            });
            //alert('ololo');
    }
}

function gc_init(){
    $('ul.tabs').on('click', 'li:not(.current)', function() {
        $(this).addClass('current').siblings().removeClass('current')
            .parents('div.section').find('div.box').eq($(this).index()).fadeIn(150).siblings('div.box').hide();
    })

    $('#start_work').on('click',function(){start_work_click(); return false;});
    
    $('#cancel_unblock').on('click', hide_unblock_window);
    $('#cancel_change_password').on('click', hide_change_password_window);
    $('#do_change_password').on('click', do_change_password_click);

    $('#show_change_password').on('click', show_change_password_window);
    $('#text_booking_money').bind('keypress', only_num);
    $('#text_booking_money').bind('change keyup', etdSumm_edit);
    $('#select_booking_tariff').bind('change keyup', cbTariff_edit);
    $('#do_start_session').on('click', start_session_click);

    $('#text_add_money').bind('keypress', only_num);
    $('#text_add_money').bind('change keyup', etdAddSumm_edit);
    $('#do_add_times').on('click', add_time_click);

    $('#text_add_money_traffic').bind('keypress', only_num);
    $('#text_add_money_traffic').bind('change keyup', etdAddTrafficSumm_edit);
    $('#do_add_traffic').on('click', add_traffic_click);
    

    $('#do_stop_session').on('click', stop_session_click);

    $('#disconnect').on('click', disconnect_click);
    $('#messages').on('click', hide_show_messages);

    $('#do_accept_eula').on('click', accept_eula_click);
    $('#do_not_accept_eula').on('click', no_accept_eula_click);
    
    $('#do_unblock').on('click', unblock_click);

    gcclient_set_state(0);
    }


$(window).load(function() {
    gc_init();
    $.post(
        "/main.html",
        {action: "load_complete",
            cost: "cost"
        });

});
