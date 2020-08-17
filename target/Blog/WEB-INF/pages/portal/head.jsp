<%@ page import="com.savage.blog.view.PortalInfo" %>
<%--
  Created by IntelliJ IDEA.
  User: 7Savage
  Date: 2020/2/24
  Time: 9:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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



        <div class="grid-1-3 container">
            <div id="logo">
                <a href="javascript:;">7Savage的博客</a>
            </div>
            <div id="nav">
                <ul class="nav">

                    <%
                        if (session.getAttribute("portalInfo")==null){
                    %>
                    <li><a href="${pageContext.request.contextPath}/portal/login.action">登录</a></li>
                    <%
                        }else{

                    %>
                        <li><a href="#">你好，<%PortalInfo portalInfo= (PortalInfo) session.getAttribute("portalInfo"); out.print(portalInfo.getLoginName());%></a></li>
                        <li><a href="${pageContext.request.contextPath}/portal/logout.action">注销</a></li>
                        <li><a href="${pageContext.request.contextPath}/portal/star.action?id=<%=portalInfo.getId()%>">我的收藏</a></li>
                    <%
                        }
                    %>

                    <li><a href="${pageContext.request.contextPath}/portal/index.action">首页</a></li>
                    <li><a href="${pageContext.request.contextPath}/portal/recommend.action">热搜</a></li>
                    <li><a href="${pageContext.request.contextPath}/portal/comment.action">留言</a></li>
                    <li style="position: relative;">
                        <a href="javascript:;">文章目录</a>
                        <ul class="classified-nav" id="typeList">

                        </ul>
                    </li>
                    <li><a href="${pageContext.request.contextPath}/portal/about.action">关于我</a></li>
                    <li><a href="javascript:;" onClick="openSearch()"><span class="icon-search" style="font-size: 14px;"></span></a></li>
                </ul>
                <div id="search" class="hide">
						<span class="search-field-wrapper form-group">
							<input type="text" class="search" placeholder="搜索…" value=""
                                   onkeydown="if(event.keyCode===13){search(this.value);}">
						</span>
                    <span id="close-search" class="icon-close" style="font-size: 16px;"></span>
                </div>
            </div>
        </div>


<script>
    //搜素
    function search(keyWord){
        //判断关键字是否为空
        keyWord=keyWord.replace(/(^\s*)|(\s*$)/g,"");
        if (keyWord!=""){
            window.location.href="${pageContext.request.contextPath}/portal/search.action?keyWord="+keyWord;
        }
    }


    //页面一加载，就向后台请求分类的数据
    $(function () {
        $.ajax({
            url: "${pageContext.request.contextPath}/portal/getType.json",
            type: "POST",
            dataType: "json",
            data: {},
            success: function (rtn) {
                var typeList=rtn.data.typeList;
                var html='';
                for (var i = 0; i < typeList.length; i++) {
                    html+='<li><a href="${pageContext.request.contextPath}/portal/type.action?typeId='+typeList[i].id+'">'+typeList[i].name+'</a></li>';
                }
                $("#typeList").append(html);
            }
        })
    })
</script>
