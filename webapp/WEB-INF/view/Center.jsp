<%--
  Created by IntelliJ IDEA.
  User: jingao
  Date: 2018/9/11
  Time: 11:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
    <title>会员中心</title>
    <meta name="viewport"content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <link href="${pageContext.request.contextPath}/css/mui.min.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/css/iconfont.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/css/mui.picker.min.css" rel="stylesheet"/>
</head>
<style  type="text/css">
    .mui-table-view:after {
        background-color: #fff;
    }
    input::-webkit-input-placeholder {
        /* placeholder颜色  */
        color: #aab2bd;
        /* placeholder字体大小  */
        font-size: 18px;

    }
    .mui-input-group:before{background: #ffffff;}
    .mui-input-group .mui-input-row:after{
        background-color: #ffffff;
    }
    #recordCard{width: 79%;margin-bottom: 5px;}
</style>
<body>
<!--图片区域-->
<div class="mui-content" >
    <p id="wxopenid" style="display: none;">${wxUser.wxopenid}</p>
    <p id="xm" style="display: none;">${wxUser.nickname}</p>
    <p id="sex" style="display: none;">${wxUser.sex}</p>
    <p id="area" style="display: none;">${wxUser.province}/${wxUser.city}</p>
    <div id="Gallery" class="mui-slider">
        <div id="slider" class="mui-slider ">
            <div class="mui-slider-group" id="vipCardId">
                <c:if test="${wxUser.viphyList!=null}">
                    <c:forEach var="item" items="${wxUser.viphyList}" varStatus="status">
                        <div class="mui-slider-item vipCardImg" style="position: relative;height: auto;padding: 10px" id="vipCardImg1">
                            <h1 style="display: none;">${item.vipcard}</h1>
                            <a href="#${item.id}" >
                                <img onclick="record()" src="${pageContext.request.contextPath}/images/slio.png" class="record-img" id="${status.index}" />
                            </a>
                            <p style="position: absolute;bottom: 10px;left: 20px;color: #ffffff;">No:${item.vipcard}</p>
                        </div>
                    </c:forEach>
                </c:if>
                <c:if test="${wxUser.viphyList==null}">
                    <div class="mui-slider-item" style="height: auto;position: relative;padding: 10px;">
                        <a href="#${item.id}" >
                            <img src="${pageContext.request.contextPath}/images/slio_gray.png" class="navMenu-img" />
                        </a>
                    </div>
                </c:if>
            </div>
            <div class="mui-slider-indicator" style="bottom: 15px;">
                <c:if test="${wxUser.viphyList!=null}">
                    <c:forEach var="item" items="${wxUser.viphyList}">
                        <div class="mui-indicator"></div>
                    </c:forEach>
                </c:if>
            </div>
        </div>
        <div class="mui-slider-group">
            <div class="mui-slider-item" style="height: auto; padding:0  10px;">
                <ul class="mui-table-view mui-grid-view mui-grid-9"  style="background: #f7f7f7">
                    <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-4">
                        <a href="#" id="CenterOpenCard">
                            <span class="iconfont icon-danweijiesuanqiakai"></span>
                            <div class="mui-media-body" style=" margin-top: 12px;">开卡</div>
                        </a>
                    </li>
                    <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-4">
                        <a href="#" id="CenterBandCard">
                            <span class="iconfont icon-bangding"></span>
                            <div class="mui-media-body" style=" margin-top: 12px;">会员绑定</div>
                        </a>
                    </li>
                    <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-4">
                    <a href="#" id="Recharge">
                        <span class="iconfont icon-paichu"></span>
                        <div class="mui-media-body" style=" margin-top: 12px;">充值</div>
                    </a>
                    </li>
                    <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-4" >
                        <a href="#" id="ViphyRecharageHistoryPageList">
                            <span class="iconfont icon-chongzhi"></span>
                            <div class="mui-media-body" style=" margin-top: 12px;">充值记录</div>
                        </a>
                    </li>
                    <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-4">
                        <a href="#" id="Record">
                            <span class="iconfont icon-xiaofeijilu-lan"></span>
                            <div class="mui-media-body" style=" margin-top: 12px;">消费记录</div>
                        </a>
                    </li>
                    <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-4">
                        <a href="#" id="UpdatePwd">
                            <span class="iconfont icon-xiugai" style="font-weight: bold;"></span>
                            <div class="mui-media-body" style=" margin-top: 12px;">修改密码</div>
                        </a>
                    </li>
                    <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-4">
                        <a href="#" id="UnBand">
                            <span class="iconfont icon-jiebang"></span>
                            <div class="mui-media-body" style=" margin-top: 12px;">解绑</div>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
<!--卡详情-->
<c:forEach var="item" items="${wxUser.viphyList}">
    <div id="${item.id}" class="mui-modal">
        <header class="mui-bar mui-bar-nav">
            <%--<a class="mui-icon mui-icon-compose mui-pull-left " href="#${item.id}0"></a>--%>
            <a class="mui-icon mui-icon-close mui-pull-right " href="#${item.id}"></a>
        </header>
        <div class="mui-content" style="height: 100%;">
            <div class="mui-scroll-wrapper">
                <div class="mui-scroll">
                    <ul class="mui-table-view" style="margin-top:55px;">
                        <li class="mui-table-view-cell">
                            户名: <span>${item.xm}</span>
                        </li>
                        <li class="mui-table-view-cell">
                            性别: <span>${item.xb}</span>
                        </li>
                        <li class="mui-table-view-cell">
                            地区: <span>${item.province}${item.city}</span>
                        </li>
                        <li class="mui-table-view-cell">
                            电话: <span>${item.lxdh}</span>
                        </li>
                    </ul>
                    <ul class="mui-table-view" style="margin-top: 10px;">
                        <li class="mui-table-view-cell">
                            卡号: <span>${item.vipcard}</span>
                        </li>
                        <li class="mui-table-view-cell">
                            开卡时间: <span><fmt:formatDate value="${item.createdate}" type="both"/></span>
                        </li>
                        <li class="mui-table-view-cell">
                            余额: <span>${item.money}</span>
                        </li>
                        <li class="mui-table-view-cell">
                            积分:<span>${item.jf}</span>
                        </li>
                    </ul>
                    <div style="margin-top: 12px;text-align: center;background-color: #ffffff;">
                        <img class="barcode"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="${item.id}0" class="mui-modal">
        <header class="mui-bar mui-bar-nav">
            <a class="mui-icon mui-icon-checkmarkempty mui-pull-left next " id="${item.id}3"></a>
            <a class="mui-icon mui-icon-closeempty mui-pull-right " href="#${item.id}0"></a>
        </header>
        <div class="mui-content" style="height: 100%;">
            <div class="mui-scroll-wrapper">
                <div class="mui-scroll">

                    <ul class="mui-table-view" style="margin-top:55px;">
                        <li class="mui-table-view-cell">
                            户名: <input value="${item.xm}" class="mui-input-clear xm" style="border: none;"
                                       maxlength="16" >
                        </li>
                        <li class="mui-table-view-cell">
                            <div class="mui-input-row">
                                性别:
                                <c:choose>
                                    <c:when test="${item.xb!=''}"><a class="mui-navigate-right  classSex"
                                                                     style="color: #333333;display: inline-block;width: 60%;"
                                                                     id="${item.id}1">${item.xb}</a></c:when>
                                    <c:otherwise><a class="mui-navigate-right  classSex"
                                                    style="color: #333333;display: inline-block;width: 60%;"
                                                    id="${item.id}4">请选择性别</a></c:otherwise>
                                </c:choose>
                            </div>
                        </li>
                        <li class="mui-table-view-cell">
                            <div class="mui-input-row">
                                地区:
                                <c:choose>
                                    <c:when test="${item.province!=''}"><a class="mui-navigate-right  classRegion"
                                                                           style="color: #333333;display: inline-block;width: 60%;"
                                                                           id="${item.id}2">${item.province}/${item.city}</a></c:when>
                                    <c:otherwise><a class="mui-navigate-right  classRegion"
                                                    style="color: #333333;display: inline-block;width: 60%;"
                                                    id="${item.id}4">请选择省/市</a></c:otherwise>
                                </c:choose>
                            </div>
                        </li>
                        <li class="mui-table-view-cell">
                            电话: <input value="${item.lxdh}" class="mui-input-clear lxdh" style="border: none;"
                                       maxlength="11">
                        </li>
                    </ul>
                    <ul class="mui-table-view" style="margin-top: 10px;">
                        <li class="mui-table-view-cell">
                            卡号: <span class="vipcard">${item.vipcard}</span>
                        </li>
                        <li class="mui-table-view-cell">
                            开卡时间: <span><fmt:formatDate value="${item.createdate}" type="both"/></span>
                        </li>
                        <li class="mui-table-view-cell">
                            余额: <span>${item.money}</span>
                        </li>
                        <li class="mui-table-view-cell">
                            积分:<span>${item.jf}</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</c:forEach>
</body>
</html>
<script src="${pageContext.request.contextPath}/js/jquery-2.1.3.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/JsBarcode v3.8.0.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/mui.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/mui.picker.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/city.data-3.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/vue.js" type="text/javascript"></script>
<script type="text/javascript">
    //第一个圆点默认为活动状态
    window.onload = function () {
        document.getElementsByClassName("mui-indicator")[0].setAttribute("class", "mui-indicator mui-active");
        document.getElementsByClassName("vipCardImg")[0].setAttribute("class", "mui-slider-item vipCardImg mui-active")
        localStorage.wxopenid=document.getElementById("wxopenid").innerHTML;
        localStorage.nickname=document.getElementById("xm").innerHTML;
        localStorage.sex=document.getElementById("sex").innerHTML==1?'男':'女';
        localStorage.area=document.getElementById("area").innerHTML;
    }
</script>
<!--一维码生成器-->
<script type="text/javascript">
    var barcode = document.getElementsByClassName('barcode');
    var cards = document.getElementsByClassName('vipcard');
    var options = {
        format: "CODE128",
        displayValue: true,
        fontSize: 18,
        height: 100
    };
    for (var i = 0; i < cards.length; i++) {
        JsBarcode(barcode[i], cards[i].innerHTML, options); //原生
    }
</script>
<!--修改卡信息-->
<script type="text/javascript">
    document.querySelector('.mui-slider').addEventListener('slide', function(event) {
        //注意slideNumber是从0开始的；
        console.log(event.detail.slideNumber+1);
    });
    var sexPicker = new mui.PopPicker();
    mui('body').on('tap', '.classSex', function (e) {
        //var picker = new mui.PopPicker();
        sexPicker.setData([{value: 'man', text: '男'}, {value: 'woman', text: '女'}])
        sexPicker.show(function (selectItems) {
            document.getElementById(e.target.id).innerHTML = selectItems[0].text;
            sex = selectItems[0].text;
        });
    })
    var addressPicker = new mui.PopPicker({
        //只显示两层省、市
        layer: 2
    });
    mui('body').on('tap', '.classRegion', function (e) {
        //显示几层，我们要显示省、市、区，所以我们这里写三层，如果不写默认是一层
        addressPicker.setData(cityData3);
        //city.data-3.js中的数据
        addressPicker.show(function (selectItems) {
            //将选择的省、市、区显示到屏幕上
            var adressStr = '';
            for (var i = 0; i < selectItems.length; i++) {
                adressStr = province + "/" + city;
                province = selectItems[0].text;
                city = selectItems[1].text;
            }
            document.getElementById(e.target.id).innerHTML = adressStr;
        });
    })
    //修改卡信息
    var xm;//户名
    var sex;//性别
    var province;//省份
    var city;//城市
    var tel;//电话
    $(function () {
        $(".next").click(function () {
            var updId = $(this).attr("id");
            xm = $("#" + updId).parent("header").siblings("div").find(".xm").val()
            if (xm == "") {
                mui.alert('请填写姓名！');
                return false;
            }
            xb = $("#" + updId).parent("header").siblings("div").find(".classSex").text()
            if (xb == "请选择性别") {
                mui.alert('请选择性别！');
                return false;
            }
            var index = $("#" + updId).parent("header").siblings("div").find(".classRegion").text().indexOf('/')
            var length = $("#" + updId).parent("header").siblings("div").find(".classRegion").text().length;
            var province = $("#" + updId).parent("header").siblings("div").find(".classRegion").text().substring(0, index);//省份
            var city = $("#" + updId).parent("header").siblings("div").find(".classRegion").text().substring(index + 1, length);//城市
            if (province == "请选择省/市/区(县)") {
                mui.alert('请选择省市区！');
                return false;
            }
            lxdh = $("#" + updId).parent("header").siblings("div").find(".lxdh").val()
            if (lxdh == "") {
                mui.alert('请填写联系电话！');
                return false;
            }
            if (!(/^1[345678]\d{9}$/.test(lxdh))) {
                mui.alert('手机号码格式有误！');
                return false;
            }
            vipcard = $("#" + updId).parent("header").siblings("div").find(".vipcard").text()
            var viphy = new Array();
            viphy = {
                'xm': xm,
                'xb': xb,
                'lxdh': lxdh,
                'province': province,
                'city': city,
                'vipcard': vipcard
            };
            mui.ajax({
                url: '/wxsubscribe/prefectViphyInfo',
                data: viphy,
                dataType: 'json',//服务器返回json格式数据
                type: 'POST',//HTTP请求类型
                timeout: 10000,//超时时间设置为10秒；
                async: true,
                success: function (data) {
                    mui.alert(data.msg);
                    var wxopenid = document.getElementById("wxopenid").innerHTML;
                    setTimeout(function () {
                        window.location.href = "${pageContext.request.contextPath}/wxsubscribe/toOpenCardByWxOpenid?wxopenid=" + wxopenid;
                        document.activeElement.blur()
                    }, 500)
                },
                error: function (xhr, type, errorThrown) {
                }
            });
        })
    })
</script>
<!--开卡-->
<script type="text/javascript">
    var CenterOpenCard=document.getElementById("CenterOpenCard");
    CenterOpenCard.addEventListener('tap', function () {
        window.location.href="/view/CenterOpenCard"
    })
</script>
<!--绑定-->
<script type="text/javascript">
    var CenterBandCard=document.getElementById("CenterBandCard");
    CenterBandCard.addEventListener('tap', function () {
        window.location.href="/view/CenterBandCard"
    })
</script>
<!--充值-->
<script type="text/javascript">
    var Recharge=document.getElementById("Recharge");
    Recharge.addEventListener('tap', function () {
        window.location.href="/wxsubscribe/toViphyRechargeView"
        localStorage.vipcard=$("#vipCardId .mui-active h1").text();
    })
</script>
<!--充值记录-->
<script type="text/javascript">
    var Recharge=document.getElementById("ViphyRecharageHistoryPageList");
    Recharge.addEventListener('tap', function () {
        window.location.href="/view/ViphyRecharageHistoryPageList"
        localStorage.vipcard=$("#vipCardId .mui-active h1").text();
    })
</script>

<!--消费记录-->
<script type="text/javascript">
    var Record=document.getElementById("Record");
    Record.addEventListener('tap', function () {
        window.location.href="/view/Record"
        localStorage.vipcard=$("#vipCardId .mui-active h1").text();
    })
</script>
<!--修改会员卡密码-->
<script type="text/javascript">
    var UpdatePwd=document.getElementById("UpdatePwd");
    UpdatePwd.addEventListener('tap', function () {
        window.location.href="/view/UpdatePwd"
        localStorage.vipcard=$("#vipCardId .mui-active h1").text();
    })
</script>
<!---解绑-->
<script type="text/javascript">
    var UnBand=document.getElementById("UnBand");
    UnBand.addEventListener('tap', function () {
        var btnArray = ['否', '是'];
        mui.confirm('解绑后，将无法在公众号中对会员卡进行操作，也收不到会员卡消费充值通知', '是否解绑当前会员卡？', btnArray, function(e) {
            if (e.index == 1) {
                mui.ajax({
                    url: '/wxsubscribe/untieViphyByWxOpenid/' + $("#vipCardId .mui-active h1").text(),
                    dataType: 'json',//服务器返回json格式数据
                    type: 'POST',//HTTP请求类型
                    timeout: 10000,//超时时间设置为10秒；
                    async: true,
                    success: function (data) {
                        mui.alert(data.msg);
                        setTimeout(function () {
                            window.location.href = "/wxsubscribe/toViphyListByWxOpenid?wxopenid=" + localStorage.wxopenid;
                        }, 500)
                    },
                    error: function (xhr, type, errorThrown) {

                    }
                });
            }
        })
    })
</script>