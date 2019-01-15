<%--
  Created by IntelliJ IDEA.
  User: jingao
  Date: 2018/9/11
  Time: 12:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <title>会员开卡</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <link href="${pageContext.request.contextPath}/css/mui.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/mui.picker.min.css" rel="stylesheet" />
</head>
<body>
<div class="mui-content">
    <p style="display: none" id="wxopenid">${wxopenid}</p>
    <form class="feedback">
        <ul class="mui-table-view">
            <div class="mui-input-row">
                <label><i style="color: red;">*</i>姓名</label>
                <input type="text" class="mui-input-clear" placeholder="填写姓名" name="username" id="xm" value="${wxUser.nickname}" maxlength="10"/>
            </div>
        </ul>
        <ul class="mui-table-view">
            <div class="mui-input-row">
                <label><i style="color: red;">*</i>性别</label>
                <li class="mui-table-view-cell">
                    <c:choose>
                        <c:when test="${wxUser.sex!=''}"><a class="mui-navigate-right" id="sex">${wxUser.sex==1?'男':'女'}</a></c:when>
                        <c:otherwise><a class="mui-navigate-right" id="sex">请选择性别</a></c:otherwise>
                    </c:choose>
                </li>
            </div>
        </ul>
        <ul class="mui-table-view">
            <div class="mui-input-row">
                <label>身份证</label>
                <input type="text" class="mui-input-clear" placeholder="填写身份证" id="idcard" value="${wxUser.idcard}" maxlength="18"/>
            </div>
        </ul>
        <ul class="mui-table-view">
            <div class="mui-input-row">
                <label><i style="color: red;">*</i>生日</label>
                <li class="mui-table-view-cell">
                    <a class="mui-navigate-right"   data-options='{"type":"date"}' id="birthdate">请选择生日</a>
                </li>
            </div>
        </ul>
        <ul class="mui-table-view">
            <div class="mui-input-row">
                <label><i style="color: red;">*</i>省/市</label>
                <li class="mui-table-view-cell">
                    <c:choose>
                        <c:when test="${wxUser.province!=''}"><a class="mui-navigate-right" id="region">${wxUser.province}/${wxUser.city}</a></c:when>
                        <c:otherwise><a class="mui-navigate-right" id="region">请选择省/市</a></c:otherwise>
                    </c:choose>
                </li>
            </div>
        </ul>
        <ul class="mui-table-view">
            <div class="mui-input-row">
                <label><i style="color: red;">*</i>密码</label>
                <input type="password" class="mui-input-password" placeholder="填写密码" id="vippass" value="" minlength="6"/>
            </div>
        </ul>
        <ul class="mui-table-view">
            <div class="mui-input-row">
                <label><i style="color: red;">*</i>确认密码</label>
                <input type="password" class="mui-input-password" placeholder="填写确认密码" id="confirmpass" value="" minlength="6"/>
            </div>
        </ul>
        <ul class="mui-table-view">
            <div class="mui-input-row">
                <label><i style="color: red;">*</i>手机号</label>
                <input type="number" class="mui-input-clear" placeholder="填写手机号" id="tel" value="${wxUser.tel}" maxlength="11"/>
            </div>
        </ul>
        <div class="mui-input-row" style="background-color: #ffffff;">
            <label><i style="color: red;">*</i>验证码</label>
            <button type="button" class="mui-btn mui-btn-primary " style="width:25%;margin-right:1px;margin-top: 1px;padding: 10px 1px;border-radius: 0" id="getCode">获取验证码</button>
            <input id='vericode' type="number" class=" mui-input" placeholder="填写验证码" style="width:35%;" maxlength="6"/>
        </div>
        <div style="margin-top: 10px;">
            <button class="mui-btn mui-btn-block mui-btn-primary"  id="next" data-loading-icon="mui-spinner mui-spinner-custom" data-icon-position="right" type="button">下一步</button>
        </div>
        <p class=""><i class="mui-icon mui-icon-info" style="font-size: 20px;"></i>温馨提醒：一个手机号只能开通一张会员卡</p>
    </form>
</div>
<div class="mui-input-row" style="text-align: center;"> <a href="#" id="toBandCardByWxopenid">已有会员卡，去绑卡</a></div>
</body>
<script src="${pageContext.request.contextPath}/js/jquery-2.1.3.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/JsBarcode v3.8.0.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/mui.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/mui.picker.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/city.data-3.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/vue.js" type="text/javascript"></script>
<script>
    var xm=document.getElementById("xm"); //姓名
    var sex = document.getElementById('sex'); //性别
    var idcard=document.getElementById("idcard"); //身份证号
    var tel=document.getElementById('tel'); //手机号
    var vericode=document.getElementById('vericode');//短信验证码
    var birthdate=document.getElementById('birthdate'); //诞辰
    var csyear;//出生年份
    var csriqi;//出生月份
    var region=document.getElementById('region');//地区
    var index=document.getElementById('region').innerHTML.indexOf('/')
    var length=document.getElementById('region').innerHTML.length;
    var province=document.getElementById('region').innerHTML.substring(0,index);//省份
    var city=document.getElementById('region').innerHTML.substring(index+1,length);//城市
    var vippass=document.getElementById('vippass');//密码
    var confirmpass=document.getElementById('confirmpass');//确认密码
    var wxopenid=document.getElementById('wxopenid').innerHTML; //openid
    var getCode= document.getElementById('getCode');//获取验证码
    var next=document.getElementById("next");//确定按钮

    //获取短信验证码ajax
    var timer;
    getCode.addEventListener('tap',function() {
        if(tel.value==""){
            mui.alert('请输入手机号码！');
            return false;
        }
        var time=121;
        timer=setInterval(function(){
            if(time>0){
                time=time-1;
                getCode.innerHTML=time+'s后获取';
                getCode.disabled=true;
            }else{
                time=120;
                clearInterval(timer)
                getCode.innerHTML='获取验证码';
                getCode.disabled=false;
            }
        },1000)
        mui.ajax({
            url:'/wxsubscribe/wxOpenCardSendMsg/'+tel.value,
            dataType:'json',//服务器返回json格式数据
            type:'get',//HTTP请求类型
            timeout:10000,//超时时间设置为10秒；
            //headers:{'Content-Type':'application/json'},
            success:function(data){
                //服务器返回响应，根据响应结果，分析是否登录成功；
                mui.toast(data.msg)
                if(!data.success){
                    mui.alert(data.msg);
                    time=120;
                    clearInterval(timer)
                    getCode.innerHTML='获取验证码';
                    getCode.disabled=false;
                }
            },
            error:function(xhr,type,errorThrown){
                //异常处理；
                console.log(type);
            }
        });
    })
    //下一步
    next.addEventListener('tap',function(){
        if(xm.value==""){
            mui.alert('请填写姓名！');
            return false;
        }
        if(sex.innerHTML=="请选择性别"){
            mui.alert('请选择性别！');
            return false;
        }
       /* if(idcard.value==""){

            mui.alert('请输入身份证！');
            return false;
        }*/
        if(birthdate.innerHTML=="请选择生日"){
            mui.alert('请选择生日！');
            return false;
        }
        if(region.innerHTML=="请选择省/市/区(县)"){
            mui.alert('请选择省市区！');
            return false;
        }
        if(vippass.value==""){
            mui.alert('请填写密码！');
            return false;
        }
        if(confirmpass.value==""){
            mui.alert('请填写确认密码！');
            return false;
        }
        if(vippass.value!=confirmpass.value){
            mui.alert('两次密码不正确！');
            return false;
        }
        if(tel.value==""){
            mui.alert('请输入手机号码！');
            return false;
        }

        if(vericode.value==""){
            mui.alert('请输入短信验证码！');
            return false;
        }
        var viphy=new Array();
        viphy={
            'xm':xm.value,
            'xb':sex.innerHTML,
            'passport':idcard.value,
            'lxdh':tel.value,
            'verificationCode':vericode.value,
            'csyear':csyear,
            'csriqi':csriqi,
            'province':province,
            'city':city,
            'vippass':vippass.value
        };
        mui.ajax({
            url:'/wxsubscribe/viphyOpenCard?wxopenid='+wxopenid,
            data:JSON.stringify(viphy),
            dataType:'json',//服务器返回json格式数据
            type:'POST',//HTTP请求类型
            timeout:10000,//超时时间设置为10秒；
            async:true,
            contentType: "application/json;charset=utf-8",
           // headers:{'Content-Type':'application/json'},
            success:function(data){
                if (data.success) {
                    mui.alert(data.msg);
                    if(data.success){
                        setTimeout(function () {
                            window.location.href="/wxsubscribe/toOpenCardByWxOpenid?wxopenid=" +   $("#wxopenid").text()
                        }, 500)
                    }
                } else {
                    mui.alert(data.msg);
                }
            },
            error:function(xhr,type,errorThrown){

            }
        });
    })
    //性别
    sex.addEventListener('tap',function(){
        var picker = new mui.PopPicker();
        picker.setData([{value:'man',text:'男'},{value:'woman',text:'女'}])
        picker.show(function(selectItems){
            sex.innerHTML = selectItems[0].text;
        });
    });
    //诞辰
    var picker = new mui.DtPicker({
        type: "date",//设置日历初始视图模式
        beginDate: new Date(1949, 04, 25),//设置开始日期
        endDate: new Date(2200, 04, 25)//设置结束日期
    })
    birthdate.addEventListener('tap', function() {
        picker.show(function(rs) {
            birthdate.innerHTML =  rs.text;
            csyear=rs.y.text;
            csriqi=rs.m.text;
            picker.dispose();
        });
    }, false);

    //地区
    //显示几层，我们要显示省、市、区，所以我们这里写三层，如果不写默认是一层
    var addressPicker = new mui.PopPicker({
        layer: 2
    });
    region.addEventListener('tap', function () {
        var adressStr = '';
        addressPicker.setData(cityData3);
        //city.data-3.js中的数据
        addressPicker.show(function (selectItems) {
            //将选择的省、市、区显示到屏幕上
            for (var i = 0; i < selectItems.length; i++) {
                adressStr += selectItems[i].text;
                province=selectItems[0].text;
                city=selectItems[1].text;
            }
            region.innerHTML = adressStr;
        });
    })
    $(function(){
        $("#toBandCardByWxopenid").click(function () {
            window.location.href="/wxsubscribe/toBandCardByWxopenid?wxopenid="+$("#wxopenid").text();
            localStorage.wxopenid=$("#wxopenid").text();
        })
    })
</script>
</html>
