<%--
  Created by IntelliJ IDEA.
  User: jingao
  Date: 2018/9/11
  Time: 12:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>会员中心</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <link href="${pageContext.request.contextPath}/css/mui.min.css" rel="stylesheet"/>
    <style type="text/css">
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
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"  href="#"></a>
        <h1 class="mui-title">充值记录</h1>
    </header>
    <div class="mui-content">
        <div class="mui-input-row" style="line-height: 40px;text-align: center;">
            <span id="vipcard" style="font-size: 20px;"></span>
            <span>（会员卡号）</span>
        </div>
        <div class="mui-scroll" id="vipHistoryList">
            <template v-if="items.length>0">
                <ul class="mui-table-view mui-table-view-striped mui-table-view-condensed"
                    style="width: 100%; overflow: auto;border-bottom: 1px solid #f9f3f3;"
                    v-bind:style="{height: clientHeight}">
                    <li class="mui-table-view-cell" v-for="item in items">
                        <div class="mui-table"  v-bind:class="{expend:item.je<0}">
                            <div class="mui-table-cell mui-col-xs-10">
                                <h5 class="mui-ellipsis">充值时间：{{ item.createdate| formatDate }} </h5>
                                <h5>支付流水号：{{item.payinfocode}} </h5>
                                <h5>金额：{{item.recharge}}</h5>
                                <h5>备注：{{item.bz}}</h5>
                            </div>
                        </div>
                    </li>
                </ul>
            </template>
            <template v-else>
                <ul class="mui-table-view mui-table-view-striped mui-table-view-condensed">
                    <li class="mui-table-view-cell">
                        <div class="mui-table">
                            <div class="mui-table-cell mui-col-xs-10" style="text-align: center;">
                                <h5>暂无充值记录~~</h5>
                            </div>
                        </div>
                    </li>
                </ul>
            </template>
            <div class="mui-content-padded" v-bind:style="{display: isDisplay}">
                <ul class="mui-pager">
                    <li id="pre"><span class="cssPrev"> 上一页 </span></li>
                    <li id="next"><span class="cssNext">下一页</span></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="showLoding">
        <img src="${pageContext.request.contextPath}/images/loading.gif" style="position: absolute;top: 40%; left: 50%;margin-left: -20px;"/>
    </div>
</div>
</body>
<script src="${pageContext.request.contextPath}/js/jquery-2.1.3.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/mui.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/vue.js" type="text/javascript"></script>
<script type="text/javascript">
    window.onload=function(){
        document.getElementById("vipcard").innerHTML=localStorage.vipcard;
        getViphyRecharageHistoryPageList();
    }
    //获取会员卡消费信息
    var pageNum = 1;
    var pages;
    var clientHeight = document.body.clientHeight;
    var vm = new Vue({
        el: '#vipHistoryList',
        data: {
            items: [],
            clientHeight: clientHeight - 155,
            isDisplay: 'none',
            cssPrev: 'mui-disabled',
            cssNext: ''
        },
        filters:{
            formatDate:function (val) {
                var value=new Date(val);
                var year=value.getFullYear();
                var month=padDate(value.getMonth()+1);
                var day=padDate(value.getDate());
                var hour=padDate(value.getHours());
                var minutes=padDate(value.getMinutes());
                var seconds=padDate(value.getSeconds());
                return year+'-'+month+'-'+day+' '+hour+':'+minutes+':'+seconds;
            }
        },

    })

    var padDate=function(va){
        va=va<10?'0'+va:va;
        return va
    }
    var pre = document.getElementById("pre");
    var next = document.getElementById("next");
    pre.addEventListener('tap', function () {
        if (pageNum > 1) {
            pageNum = pageNum - 1;
            vm.cssPrev = '';
            vm.cssNext = '';
        } else {
            mui.toast("当前已经是第一页");
            vm.cssPrev = 'mui-disabled';
            vm.cssNext = '';
            pageNum = 1;
        }
        getViphyRecharageHistoryPageList();
    })
    next.addEventListener('tap', function () {
        if (pageNum < pages) {
            pageNum = pageNum + 1;
            vm.cssPrev = '';
            vm.cssNext = '';
        } else {
            mui.toast("当前已经是最后一页");
            pageNum = pages;
            vm.cssPrev = '';
            vm.cssNext = 'mui-disabled';
        }
        getViphyRecharageHistoryPageList();
    })
    function getViphyRecharageHistoryPageList() {
        mui.ajax({
            url: '/viphy/getViphyRecharageHistoryPageList' ,//+ document.getElementById("vipcard").innerHTML,
            dataType: 'json',//服务器返回json格式数据
            data: {vipcard: document.getElementById("vipcard").innerHTML,pageNum: pageNum, pageSize: 5},
            type: 'POST',//HTTP请求类型
            timeout: 10000,//超时时间设置为10秒；
            async: true,
            success: function (data) {
                console.log(data);
                $(".showLoding").hide();
                if (data.list.length > 0) {
                    pages = data.pages
                    vm.items = data.list
                    vm.isDisplay = 'block';
                } else {
                    vm.items = []
                    vm.isDisplay = 'none';
                    mui.toast("暂无检索到数据");
                }
            },
            error: function (xhr, type, errorThrown) {

            }
        });
    }
</script>
</html>
