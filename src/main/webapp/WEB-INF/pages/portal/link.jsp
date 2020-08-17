<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 7Savage
  Date: 2020/2/24
  Time: 17:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>关于我页面</title>
    <!--字体图标-->
    <link href="${pageContext.request.contextPath}/static/javaex/pc/css/icomoon.css" rel="stylesheet" />
    <!--动画-->
    <link href="${pageContext.request.contextPath}/static/javaex/pc/css/animate.css" rel="stylesheet" />
    <!--骨架样式-->
    <link href="${pageContext.request.contextPath}/static/javaex/pc/css/common.css" rel="stylesheet" />
    <!--皮肤（缇娜）-->
    <link href="${pageContext.request.contextPath}/static/javaex/pc/css/skin/tina.css" rel="stylesheet" />
    <!--jquery，不可修改版本-->
    <script src="${pageContext.request.contextPath}/static/javaex/pc/lib/jquery-1.7.2.min.js"></script>
    <!--全局动态修改-->
    <script src="${pageContext.request.contextPath}/static/javaex/pc/js/common.js"></script>
    <!--核心组件-->
    <script src="${pageContext.request.contextPath}/static/javaex/pc/js/javaex.min.js"></script>
    <!--表单验证-->
    <script src="${pageContext.request.contextPath}/static/javaex/pc/js/javaex-formVerify.js"></script>

</head>

<body>
<div class="header">
    <div id="top">
        <c:import url="head.jsp"/>
    </div>
    <h1 id="big-title">友情链接</h1>
</div>

<div id="content">

    <div class="block" style="border-radius: 6px 6px 0 0;">
        <div class="grid-1-2-1">
            <div></div>
            <div id="main-content" style="min-width: 950px;margin-top: 50px;margin-bottom: 40px;">
                <div class="content-header">


                        <div class="block block2">
                            <c:forEach items="${links}" var="link" varStatus="status">
                                <div class="main">
                                    <a href="http://${link.address}" style="color: #6abaee">${link.name}</a>
                                </div>
                            </c:forEach>
                        </div>

                </div>

            </div>
            <div></div>
        </div>
    </div>

    <c:import url="footer.jsp"/>
</div>

<!--回到顶部-->
<div class="side-bar">
    <div id="goTopBtn">
        <span class="icon-arrow_upward"></span>
    </div>
</div>
</body>
<script>
    //搜素
    function search(keyWord){
        //判断关键字是否为空
        keyWord=keyWord.replace(/(^\s*)|(\s*$)/g,"");
        if (keyWord!=""){
            window.location.href="${pageContext.request.contextPath}/portal/search.action?keyWord="+keyWord;
        }
    }
    $(document).ready(function() {
        // window的高度
        var windowHeight = $(window).height();
        // header的高度
        var headerHeight = $(".header").height();
        // footer的高度
        var footerHeight = $(".footer").height();
        // 内容的高度
        var contentHeight = $("#main-content").height();
        // 差
        var diff = windowHeight - (headerHeight+(contentHeight-60)+footerHeight);
        if (diff>0) {
            $("#main-content").css("margin-bottom", diff-50+"px");
        }

        // 监听元素获得焦点事件
        $('input[type="text"]').focus(function() {
            $("#search").addClass("is-focused");
        });

        // 监听元素失去焦点事件
        $('input[type="text"]').blur(function() {
            $("#search").removeClass("is-focused");
        });
    });

    function openSearch() {
        $(".nav").hide();
        $("#search").show();
    }

    $("#close-search").click(function() {
        $("#search").hide();
        $(".nav").show();
    });

</script>
</html>
