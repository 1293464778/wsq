//加密
function jiami(jsontextall){
    var resultlastasd;
    //加密

    //sha1
    var sha1Sync_value = $.sha1(jsontextall);

    //转换小写
    sha1Sync_value = sha1Sync_value.toLowerCase();
    //添加秘钥
    var jsontextall_mi = sha1Sync_value + '#l_vle_ll_e%+$^@0608)[';
    //md5
    var md5Sync_value = $.md5(jsontextall_mi);

    //转换小写
    resultlastasd = md5Sync_value.toLowerCase();
    return resultlastasd;
}


//生成客户端签名
function signaturetik(){
    var resultlast;
    var jsontext = [];
    var args = arguments;
    if (args){
        for(var i = 0;i<args.length;i++){
            jsontext.push(args[i]);
        }
    }

    jsontext.sort(); //排序

    var jsontextall = jsontext.join('&');  //拼接

    resultlast = jiami(jsontextall);

    return resultlast;

}


//随机数生成
function tokenmake(){
    var tmp = Date.parse( new Date() ).toString();
    tmp = tmp.substr(0,10);
    return tmp;
}

//生成带键值的字符串
function addname(namen,vuln){
    var valname = namen.toString() + vuln.toString();
    return valname;

}







//json数组获取特定子元素
function arrdata_ch(arrdate,arrval){

    for(var i=0;i<arrdate.length;i++){
        if (arrdate[i].landId==arrval){
            return arrdate[i];
        }

    }
}



//退出登录
function tuichu(token,qianming,urlt){
    var loading = layer.open({type: 2});
    api.ajax({
        url: 'http://nongchang.65g.cn/index.php/Api/Login/logout',
        method: 'get',
        dataType:'json',
        data: {
            values: {
                token: token,
                signature: qianming
            }

        }
    }, function(ret, err) {
        if (ret) {

            layer.close(loading);
            $api.clearStorage();
            api.writeFile({
                path: 'box://data.txt',
                data: ''
            }, function(ret, err) {
                if (ret.status) {
                    //成功
                } else {

                }
            });
            $api.setStorage('userAccessToken','');

            api.openWin({
                name: 'login',
                url: urlt,
                opaque: false,
                vScrollBarEnabled: true
            });

        } else {
            alert(err.msg);
        }

    });
}





//提示信息获取
    function infoget(num) {
        api.ajax({
            url: 'http://nongchang.65g.cn/index.php/Api/Index/remind',
            method: 'POST',
            dataType: 'json',
            data: {
                values: {
                    id: num
                }

            }
        }, function (ret, err) {
            if (ret) {

                $api.setStorage('infor' + num, ret.data.content);

            } else {
                //alert(err.msg);
            }
        });






        $.ajax({
            url: "http://nongchang.65g.cn/index.php/Api/Index/remind",
            type: "post",
            data: {
                id: num
            },
            dataType: "json",
            success: function(ret) {
                localStorage.setItem('infor' + num, ret.data.content);
            },
            error: function() {

            }
        });


    }






