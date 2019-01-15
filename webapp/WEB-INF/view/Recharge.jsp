<%--
  Created by IntelliJ IDEA.
  User: jingao
  Date: 2018/9/11
  Time: 11:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>会员中心</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <link href="${pageContext.request.contextPath}/css/mui.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/iconfont.css" rel="stylesheet"/>
    <style type="text/css">
        .amount{
           height: 70px;
        }
        .mui-grid-view.mui-grid-9 .mui-table-view-cell{
            padding: 8px;
        }
        .amount div{
            width: 100%;
            height: 100%;
            background: #fff;
            position: relative;
            border-radius: 5px;
        }
        .mui-input-group .mui-input-row:after{
            background-color: #ffffff;
        }
        .mui-input-group .mui-input-row {
            height: 60px;
        }
        input::-webkit-input-placeholder {
                   /* placeholder颜色  */
                    color: #aab2bd;
                }
    </style>
</head>
<body>
<div  style="background-color: #efeff4">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"  href="#"></a>
        <h1 class="mui-title">会员充值</h1>
    </header>
    <div class="mui-content">
        <div class="mui-slider">
            <div class="mui-slider-group">
                <div class="mui-slider-item" id="Recharge" style="height: auto;">
                    <form class="mui-input-group">
                        <div class="mui-input-row" style="line-height: 40px;padding-left: 12px;">
                            <span id="vipcard" style="font-size: 20px;"></span>
                            <p style="position: absolute;top: 20px;">（会员卡号）</p>
                        </div>
                        <div class="mui-input-row" style="line-height: 40px;height: 40px;padding-left: 12px;font-size: 16px;font-weight: bold;">
                            充余额
                        </div>
                        <ul class="mui-table-view mui-grid-view mui-grid-9" style="display:table;margin:0 auto;" >
                          <%--  <li class="amount mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-4" @click="chongzhi(0.01)">
                                <div>
                                    <i class="iconfont icon-xuanzhong" :style="{color:chongzhiBoolean?'#007aff':''}" style="font-weight: bold; position: absolute;top: 3px;right: 0;"></i>
                                    <span style="font-size: 17px;position: relative;top: 30%;" :style="{ color:css}">0.01元</span>
                                </div>
                            </li>--%>

                            <li class="amount mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-4" @click="chongzhi3000(3000)" >
                                <div>
                                    <i class="iconfont icon-xuanzhong" :style="{color:chongzhiBoolean3000?'#007aff':''}"style="font-weight: bold; position: absolute;top: 3px;right: 0;"></i>
                                    <span style="font-size: 17px;position: relative;top: 30%;" :style="{ color:css3000}">3000元</span>
                                </div>
                            </li>
                          <li class="amount mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-4" @click="chongzhi5000(5000)" >
                                <div>
                                    <i class="iconfont icon-xuanzhong" :style="{color:chongzhiBoolean5000?'#007aff':''}"style="font-weight: bold; position: absolute;top: 3px;right: 0;"></i>
                                    <span style="font-size: 17px;position: relative;top: 30%;" :style="{ color:css5000}">5000元</span>
                                </div>
                            </li>
                              <%--  <li class="amount mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-4" @click="chongzhi1000(10000)" >
                                  <div>
                                      <i class="iconfont icon-xuanzhong":style="{color:chongzhiBoolean1000?'#007aff':''}" style="font-weight: bold; position: absolute;top:3px;right: 0;"></i>
                                      <span style="font-size: 17px;position: relative;top: 30%;" :style="{ color:css1000}">10000元</span>
                                  </div>
                              </li>--%>
                        </ul>
                        <div class="mui-input-row" style="background: linear-gradient(rgba(115, 110, 132, 0.31), rgba(58, 58, 82, 0.21))">
                            <input type="text" class="" placeholder="请输入推荐码（非必填）" id="rcmcode" style="background-color: #fff;width: 90%;margin-left: 5%;margin-top: 9px;" maxlength="20">
                        </div>
                        <button class="mui-btn mui-btn-block mui-btn-primary" style="margin-top: 10px;"
                                data-loading-icon="mui-spinner mui-spinner-custom" data-icon-position="right" type="button" @click="launchViphyRecharge">充值
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</form>
</body>
<script src="${pageContext.request.contextPath}/js/jquery-2.1.3.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/mui.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/vue.js" type="text/javascript"></script>
<script>
    window.onload=function(){
        document.getElementById("vipcard").innerHTML=localStorage.vipcard;
    }
    var vm = new Vue({
        el: '#Recharge',
        data: {
            amount:'3000',
            chongzhiBoolean:false,
            chongzhiBoolean1000:false,
            chongzhiBoolean3000:true,
            chongzhiBoolean5000:false,
            css:'',
            css1000:'',
            css3000:'#007aff',
            css5000:''
        },
        // 在 `methods` 对象中定义方法
        methods: {
            chongzhi:function(data){
               if(vm.chongzhiBoolean){
                   vm.chongzhiBoolean=false
                   vm.chongzhiBoolean1000=false
                   vm.chongzhiBoolean3000=false
                   vm.chongzhiBoolean5000=false
                   vm.css=""
                   vm.css1000=""
                   vm.css3000=""
                   vm.css5000=""
                   vm.amount='';
               }else{
                   vm.chongzhiBoolean=true
                   vm.chongzhiBoolean1000=false
                   vm.chongzhiBoolean3000=false
                   vm.chongzhiBoolean5000=false
                   vm.css="#007aff"
                   vm.css1000=""
                   vm.css3000=""
                   vm.css5000=""
                   vm.amount=data;
               }

            },
            chongzhi1000:function(data){
                if(vm.chongzhiBoolean1000){
                    vm.chongzhiBoolean=false
                    vm.chongzhiBoolean1000=false
                    vm.chongzhiBoolean3000=false
                    vm.chongzhiBoolean5000=false
                    vm.css=""
                    vm.css1000=""
                    vm.css3000=""
                    vm.css5000=""
                    vm.amount='';
                }else{
                    vm.chongzhiBoolean=false
                    vm.chongzhiBoolean1000=true
                    vm.chongzhiBoolean3000=false
                    vm.chongzhiBoolean5000=false
                    vm.css=""
                    vm.css1000="#007aff"
                    vm.css3000=""
                    vm.css5000=""
                    vm.amount=data;
                }
            },
            chongzhi3000:function(data){
                if(vm.chongzhiBoolean3000){
                    vm.chongzhiBoolean=false
                    vm.chongzhiBoolean1000=false
                    vm.chongzhiBoolean3000=false
                    vm.chongzhiBoolean5000=false
                    vm.css=""
                    vm.css1000=""
                    vm.css3000=""
                    vm.css5000=""
                    vm.amount='';
                }else{
                    vm.chongzhiBoolean=false
                    vm.chongzhiBoolean1000=false
                    vm.chongzhiBoolean3000=true
                    vm.chongzhiBoolean5000=false
                    vm.css=""
                    vm.css1000=""
                    vm.css3000="#007aff"
                    vm.css5000=""
                    vm.amount=data;
                }
            },
            chongzhi5000:function(data){
                if(vm.chongzhiBoolean5000){
                    vm.chongzhiBoolean=false
                    vm.chongzhiBoolean1000=false
                    vm.chongzhiBoolean3000=false
                    vm.chongzhiBoolean5000=false
                    vm.css=""
                    vm.css1000=""
                    vm.css3000=""
                    vm.css5000=""
                    vm.amount='';
                }else{
                    vm.chongzhiBoolean=false
                    vm.chongzhiBoolean1000=false
                    vm.chongzhiBoolean3000=false
                    vm.chongzhiBoolean5000=true
                    vm.css=""
                    vm.css1000=""
                    vm.css3000=""
                    vm.css5000="#007aff"
                    vm.amount=data;
                }
            },
            launchViphyRecharge:function(){
                if(vm.amount!=''){

                    var viphy = new Array();
                    viphy = {
                        'amount':  vm.amount, //充值金额
                        'vipcard':  $("#vipcard").text(), //充值卡号
                        'wxopenid':  localStorage.wxopenid,
                        'rcmcode':$("#rcmcode").val()
                    };
                    mui.ajax({
                        url: '/viphy/launchViphyRecharge ',
                        data: viphy,
                        contentType: 'application/json',
                        dataType: 'json',//服务器返回json格式数据
                        type: 'POST',//HTTP请求类型
                        timeout: 10000,//超时时间设置为10秒；
                        async: true,
                        success: function (data) {
                            if(data.success){
                                WeixinJSBridge.invoke(
                                    'getBrandWCPayRequest', {
                                        appId:data.obj.appId,     //公众号名称，由商户传入
                                        timeStamp: data.obj.timeStamp, // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
                                        nonceStr: data.obj.nonceStr, // 支付签名随机串，不长于 32 位
                                        package: data.obj.packages, // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=\*\*\*）
                                        signType: data.obj.signType, // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
                                        paySign: data.obj.paySign, // 支付签名
                                    },
                                    function(res){
                                        if(res.err_msg == "get_brand_wcpay_request:ok" ){
                                            mui.alert("支付成功");
                                            setTimeout(function () {
                                                window.location.href = "/wxsubscribe/toOpenCardByWxOpenid?wxopenid=" +  localStorage.wxopenid
                                            }, 500)
                                        }
                                    });
                            }else{
                                mui.alert("支付失败");
                            }
                        },
                        error: function (data) {
                            mui.alert(data);
                        }
                    });
                }else{
                    mui.alert("请选择充值金额");
                }
            }
        }
    })

</script>
</html>
