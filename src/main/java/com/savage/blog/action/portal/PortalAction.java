package com.savage.blog.action.portal;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.savage.blog.service.articleInfo.ArticleInfoService;
import com.savage.blog.service.portalInfo.PortalInfoService;
import com.savage.blog.service.typeInfo.TypeInfoService;
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

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/portal")
public class PortalAction {
    private ArticleInfoService articleInfoService;
    private TypeInfoService typeInfoService;
    private UserInfoService userInfoService;
    private PortalInfoService portalInfoService;

    @Autowired
    public void setPortalInfoService(PortalInfoService portalInfoService) {
        this.portalInfoService = portalInfoService;
    }

    @Autowired
    public void setUserInfoService(UserInfoService userInfoService) {
        this.userInfoService = userInfoService;
    }

    @Autowired
    public void setTypeInfoService(TypeInfoService typeInfoService) {
        this.typeInfoService = typeInfoService;
    }

    @Autowired
    public void setArticleInfoService(ArticleInfoService articleInfoService) {
        this.articleInfoService = articleInfoService;
    }

    @RequestMapping("/index.action")
    public String index(Model model,
                        @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
                        @RequestParam(value = "pageSize", defaultValue = "6") int pageSize) {
        //pageHelper分页插件
        //只需在查询之前调用，传入当前页码，以及每一页显示多少条
        PageHelper.startPage(pageNum, pageSize);
        List<ArticleInfo> list = articleInfoService.listNormal();
        //model.addAttribute("list", list);
        PageInfo<ArticleInfo> pageInfo = new PageInfo<ArticleInfo>(list);
        model.addAttribute("pageInfo", pageInfo);
        return "portal/index";
    }

    @RequestMapping("/getType.json")
    @ResponseBody
    public Result getType() {
        List<TypeInfo> list = typeInfoService.list();
        return Result.success().add("typeList", list);
    }

    @RequestMapping("/type.action")
    public String type(
            Model model,
            @RequestParam(value = "typeId") int typeId,
            @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
            @RequestParam(value = "pageSize", defaultValue = "3") int pageSize) {
        //pageHelper分页插件
        //只需在查询之前调用，传入当前页码，以及每一页显示多少条
        PageHelper.startPage(pageNum, pageSize);
        List<ArticleInfo> list = articleInfoService.listByTypeId(typeId);
        //model.addAttribute("list", list);
        PageInfo<ArticleInfo> pageInfo = new PageInfo<ArticleInfo>(list);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("typeId",typeId);
        return "portal/listByType";
    }

    @RequestMapping("/article.action")
    public String article(Model model,@RequestParam("id")String id){
        ArticleInfo articleInfo = articleInfoService.selectById(id);
        model.addAttribute("articleInfo",articleInfo);
        return "portal/article";
    }

    @RequestMapping("/about.action")
    public String about(Model model){
        Me me = userInfoService.aboutMe();
        model.addAttribute("me",me);
        return "portal/about";

    }

    @RequestMapping("/search.action")
    public String search(
            Model model,
            @RequestParam(value = "keyWord") String keyWord,
            @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
            @RequestParam(value = "pageSize", defaultValue = "4") int pageSize) {

        //pageHelper分页插件
        //只需在查询之前调用，传入当前页码，以及每一页显示多少条
        PageHelper.startPage(pageNum, pageSize);
        List<ArticleInfo> list = articleInfoService.listByKeyWord("%"+keyWord.trim()+"%");
        //model.addAttribute("list", list);
        if (list.isEmpty()) {
            model.addAttribute("message","该关键字查询为空");
            return "error";
        }
        PageInfo<ArticleInfo> pageInfo = new PageInfo<ArticleInfo>(list);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("keyWord",keyWord);
        return "portal/search";
    }

    @RequestMapping("/error.action")
    public String error(Model model){
        model.addAttribute("message","该文章已收藏");
        return "/error";
    }

    @RequestMapping("/login.action")
    public String login(){
        return "portal/login";
    }

    @RequestMapping("/login.json")
    @ResponseBody
    public Result loginVerify(Model model,HttpServletRequest request) {
        //获取参数
        String loginName = request.getParameter("loginName");
        String password = request.getParameter("password");

        //校验参数
        if (StringUtils.isEmpty(loginName)||StringUtils.isEmpty(password))
            return Result.error("用户名、密码不能为空");


        //判断用户名密码是否正确
        PortalInfo portalInfo = portalInfoService.checkUser(loginName, password);
        if (portalInfo==null)
            return Result.error("用户名或密码不正确");
        model.addAttribute("portal",portalInfo);

        //设置session
        request.getSession().setAttribute("portalInfo",portalInfo);

        return Result.success();
    }

    @RequestMapping("/logout.action")
    public String logout(HttpServletRequest request){
        //销毁session
        request.getSession().removeAttribute("portalInfo");
        return "portal/login";
    }

    @RequestMapping("/register.action")
    public String register(){
        return "portal/register";
    }

    @RequestMapping("/register.json")
    @ResponseBody
    public Result registerVerify(Model model,HttpServletRequest request){
        //获取参数
        String registerName = request.getParameter("registerName");
        String password = request.getParameter("password");

        //校验参数
        if (StringUtils.isEmpty(registerName)||StringUtils.isEmpty(password))
            return Result.error("用户名、密码不能为空");


        //判断用户名密码是否正确
        PortalInfo portalInfo = portalInfoService.checkUser(registerName);
        if (portalInfo!=null)
            return Result.error("该用户已存在，请重新输入");

        portalInfoService.insert(registerName,password);
        return Result.success();
    }

    @RequestMapping("/recommend.action")
    public String recommend(Model model){
        List<ArticleInfo> list = articleInfoService.listRecommend();
        model.addAttribute("list", list);
        return "portal/recommend";
    }

    @RequestMapping("/addStar.action")
    public void star(Model model,HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String articleId = request.getParameter("articleId");
        String portalId = request.getParameter("portalId");
        Star star=portalInfoService.checkStar(portalId,articleId);
        if(star==null){
            portalInfoService.insertStar(portalId,articleId);
            response.sendRedirect("index.action");
        }else{
            response.sendRedirect("error.action");
        }
    }

    @RequestMapping("/star.action")
    public String star(Model model,@RequestParam(value = "id", required = false) String id){
        List<ArticleInfo> stars=portalInfoService.star(id);

        model.addAttribute("list",stars);
        return "portal/starList";
    }


    @RequestMapping("/deleteStar.action")
    public String deleteStar(Model model,HttpServletRequest request, HttpServletResponse response){
        String articleId = request.getParameter("articleId");
        String portalId = request.getParameter("portalId");
        portalInfoService.deleteStar(portalId,articleId);
        List<ArticleInfo> stars=portalInfoService.star(portalId);
        model.addAttribute("list",stars);
        return "portal/starList";
    }

    @RequestMapping("/comment.action")
    public String commentIndex(Model model){
        List<Comment> comments=portalInfoService.selectComment();
        model.addAttribute("comments",comments);
        return "portal/comment";
    }

    @RequestMapping("/comment.json")
    @ResponseBody
    public Result comment(HttpServletRequest request){
        String content = request.getParameter("comment");
        if(StringUtils.isEmpty(content))
            return Result.error("请输入留言");
        portalInfoService.insertComment(content);
        return Result.success();
    }


}
