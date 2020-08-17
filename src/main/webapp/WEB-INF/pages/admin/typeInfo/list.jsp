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
    <title>文章分类管理系统</title>
</head>
<body>

<!--导航-->
<c:import url="../head.jsp"/>
<!--主题内容-->
<div class="admin-mian">
    <!--菜单-->
    <c:import url="../menu.jsp"/>
    <div class="breadcrumb">
        <span>分类管理</span>
        <span class="divider">/</span>
        <span class="active">文章分类</span>
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
                        <button class="button blue radius-3" id="add"><span class="icon-plus"></span> 添加</button>
                        <button class="button red radius-3" id="delete"><span class="icon-close2"></span> 删除</button>
                        <button class="button green radius-3" id="save"><span class="icon-check"></span> 保存</button>
                    </div>
                </div>
                <table id="table" class="table color2">
                    <thead>
                    <tr>
                        <th class="checkbox" style="width: 20px" class="checkbox"><input type="checkbox" class="fill listen-1" /> </th>
                        <th style=" width: 30%">文章顺序</th>
                        <th>名字</th>
                    </tr>
                    </thead>
                    <tbody>

                    <c:choose>
                        <c:when test="${fn:length(list)==0}">
                            <tr>
                                <td colspan="6" style="text-align: center">暂无记录</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${list}" var="entity" varStatus="status">
                                <tr>
                                    <td><input type="checkbox" name="id" class="fill listen-1-2" value="${entity.id}" /> </td>
                                    <td ><input type="text" class="text" name="sort" data-type="正整数" error-msg="必须输入正整数" value="${entity.sort}">
                                    </td>
                                    <td><input type="text" class="text" name="name" data-type="必填" placeholder="请输入分类名称" value="${entity.name}"></td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

</body>
<script>
    var idArr=new Array();
    var sortArr=new Array();
    var nameArr=new Array();

    //动态添加tr行
    $("#add").click(function () {
        var html = '';
        html += '<tr>';
        html += '<td class="checkbox" style="width: 20px"><input type="checkbox" name="id" class="fill listen-1-2" value="" /> </td>';
        html += '<td><input type="text" class="text" name="sort" data-type="正整数" error-msg="必须输入正整数" value="${entity.sort}"></td>';
        html += '<td><input type="text" class="text" name="name" data-type="必填" placeholder="请输入分类名称" value="${entity.name}"></td>';
        html += '</tr>';
        $("#table tbody").append(html);
        //重新渲染
        javaex.render();
    });

    //保存按钮点击事件
    $("#save").click(function () {
        idArr=[];
        sortArr=[];
        nameArr=[];

        //id
        $(':checkbox[name="id"]').each(function () {
            idArr.push($(this).val());
        });
        //sort
        $(':input[name="sort"]').each(function () {
            sortArr.push($(this).val());
        });
        //name
        $(':input[name="name"]').each(function () {
            nameArr.push($(this).val());
        });

        $.ajax({
            url : "${pageContext.request.contextPath}/type/save.json",
            type: "POST",
            dataType: "json",
            traditional: "true",
            data:{
                "idArr":idArr,
                "sortArr":sortArr,
                "nameArr":nameArr
            },
            success:function (rtn) {
                if (rtn.code==="000000"){
                    javaex.optTip({
                        content: rtn.message
                    });
                    setTimeout(function () {
                        //刷新页面
                        window.location.reload();
                    }, 1000);
                }else{
                    javaex.optTip({
                        content: rtn.message
                    });
                    setTimeout(function () {
                        //刷新页面
                        window.location.reload();
                    }, 1000);
                }

            }
        })
    });

    //点击删除事件
    $("#delete").click(function () {
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
                url : "delete.json",
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
                    },2000);
                }
            })
        }
    });
</script>

</html>
