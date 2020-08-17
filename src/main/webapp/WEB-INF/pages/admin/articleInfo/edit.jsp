<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <title>文章编辑系统</title>
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
        <span class="active">文章编辑</span>
    </div>
    <!--主体内容-->
    <!--全部主体内容-->
    <div class="list-content">
        <!--块元素-->
        <div class="block">
            <!--修饰块元素名称-->
            <div class="banner">
                <p class="tab fixed">文章编辑</p>
            </div>

            <!--正文内容-->
            <div class="main">
                <form id="form">
                    <input type="hidden" name="id" value="${id}"/>
                    <!--标题-->
                    <div class="unit clear">
                        <div class="left"><span class="required">*</span>
                            <p class="subtitle">标题</p></div>
                        <div class="right">
                            <input type="text" class="text" name="title" data-type="必填" placeholder="请输入文章标题" value="${articleInfo.title}"/>
                        </div>
                    </div>

                    <!--文章封面-->
                    <div class="unit clear">
                        <div class="left"><p class="subtitle">文章封面</p></div>
                        <div class="right">
                            <div id="container" class="file-container">
                                <div class="cover">
                                    <!--如果不需要回显图片，src留空即可-->
                                    <img class="upload-img-cover" src="${articleInfo.cover}"/>
                                    <style>
                                        .file-container .cover {
                                            width: 100px;
                                            height: 100px;
                                        }
                                        .file-container .cover img {
                                            margin: 20px auto;
                                        }
                                    </style>
                                    <input type="file" class="file" id="upload" accept="image/gif, image/jpeg, image/jpg, image/png" />
                                </div>
                                <input type="hidden" name="cover" id="cover" value="">
                            </div>
                        </div>
                    </div>

                    <!--下拉选择框-->
                    <div class="unit clear">
                        <div class="left"><p class="subtitle">所属类别</p></div>
                        <div class="right">
                            <select id="type_id" name="typeId">
                                <c:forEach items="${typeList}" var="typeInfo"  varStatus="status">
                                    <option value="${typeInfo.id}" <c:if test="${articleInfo.typeId==typeInfo.id}">selected</c:if>>${typeInfo.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <!--文本域-->
                    <div class="unit clear">
                        <div class="left"><p class="subtitle">内容</p></div>
                        <div class="right">
                            <div id="edit" class="edit-content">${articleInfo.content}</div>
                            <style>
                                .edit-editor-body .edit-body-container {
                                    height: 600px;
                                }
                            </style>
                            <input type="hidden" id="content" name="content" value="">
                            <input type="hidden" id="contentText" name="contentText" value="">
                        </div>

                    </div>


                    <!--提交按钮-->
                    <div class="unit clear" style="width: 800px;">
                        <div style="text-align: center;">
                            <!--表单提交时，必须是input元素，并指定type类型为button，否则ajax提交时，会返回error回调函数-->
                            <input type="button" id="return" class="button no" value="返回"/>
                            <input type="button" id="submit" class="button yes" value="保存"/>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
<script>
    //下拉选择事件
    javaex.select({
        id: "type_id",
        isSearch: false
    });

    javaex.edit({
        id: "edit",
        image: {
            url: "upload.json",	// 请求路径
            param: "file",		// 参数名称，Spring中与MultipartFile的参数名保持一致
            dataType: "url",	// 返回的数据类型：base64 或 url
            rtn: "rtnData",	// 后台返回的数据对象，在前台页面用该名字存储
            imgUrl: "data.imgUrl"	// 根据返回的数据对象，获取图片地址。  例如后台返回的数据为：{code: "000000", message: "操作成功！", data: {imgUrl: "/1.jpg"}}
        },
        callback: function (rtn) {
            $("#content").val(rtn.html);
            $("#contentText").val(rtn.text.substring(0,100));
        }
    });

    javaex.upload({
        type : "image",
        id : "upload",	// <input type="file" />的id
        url: "upload.json",//请求路径
        containerId : "container",	// 容器id
        param: "file",//参数名称，SSM中与MultipartFile保持一致
        dataType : "url",	// 返回的数据类型：base64 或 url
        callback : function (rtn) {
            console.log(rtn)
            //后台返回的数据
			if (rtn.code=="000000") {
				$("#container img").attr("src",rtn.data.imgUrl);
				$("#cover").val(rtn.data.imgUrl);
			} else {
				javaex.optTip({
					content : rtn.message,
					type : "error"
				});
			}
        }
    });

    $("#return").click(function () {
        history.back();
    });

    $("#submit").click(function () {
        $.ajax({
            url: "${pageContext.request.contextPath}/article/save.json",
            type: "POST",
            dataType: "json",
            data: $("#form").serialize(),
            success: function (rtn) {
                console.log(rtn.code);
                if (rtn.code==="000000"){
                    //跳转到后台
                    javaex.optTip({
                        content: rtn.message
                    })

                    //延迟加载
                    setTimeout(function () {
                        //刷新页面
                        window.location.href="${pageContext.request.contextPath}/article/listNormal.action";
                    },1000)

                }else{
                    addErrorMsg("loginName",rtn.message);
                }
            }
        })
    });
</script>

</html>
