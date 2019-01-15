<%--
  Created by IntelliJ IDEA.
  User: jingao
  Date: 2018/9/11
  Time: 12:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <title>详情</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <link href="${pageContext.request.contextPath}/css/mui.min.css" rel="stylesheet"/>
</head>
<body>
<div>
    <%--<header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"  href="#"></a>
        <h1 class="mui-title">充值明细</h1>
    </header>--%>
    <div class="mui-content">
        <ul class="mui-table-view mui-table-view-striped mui-table-view-condensed" style="margin-top: 0">
            <li class="mui-table-view-cell">
                <div class="mui-table">
                    <div class="mui-table-cell mui-col-xs-10">
                        <p class="mui-h6 mui-ellipsis" style="font-size: 14px;">${pageModel.obj.productname}</p>
                        <p class="mui-h6 mui-ellipsis" style="font-size: 14px;">交易时间：<fmt:formatDate value="${pageModel.obj.opttime}"  type="both" /></p>
                        <p class="mui-h6 mui-ellipsis" style="font-size: 14px;">充值账号：${pageModel.obj.vipcard}</p>
                        <p class="mui-h6 mui-ellipsis" style="font-size: 14px;">交易类型：${pageModel.obj.paytype==0?'微信支付':'支付宝支付'}</p>
                        <p class="mui-h6 mui-ellipsis" style="font-size: 14px;">支付状态：${pageModel.obj.paystatus==3?'支付成功':'支付失败'}</p>
                        <p class="mui-h6 mui-ellipsis" style="font-size: 14px;">交易金额：${pageModel.obj.payamount}</p>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</div>
</body>
<script src="${pageContext.request.contextPath}/js/jquery-2.1.3.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/mui.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/vue.js" type="text/javascript"></script>

</html>
