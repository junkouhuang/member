<%--
  Created by IntelliJ IDEA.
  User: jingao
  Date: 2018/9/11
  Time: 11:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>会员卡绑定</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <link href="${pageContext.request.contextPath}/css/mui.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/mui.picker.min.css" rel="stylesheet" />
</head>
<body>
<div>
    <header class="mui-bar mui-bar-nav">
        <a class=" mui-icon mui-icon-left-nav mui-pull-left"  href="#" id="toOpenCardByWxOpenid"></a>
        <h1 class="mui-title">返回</h1>
    </header>
    <div class="mui-content">
        <p style="display: none" id="wxopenid">${wxopenid}</p>
        <div class="mui-content-padded">
            <h5  style="font-size: 15px;">会员卡号</h5>
            <div class="mui-input-row mui-search ">
                <input type="number" id="_vipcard" class="mui-input-clear" placeholder="填入会员卡号" maxlength="12" style="border: 1px solid #ffffff;">
            </div>
            <h5 style="font-size: 15px;">会员密码</h5>
            <div class="mui-input-row mui-search ">
                <input type="password" id="_vippwd" class="mui-input-password" placeholder="填入会员密码" minlength="6"  style="border: 1px solid #ffffff;">
            </div>
            <button class="mui-btn mui-btn-block mui-btn-primary"
                    data-loading-icon="mui-spinner mui-spinner-custom" data-icon-position="right" type="button" id="bindVipHyByWxOpenid">确定
            </button>
            <p class=""><i class="mui-icon mui-icon-info" style="font-size: 20px;"></i>绑定后，可以在公众号中对会员卡进行操作，且可以收到会员卡消费充值通知</p>
            <div class="mui-input-row" style="text-align: center;"> <a href="#" id="Forget">忘记会员卡密码？</a></div>
        </div>
    </div>
</div>
</body>
<script src="${pageContext.request.contextPath}/js/mui.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-2.1.3.min.js" type="text/javascript"></script>
<script>
    var bindVipHyByWxOpenid=document.getElementById("bindVipHyByWxOpenid"); //绑定按钮
    var vipcard=document.getElementById("vipCard");//会员卡号
    var password=document.getElementById("password"); //密码

    bindVipHyByWxOpenid.addEventListener('tap',function(){
        if(_vipcard.value==""){
            mui.alert('会员卡号不能为空！');
            return false;
        }
        if(_vippwd.value==""){
            mui.alert('会员卡密码不能为空！');
            return false;
        }
        var wxopenid=$("#wxopenid").text();
        mui.ajax({
            url: '/wxsubscribe/bindVipHyByWxOpenid?wxopenid=' +  $("#wxopenid").text(),
            data: {vipcard: _vipcard.value, vippaswd: _vippwd.value},
            dataType: 'json',//服务器返回json格式数据
            type: 'POST',//HTTP请求类型
            timeout: 10000,//超时时间设置为10秒；
            async: true,

            //contentType: "application/json;charset=utf-8",
            // headers:{'Content-Type':'application/json'},
            success: function (data) {
                if (data.success) {
                    mui.alert(data.msg);
                    setTimeout(function () {
                        window.location.href = "/wxsubscribe/toOpenCardByWxOpenid?wxopenid=" +  $("#wxopenid").text()
                    }, 500)
                } else {
                    mui.alert(data.msg);
                }

            },
            error: function (xhr, type, errorThrown) {

            }
        });
    })

    $(function(){
        $("#toOpenCardByWxOpenid").click(function () {
            if( localStorage.wxopenid!=""){
                window.location.href="/wxsubscribe/toOpenCardByWxOpenid?wxopenid=" + $("#wxopenid").text()
            }
        })
    })
    //忘记原始密码

    $(function(){
        $("#Forget").click(function () {
            window.location.href="/view/ForgetBand"
        })
    })
</script>
</html>
