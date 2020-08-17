<%@ page import="com.savage.blog.view.PortalInfo" %><%--
  Created by IntelliJ IDEA.
  User: 7Savage
  Date: 2020/2/23
  Time: 21:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <meta charset="utf-8">
    <title>博客首页</title>
    <!--字体图标样式-->
    <link href="${pageContext.request.contextPath}/static/javaex/pc/css/icomoon.css" rel="stylesheet"/>
    <!--动画样式-->
    <link href="${pageContext.request.contextPath}/static/javaex/pc/css/animate.css" rel="stylesheet"/>
    <!--核心样式-->
    <link href="${pageContext.request.contextPath}/static/javaex/pc/css/style.css" rel="stylesheet"/>
    <!--jquery，当前版本不可更改jquery版本-->
    <script src="${pageContext.request.contextPath}/static/javaex/pc/lib/jquery-1.7.2.min.js"></script>
    <!--全局动态修改-->
    <script src="${pageContext.request.contextPath}/static/javaex/pc/js/common.js"></script>
    <!--核心组件-->
    <script src="${pageContext.request.contextPath}/static/javaex/pc/js/javaex.js"></script>
    <style>
        .header {
            height: 430px;
            background: linear-gradient(45deg, #a81d84 0%, #ea396f 100%);
        }

        #top {
            position: fixed;
            top: 0px;
            width: 100%;
            height: 70px;
            background-color: #fff;
            box-shadow: 0px 2px 15px rgba(0, 0, 0, 0.5);
            z-index: 1003;
        }

        .container {
            width: 1170px;
            height: 50px;
            line-height: 50px;
            padding: 10px;
            margin: 0 auto;
        }

        .footer .container a {
            color: #ccc;
        }

        #logo > a {
            font-size: 18px;
            color: #666;
        }

        #nav {
            text-align: right;
        }

        #big-title {
            width: 1170px;
            margin: 0 auto;
            height: 430px;
            line-height: 430px;
            text-align: center;
            font-size: 46px;
            color: #fff;
        }

        #content {
            margin: -60px 30px 0;
            -webkit-box-shadow: 0 16px 24px 2px rgba(0, 0, 0, 0.14), 0 6px 30px 5px rgba(0, 0, 0, 0.12), 0 8px 10px -5px rgba(0, 0, 0, 0.2);
            box-shadow: 0 16px 24px 2px rgba(0, 0, 0, 0.14), 0 6px 30px 5px rgba(0, 0, 0, 0.12), 0 8px 10px -5px rgba(0, 0, 0, 0.2);
        }

        .block {
            margin: 0 auto;
            overflow: visible;
        }

        .block2 {
            margin-bottom: 60px;
            border-radius: 6px;
            -webkit-box-shadow: 0 16px 38px -12px rgba(0, 0, 0, 0.56), 0 4px 25px 0 rgba(0, 0, 0, 0.12), 0 8px 10px -5px rgba(0, 0, 0, 0.2);
            -moz-box-shadow: 0 16px 38px -12px rgba(0, 0, 0, 0.56), 0 4px 25px 0 rgba(0, 0, 0, 0.12), 0 8px 10px -5px rgba(0, 0, 0, 0.2);
            box-shadow: 0 16px 38px -12px rgba(0, 0, 0, 0.56), 0 4px 25px 0 rgba(0, 0, 0, 0.12), 0 8px 10px -5px rgba(0, 0, 0, 0.2);
        }

        .block2 h4 {
            margin-top: 24px;
        }

        .block2 h4 a {
            color: #06999e;
        }

        .block2 h2 {
            font-weight: normal;
            line-height: 60px;
            border-bottom: 0;
            padding-left: 0;
        }

        .block2 h2 a {
            color: #3C4858;
        }

        .block2 p {
            color: #999;
        }

        .block2 p a {
            margin-left: 10px;
            color: #23527c;
        }

        .block2 .day {
            color: #3C4858;
            margin-top: 20px;
        }

        .img {
            height: 250px;
            margin: -15px 15px 0;
        }

        .img img {
            width: 100%;
            height: 100%;
            border-radius: 6px;
        }

        .nav > li {
            display: inline-block;
        }

        .nav > li > a {
            font-size: 12px;
            margin: 0 15px;
            display: block;
        }

        .nav li a:link {
            color: #666;
        }

        .nav li:hover {
            background: #ededf1;
        }

        .nav li a:hover, .active > a {
            color: #06999e;
        }

        .nav > li:hover .classified-nav {
            display: block;
        }

        .classified-nav {
            position: absolute;
            top: 48px;
            left: -40%;
            z-index: 1000;
            display: none;
            float: left;
            min-width: 140px;
            padding: 5px 0;
            margin: 2px 0 0;
            font-size: 14px;
            text-align: center;
            list-style: none;
            background-color: #fff;
            -webkit-background-clip: padding-box;
            background-clip: padding-box;
            border: 1px solid #ccc;
            border: 1px solid rgba(0, 0, 0, .15);
            border-radius: 4px;
            -webkit-box-shadow: 0 6px 12px rgba(0, 0, 0, .175);
            box-shadow: 0 6px 12px rgba(0, 0, 0, .175);
        }

        input[type="text"] {
            border: none;
        }

        .search {
            -webkit-box-shadow: none;
            -moz-box-shadow: none;
            box-shadow: none;
            background-image: -webkit-gradient(linear, left top, left bottom, from(#9c27b0), to(#9c27b0)), -webkit-gradient(linear, left top, left bottom, from(#d2d2d2), to(#d2d2d2));
            background-image: -webkit-linear-gradient(#9c27b0, #9c27b0), -webkit-linear-gradient(#d2d2d2, #d2d2d2);
            background-image: linear-gradient(#9c27b0, #9c27b0), linear-gradient(#d2d2d2, #d2d2d2);
            border: 0;
            border-radius: 0;
            background-color: transparent;
            background-repeat: no-repeat;
            background-position: center bottom, center -webkit-calc(100% - 1px);
            background-position: center bottom, center calc(100% - 1px);
            background-size: 0 2px, 100% 1px;
            -webkit-transition: background 0s ease-out;
            transition: background 0s ease-out;
            height: 36px;
            width: 220px;
        }

        .is-focused .search {
            background-image: -webkit-gradient(linear, left top, left bottom, from(#06999e), to(#06999e)), -webkit-gradient(linear, left top, left bottom, from(#d2d2d2), to(#d2d2d2));
            background-image: -webkit-linear-gradient(#06999e, #06999e), -webkit-linear-gradient(#d2d2d2, #d2d2d2);
            background-image: linear-gradient(#06999e, #06999e), linear-gradient(#d2d2d2, #d2d2d2);
            outline: none;
            background-size: 100% 2px, 100% 1px;
            -webkit-transition-duration: 0.3s;
            transition-duration: 0.3s;
        }

        .active {
            background: #ededf1;
            color: #06999e;
        }

        .page > ul > li > a {
            height: 30px;
            padding: 0 12px;
            border-radius: 50px !important;
            color: #999999;
            background: transparent;
            font-size: 12px;
            line-height: 30px;
            border: 1px solid #eee;
        }

        .page > ul > li {
            background: transparent;
        }

        .page .active a {
            background-color: #06999e;
            border-color: #06999e;
            -webkit-box-shadow: 0 14px 26px -12 pxrgba(6, 153, 158, 0.42), 0 4px 23px 0 rgba(0, 0, 0, 0.12), 0 8px 10px -5px rgba(6, 153, 158, 0.2);
            box-shadow: 0 14px 26px -12px rgba(6, 153, 158, 0.42), 0 4px 23px 0 rgba(0, 0, 0, 0.12), 0 8px 10px -5px rgba(6, 153, 158, 0.2);
            color: #fff;
        }

        .pagination > li > a:focus, .pagination > li > a:hover {
            z-index: 2;
            border-color: #ddd;
            background: #ddd;
            color: #fff;
        }

        .pagination > .active > a, .pagination > .active > a:focus, .pagination > .active > a:hover {
            background-color: #06999e;
            border-color: #06999e;
            -webkit-box-shadow: 0 14px 26px -12 pxrgba(6, 153, 158, 0.42), 0 4px 23px 0 rgba(0, 0, 0, 0.12), 0 8px 10px -5px rgba(6, 153, 158, 0.2);
            box-shadow: 0 14px 26px -12px rgba(6, 153, 158, 0.42), 0 4px 23px 0 rgba(0, 0, 0, 0.12), 0 8px 10px -5px rgba(6, 153, 158, 0.2);
            color: #fff;
        }

        .pagination > li {
            margin-right: 10px;
        }

        .side-bar {
            position: fixed;
            bottom: 12px;
            right: 10px;
            z-index: 999;
            color: #fff;
            min-width: 50px;
        }

        #goTopBtn {
            display: none;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            cursor: pointer;
            text-align: center;
            background-color: #999;
        }

        #goTopBtn > span {
            font-size: 20px;
            line-height: 50px;
        }
    </style>
</head>

<body>

<div class="header">
    <div id="top">
        <c:import url="head.jsp"/>
    </div>
    <h1 id="big-title">技术博文</h1>
</div>

<div id="content">
    <div class="block" style="border-radius: 6px 6px 0 0;">
        <div class="grid-1-2-1">
            <div></div>
            <div id="main-content" style="min-width: 950px;margin-top: 100px;margin-bottom: 40px;">
                <c:forEach items="${pageInfo.list}" var="entity" varStatus="status">


                    <div class="block block2">
                        <div class="grid-5-7" style="height: 250px;">
                            <div class="img">
                                <img src="${entity.cover}"/>
                            </div>

                            <div class="main-15">
                                <h4>${entity.name}</h4>
                                <h2>${entity.title}</h2>
                                <p>
                                        ${entity.contentText}
                                    <a href="${pageContext.request.contextPath}/portal/article.action?id=${entity.id}">
                                        阅读更多…</a>
                                </p>
                                <div class="day">更新时间：${entity.updateTime}  &nbsp;浏览次数：${entity.viewCount}</div>
                                <br>
                                <%
                                    if (session.getAttribute("portalInfo")!=null){
                                        PortalInfo portalInfo= (PortalInfo) session.getAttribute("portalInfo");
                                %>
                                    <a href="${pageContext.request.contextPath}/portal/addStar.action?articleId=${entity.id}&portalId=<%=portalInfo.getId()%>">收藏</a>
                                <%}%>

                            </div>
                        </div>
                    </div>
                </c:forEach>


                <div class="page">
                    <ul id="page" class="pagination"></ul>
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


    $(document).ready(function () {
        // window的高度
        var windowHeight = $(window).height();
        // header的高度
        var headerHeight = $(".header").height();
        // footer的高度
        var footerHeight = $(".footer").height();
        // 内容的高度
        var contentHeight = $("#main-content").height();
        // 差
        var diff = windowHeight - (headerHeight + (contentHeight - 60) + footerHeight);
        if (diff > 0) {
            $("#main-content").css("margin-bottom", diff - 100 + "px");
        }

        // 监听元素获得焦点事件
        $('input[type="text"]').focus(function () {
            $("#search").addClass("is-focused");
        });

        // 监听元素失去焦点事件
        $('input[type="text"]').blur(function () {
            $("#search").removeClass("is-focused");
        });
    });

    function openSearch() {
        $(".nav").hide();
        $("#search").show();
    }

    $("#close-search").click(function () {
        $("#search").hide();
        $(".nav").show();
    });

    var currentPage = '${pageInfo.pageNum}';
    var pageCount = '${pageInfo.pages}';
    javaex.page({
        id: "page",	// 分页id
        pageCount: pageCount,	// 总页数
        currentPage: currentPage,	// 默认选中第几页
        position: "center",
        // 返回当前选中的页数
        callback: function (rtn) {
            console.log(rtn.pageNum);
            window.location.href = "${pageContext.request.contextPath}/portal/index.action?pageNum=" + rtn.pageNum;
        }
    });
</script>
</html>

