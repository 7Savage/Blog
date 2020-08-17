package com.savage.blog.action.userInfo;

import com.savage.blog.service.portalInfo.PortalInfoService;
import com.savage.blog.service.userInfo.UserInfoService;
import com.savage.blog.view.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;


@Controller
@RequestMapping("/admin")
public class UserInfoAction {
    private UserInfoService userInfoService;
    @Autowired
    private PortalInfoService portalInfoService;



    @Autowired
    public void setUserInfoService(UserInfoService userInfoService) {
        this.userInfoService = userInfoService;
    }

    @RequestMapping("/index.action")
    public String index() {
        return "admin/index";
    }

    /**
     * 跳转到登录界面
     *
     * @return
     */
    @RequestMapping("/login.action")
    public String login() {
        return "admin/login";
    }

    @RequestMapping("/comment.action")
    public String comment(Model model){
        List<Comment> comments = portalInfoService.selectComment();
        model.addAttribute("comments",comments);
        return "admin/comment";
    }



    /*@responseBody注解的作用是将controller的方法返回的对象通过适当的转换器转换为指定的格式之后，
    写入到response对象的body区，通常用来返回JSON数据或者是XML数据。
        注意：在使用此注解之后不会再走视图处理器，而是直接将数据写入到输入流中，
        他的效果等同于通过response对象输出指定格式的数据。
    */
    @RequestMapping("/login.json")
    @ResponseBody
    public Result loginVerify(HttpServletRequest request) {
        //获取参数
        String loginName = request.getParameter("loginName");
        String password = request.getParameter("password");

        //校验参数
        if (StringUtils.isEmpty(loginName)||StringUtils.isEmpty(password))
            return Result.error("用户名、密码不能为空");


        //判断用户名密码是否正确
        UserInfo userInfo = userInfoService.checkUser(loginName, password);
        if (userInfo==null)
            return Result.error("用户名或密码不正确");

        //设置session
        request.getSession().setAttribute("userInfo",userInfo);

        return Result.success();
    }

    @RequestMapping("/logout.action")
    public String logout(HttpServletRequest request){
        //销毁session
        request.getSession().removeAttribute("userInfo");
        return "admin/login";
    }

    @RequestMapping("/link.action")
    public String link(Model model){
        List<Link> links=userInfoService.link();
        model.addAttribute("links",links);
        return "portal/link";
    }

    @RequestMapping("/linklist.action")
    public String linklist(Model model){
        List<Link> links=userInfoService.link();
        model.addAttribute("links",links);
        return "admin/linklist";
    }

    @RequestMapping("/saveLink.json")
    @ResponseBody
    public Result saveLink(
            @RequestParam(value = "idArr") String[] idArr,
            @RequestParam(value = "nameArr") String[] nameArr,
            @RequestParam(value = "addressArr") String[] addressArr
    ) {
        userInfoService.saveLink(idArr, nameArr, addressArr);
        return Result.success();
    }

    @RequestMapping("/delete.json")
    @ResponseBody
    public Result delete(@RequestParam(value = "idArr") String[] idArr) {

        userInfoService.delete(idArr);
        return Result.success();
    }


    @RequestMapping("/deleteComment.json")
    @ResponseBody
    public Result deleteComment(@RequestParam(value = "idArr") String[] idArr){
        userInfoService.deleteComment(idArr);
        return Result.success();
    }

}
