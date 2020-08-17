<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%--
  Created by IntelliJ IDEA.
  User: 7Savage
  Date: 2020/2/19
  Time: 17:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<meta charset="utf-8">
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
<html>
<head>
    <title>文章管理系统</title>
</head>
<body>

<!--导航-->
<c:import url="../head.jsp"/>
<!--主题内容-->
<div class="admin-mian">
    <!--菜单-->
    <c:import url="../menu.jsp"/>
    <div class="breadcrumb">
        <span>文章管理</span>
        <span class="divider">/</span>
        <span class="active">文章列表</span>
    </div>
    <!--主体内容-->
    <div class="list-content">
        <!--块元素-->
        <div class="block">
            <!--页面有多个表格时，可以用于标识表格-->
            <h2>文章列表</h2>
            <!--右上角的返回按钮-->
            <a href="javascript:history.back();">
                <button class="button indigo radius-3" style="position: absolute;right: 20px;top: 16px;"><span
                        class="icon-arrow_back"></span> 返回
                </button>
            </a>

            <!--正文内容-->
            <div class="main">
                <!--表格上方的操作元素，添加、删除等-->
                <div class="operation-wrap">
                    <div class="buttons-wrap">
                        <a href="${pageContext.request.contextPath}/article/edit.action">
                            <button class="button blue radius-3" id="add"><span class="icon-plus"></span> 添加</button>
                        </a>
                        <button class="button red radius-3" id="recycle"><span class="icon-close2"></span> 删除</button>
                    </div>
                </div>
                <table id="table" class="table color2">
                    <thead>
                    <tr>
                        <th class="checkbox" style="width: 20px" class="checkbox"><input type="checkbox" class="fill listen-1" /> </th>
                        <th style=" width: 120px">文章顺序</th>
                        <th>分类</th>
                        <th>文章标题</th>
                        <th>撰写日期</th>
                        <th>阅读量</th>
                        <th>编辑</th>
                    </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${fn:length(pageInfo.list)==0}">
                                <tr>
                                    <td colspan="7" style="text-align: center">暂无记录</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${pageInfo.list}" var="entity" varStatus="status">
                                    <tr>
                                        <td><input type="checkbox" name="id" class="fill listen-1-2" value="${entity.id}" /> </td>
                                        <td>${status.index+1}</td>
                                        <td>${entity.name}</td>
                                        <td>${entity.title}</td>
                                        <td>${entity.updateTime}</td>
                                        <td>${entity.viewCount}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/article/edit.action?id=${entity.id}">
                                                <button class="button wathet"><span class="icon-edit-2">编辑</span></button>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
                <div class="page">
                    <ul id="page" class="pagination"></ul>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
<script>
    var idArr=new Array();

    //点击回收事件
    $("#recycle").click(function () {
        idArr=[];
        //遍历所有被勾选的复选框
        $(':checkbox[name="id"]:checked').each(function () {
            //添加主键存在的记录
            var id =$(this).val();
            if (id!=""){
                idArr.push(id);
            }
        });

        //判断所勾选的是不是新增的空白记录
        if (idArr.length==0){
            $(':checkbox[name="id"]:checked').each(function () {
                //前台刷新去除新增的tr
                $(this).parent().parent().parent().remove();
            });
        }else{
            $.ajax({
                url : "recycle.json",
                type: "POST",
                dataType: "json",
                traditional: "true",
                data:{
                    "idArr":idArr
                },
                success:function (rtn) {
                    javaex.optTip({
                        content:rtn.message
                    });
                    setTimeout(function () {
                        //刷新页面
                        window.location.reload();
                    },1000);
                }
            })
        }
    });

    var currentPage='${pageInfo.pageNum}';
    var pageCount='${pageInfo.pages}';
    javaex.page({
        id : "page",
        pageCount : pageCount,	// 总页数
        currentPage : currentPage,// 默认选中第几页
        isShowJumpPage : true,	// 是否显示跳页
        position : "left",
        callback : function(rtn) {
            search(rtn.pageNum)
        }
    });

    function search(pageNum) {
        window.location.href="listNormal.action?pageNum="+pageNum;
    }

    javaex.select({
        id : "typeId",
        isSearch : true,
        // 回调函数
        callback: function (rtn) {
            console.log("selectValue:" + rtn.selectValue);
            console.log("selectName:" + rtn.selectName);
        }
    });
</script>

</html>
