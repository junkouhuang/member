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
    </style>
</head>
<body>
<div>
    <header class="mui-bar mui-bar-nav">
        <a class=" mui-icon mui-icon-left-nav mui-pull-left"  href="#" id="OpenCard"></a>
        <h1 class="mui-title">修改密码</h1>
    </header>
    <div class="mui-content">
        <ul class="mui-table-view" style="margin-top: 0;">
            <li class="mui-table-view-cell mui-media">
                <%-- <p class='mui-ellipsis'>你可以在此界面设置会员卡新密码或者找回会员卡原始密码</p>--%>
                <form class="mui-input-group">
                    <div class="mui-input-row">
                        <label>卡号</label>
                        <input type="text" class="mui-input-clear" placeholder="" id="vipcard"  style="border-bottom: 1px solid #ccc;color: #a8a8a8" disabled>
                    </div>
                    <div class="mui-input-row" >
                        <label>原密码</label>
                        <input type="password" class="mui-input-password" placeholder="填写原密码" id="oldPwd" minlength="6" style=" border-bottom: 1px solid #ccc;">
                    </div>
                    <div class="mui-input-row">
                        <label>新密码</label>
                        <input type="password" class="mui-input-password" placeholder="填写新密码" id="newPwd"  minlength="6"  style=" border-bottom: 1px solid #ccc;">
                    </div>
                    <div class="mui-input-row">
                        <label>确认密码</label>
                        <input type="password" class="mui-input-password" placeholder="再次填写确认" id="confirmPwd"  minlength="6"  style=" border-bottom: 1px solid #ccc;">
                    </div>
                    <div class="mui-button-row">
                        <button class="mui-btn mui-btn-block mui-btn-primary"
                                data-loading-icon="mui-spinner mui-spinner-custom" data-icon-position="right" type="button"  id="toUpDatePwd">完成
                        </button>
                    </div>
                </form>
                <div class="mui-input-row" style="text-align: center;"> <a href="#" id="Forget">忘记原始密码？</a></div>
            </li>
        </ul>
    </div>
</div>
</body>
<script src="${pageContext.request.contextPath}/js/jquery-2.1.3.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/mui.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/vue.js" type="text/javascript"></script>
<script>
    window.onload=function () {
        document.getElementById("vipcard").value=localStorage.vipcard;
    }

    var toUpDatePwd = document.getElementById("toUpDatePwd");
    toUpDatePwd.addEventListener('tap', function () {
        if ($("#oldPwd").val() == "") {
            mui.alert('请填写原密码！');
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
            url: '/wxsubscribe/updateVipPass/' + localStorage.vipcard,
            data: {newpass: $("#newPwd").val(), oldpass: $("#oldPwd").val() },
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
                    return false;
                }

            },
            error: function (xhr, type, errorThrown) {

            }
        });
    })
    //忘记原始密码

    $(function(){
        $("#Forget").click(function () {
            window.location.href="/view/Forget"
        })
    })

    $(function(){
        $("#OpenCard").click(function () {
            window.location.href = "/wxsubscribe/toOpenCardByWxOpenid?wxopenid=" +  localStorage.wxopenid
        })
    })

</script>
</html>
