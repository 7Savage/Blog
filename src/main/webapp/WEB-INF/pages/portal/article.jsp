<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>博客内容页</title>
    <!--字体图标样式-->
    <link href="${pageContext.request.contextPath}/static/javaex/pc/css/icomoon.css" rel="stylesheet" />
    <!--动画样式-->
    <link href="${pageContext.request.contextPath}/static/javaex/pc/css/animate.css" rel="stylesheet" />
    <!--核心样式-->
    <link href="${pageContext.request.contextPath}/static/javaex/pc/css/style.css" rel="stylesheet" />
    <!--jquery，当前版本不可更改jquery版本-->
    <script src="${pageContext.request.contextPath}/static/javaex/pc/lib/jquery-1.7.2.min.js"></script>
    <!--全局动态修改-->
    <script src="${pageContext.request.contextPath}/static/javaex/pc/js/common.js"></script>
    <!--核心组件-->
    <script src="${pageContext.request.contextPath}/static/javaex/pc/js/javaex.js"></script>
    <style>
        .header{height: 500px;background-image: url(${pageContext.request.contextPath}/static/javaex/pc/images/grey.gif);background-position: center center;background-size: cover;position: relative;}.header-mask{background-color: rgba(0, 0, 0, 0.5);width: 100%;position: absolute;height: 100%;}#top{position: fixed;top: 0px;width: 100%;height: 70px;background-color: #fff;box-shadow: 0px 2px 15px rgba(0, 0, 0, 0.5);z-index: 1003;}.container{width: 1170px;height: 50px;line-height: 50px;padding: 10px;margin: 0 auto;}.footer .container a{color: #ccc;}#logo > a{font-size: 18px;color: #666;}#nav{text-align: right;}#big-title{width: 1170px;margin: 0 auto;height: 450px;line-height: 450px;text-align: center;font-size: 50px;color: #fff;position: absolute;left: 50%;margin-left: -585px;}#article-time{width: 1170px;margin: 60px auto 0;text-align: center;font-size: 20px;color: #fff;position: absolute;left: 50%;margin-left: -585px;top: 220px;}#content{margin: -60px 30px 0;-webkit-box-shadow: 0 16px 24px 2px rgba(0, 0, 0, 0.14), 0 6px 30px 5px rgba(0, 0, 0, 0.12), 0 8px 10px -5px rgba(0, 0, 0, 0.2);box-shadow: 0 16px 24px 2px rgba(0, 0, 0, 0.14), 0 6px 30px 5px rgba(0, 0, 0, 0.12), 0 8px 10px -5px rgba(0, 0, 0, 0.2);}.block{margin: 0 auto;box-shadow: none;}.img{height: 250px;margin: -15px 15px 0;}.img img{width:100%;height: 100%;border-radius: 6px;}.nav > li{display: inline-block;}.nav > li > a{font-size: 12px;margin: 0 15px;display: block;}.nav li a:link{color: #666;}.nav li:hover{background:#ededf1;}.nav li a:hover, .active > a{color: #06999e;}.nav > li:hover .classified-nav{display: block;}.classified-nav{position: absolute;top: 48px;left: -40%;z-index: 1000;display: none;float: left;min-width: 140px;padding: 5px 0;margin: 2px 0 0;font-size: 14px;text-align: center;list-style: none;background-color: #fff;-webkit-background-clip: padding-box;background-clip: padding-box;border: 1px solid #ccc;border: 1px solid rgba(0,0,0,.15);border-radius: 4px;-webkit-box-shadow: 0 6px 12px rgba(0,0,0,.175);box-shadow: 0 6px 12px rgba(0,0,0,.175);}input[type="text"]{border:none;}.search{-webkit-box-shadow: none;-moz-box-shadow: none;box-shadow: none;background-image: -webkit-gradient(linear, left top, left bottom, from(#9c27b0), to(#9c27b0)), -webkit-gradient(linear, left top, left bottom, from(#d2d2d2), to(#d2d2d2));background-image: -webkit-linear-gradient(#9c27b0, #9c27b0), -webkit-linear-gradient(#d2d2d2, #d2d2d2);background-image: linear-gradient(#9c27b0, #9c27b0), linear-gradient(#d2d2d2, #d2d2d2);border: 0;border-radius: 0;background-color: transparent;background-repeat: no-repeat;background-position: center bottom, center -webkit-calc(100% - 1px);background-position: center bottom, center calc(100% - 1px);background-size: 0 2px, 100% 1px;-webkit-transition: background 0s ease-out;transition: background 0s ease-out;height: 36px;width: 220px;}.is-focused .search{background-image: -webkit-gradient(linear, left top, left bottom, from(#06999e), to(#06999e)), -webkit-gradient(linear, left top, left bottom, from(#d2d2d2), to(#d2d2d2));background-image: -webkit-linear-gradient(#06999e, #06999e), -webkit-linear-gradient(#d2d2d2, #d2d2d2);background-image: linear-gradient(#06999e, #06999e), linear-gradient(#d2d2d2, #d2d2d2);outline: none;background-size: 100% 2px, 100% 1px;-webkit-transition-duration: 0.3s;transition-duration: 0.3s;}.active{color: #06999e;}.content-header{position: relative;}.content-header span{opacity: 0.8;font-size: 16px;}.side-bar{position: fixed; bottom: 12px; right: 10px; z-index: 999; color: #fff; min-width: 50px;}#goTopBtn{display: none;width: 50px;height: 50px;border-radius: 50%;cursor: pointer;text-align: center;background-color: #999;}#goTopBtn > span{font-size: 20px;line-height: 50px;}.block2{margin: 50px 0;font-size: 18px;color: #555;}.content-header p{position: absolute;right: 0;top: 0;color: rgba(0, 0, 0, 0.1);font-family: "Lucida Sans Unicode", "Lucida Grande", sans-serif;font-size: 25px;}
    </style>
</head>

<body>
<div class="header">
    <div class="header-mask"></div>
    <div id="top">
        <c:import url="head.jsp"/>
    </div>
    <h1 id="big-title">${articleInfo.title}</h1>
    <h4 id="article-time">${articleInfo.updateTime}</h4>
</div>

<div id="content">
    <div class="block" style="border-radius: 6px 6px 0 0;">
        <div class="grid-1-2-1">
            <div></div>
            <div id="main-content" style="min-width: 950px;margin-top: 100px;margin-bottom: 40px;">
                <div class="content-header">
                    <span class="icon-home active"><a href="${pageContext.request.contextPath}/portal/index.action">主页</a></span>
                    <span class="divider">/</span>
                    <span class="active"><a href="${pageContext.request.contextPath}/portal/type.action?typeId=${articleInfo.typeId}">${articleInfo.name}</a></span>
                    <span class="divider">/</span>
                    <span>${articleInfo.title}</span>
                    <p>${articleInfo.viewCount}</p>
                </div>

                <div class="block block2">
                    <div class="main-0">
                        <p>
                            ${articleInfo.content}
                        </p>
                    </div>
                </div>
            </div>
            <div></div>
        </div>
    </div>

    <div id="comment" class="comment"></div>


    <div class="footer" style="background: #323437;">
        <div class="grid-1-3 container">
            <div style="text-align: left;">
                <ul class="equal-4">
                    <li><a href="${pageContext.request.contextPath}/admin/link.action">友情链接</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/index.action">后台管理</a></li>
                </ul>
            </div>
            <div style="text-align: right;color: #ccc;">Powered by javaex ©2018 苏ICP备18008530号</div>
        </div>
    </div>
</div>

<!--回到顶部-->
<div class="side-bar">
    <div id="goTopBtn">
        <span class="icon-arrow_upward"></span>
    </div>
</div>
</body>
<script>

    $(document).ready(function() {
        $(".header").css("background-image", "url(${articleInfo.cover})");

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
            $("#main-content").css("margin-bottom", diff-100+"px");
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
