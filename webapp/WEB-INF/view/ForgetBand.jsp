<%--
  Created by IntelliJ IDEA.
  User: jingao
  Date: 2018/9/11
  Time: 11:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>会员中心</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <link href="${pageContext.request.contextPath}/css/mui.min.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/css/iconfont.css" rel="stylesheet"/>
    <style type="text/css">
        .mui-input-group:before, .mui-input-group .mui-input-row:after{
            background: #ffffff;
        }
        .mui-table-view:after{
            background-color: #ffffff;
        }
      /*toast信息提示*/
          .mui-toast-container {
              bottom: 50% !important;
          }
        .mui-toast-message {
            opacity: 0.8;
            color: #fff;
            background-color: #333;
            width: 180px;
            padding: 10px 5px 10px 5px;
        }
        .expend {
            background-color: #fff5f5;
        }
        .showLoding{
            width: 100%;
            height: 100%;
            background: #ffffff;
            z-index: 999;
            position: absolute;
        }

    </style>
</head>
<body>
<div>
    <header class="mui-bar mui-bar-nav">
        <a class=" mui-icon mui-icon-left-nav mui-pull-left"  href="#" id="BandCard"></a>
        <h1 class="mui-title">修改密码</h1>
    </header>
    <div class="mui-content">
        <ul class="mui-table-view" style="margin-top: 0;">
            <li class="mui-table-view-cell mui-media">
                <form class="mui-input-group" id="app">
                    <div class="mui-input-row">
                        <label>卡号</label>
                        <input type="text" class="mui-input-clear" placeholder="填写会员卡号" id="vipcard"  style="border-bottom: 1px solid #ccc;" >
                    </div>
                    <div class="mui-input-row" >
                        <label>验证码</label>
                        <span id="getTelCode" style="float: right;height: 40px;line-height: 40px;border-bottom: 1px solid #ccc;;width: 30%;" >获取验证码</span>
                        <input type="number" class="" placeholder="填写验证码" id="telcode"  maxlength="6"   style=" border-bottom: 1px solid #ccc;width: 35%;">
                    </div>
                        <div class="mui-input-row" style="position: relative;">
                            <label >新密码</label>
                            <input type="password"  class="mui-input-password" placeholder="填写新密码"  minlength="6"  id="newPwd" style=" border-bottom: 1px solid #ccc;">
                        </div>
                        <div class="mui-input-row"  style="position: relative;">
                            <label>确认密码</label>
                            <input type="password" class="mui-input-password" placeholder="再次填写确认"  minlength="6"  id="confirmPwd" style=" border-bottom: 1px solid #ccc;">
                        </div>
                    <div class="mui-button-row">
                        <button class="mui-btn mui-btn-block mui-btn-primary"
                                data-loading-icon="mui-spinner mui-spinner-custom" data-icon-position="right" type="button"  id="updateVipPassByEmailCode">完成
                        </button>
                    </div>
                </form>
            </li>
        </ul>
    </div>
</div>
</body>
<script src="${pageContext.request.contextPath}/js/jquery-2.1.3.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/mui.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/vue.js" type="text/javascript"></script>
<script type="text/javascript">
    //获取短信验证码
    var timer;
    var getTelCode=document.getElementById("getTelCode");
    document.getElementById("getTelCode").addEventListener('tap',function () {
        if($("#vipcard").val()==""){
            mui.alert('请填写会员卡号！');
            return false;
        }else{

            var time = 121;
            timer = setInterval(function () {
                if (time > 0) {
                    time = time - 1;
                    getTelCode.innerHTML=time+'s后获取';
                    getTelCode.disabled=true;
                } else {
                    time = 120;
                    clearInterval(timer)
                    getTelCode.innerHTML='获取验证码';
                    getTelCode.disabled=false;
                }
            }, 1000)
            mui.ajax({
                url: '/wxsubscribe/updateVipPassSendEmail/' + $("#vipcard").val(),
                dataType: 'json',//服务器返回json格式数据
                type: 'POST',//HTTP请求类型
                timeout: 10000,//超时时间设置为10秒
                async: true,
                success: function (data) {
                    mui.toast(data.msg);

                },
                error: function (xhr, type, errorThrown) {

                }
            });
        }
    })
    var updateVipPassByEmailCode = document.getElementById("updateVipPassByEmailCode");
    updateVipPassByEmailCode.addEventListener('tap', function () {
        if ($("#vipcard").val() == "") {
            mui.alert('请填写会员卡号！');
            return false;
        }
        if ($("#telcode").val() == "") {
            mui.alert('请填写手机验证码！');
            return false;
        }
        if ($("#newPwd").val() == "") {
            mui.alert('请填写新密码！');
            return false;
        }
        if ($("#confirmPwd").val() == "") {
            mui.alert('请填写确认密码！');
            return false;
        }
        if ($("#newPwd").val() != $("#confirmPwd").val()) {
            mui.alert('两次密码不一致！');
            return false;
        }
        mui.ajax({
            url: '/wxsubscribe/updateVipPassByEmailCode/' +  $("#vipcard").val(),
            data: {newpass: $("#newPwd").val(), telcode: $("#telcode").val() },
            dataType: 'json',//服务器返回json格式数据
            type: 'POST',//HTTP请求类型
            timeout: 10000,//超时时间设置为10秒；
            async: true,
            success: function (data) {
                if(data.success){
                    mui.alert(data.msg);
                    setTimeout(function () {
                        window.location.href = "/wxsubscribe/toOpenCardByWxOpenid?wxopenid=" +  localStorage.wxopenid
                    }, 500)
                }else{
                    mui.alert(data.msg);
                    time = 120;
                    clearInterval(timer)
                    getTelCode.innerHTML='获取验证码';
                    getTelCode.disabled=false;
                }
            },
            error: function (xhr, type, errorThrown) {

            }
        });
    })
    $(function(){
        $("#BandCard").click(function () {
            window.location.href="/view/BandCard"
        })
    })


</script>
</html>
