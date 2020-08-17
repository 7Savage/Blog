package com.savage.blog.action.articleInfo;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.savage.blog.service.articleInfo.ArticleInfoService;
import com.savage.blog.service.typeInfo.TypeInfoService;
import com.savage.blog.view.ArticleInfo;
import com.savage.blog.view.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/article")
public class ArticleInfoAction {
    private ArticleInfoService articleInfoService;
    private TypeInfoService typeInfoService;

    @Autowired
    public void setTypeInfoService(TypeInfoService typeInfoService) {
        this.typeInfoService = typeInfoService;
    }

    @Autowired
    public void setArticleInfoService(ArticleInfoService articleInfoService) {
        this.articleInfoService = articleInfoService;
    }

    @RequestMapping("/listNormal.action")
    public String listNormal(Model model,
                             @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
                             @RequestParam(value = "pageSize", defaultValue = "10") int pageSize) {

        //pageHelper分页插件
        //只需在查询之前调用，传入当前页码，以及每一页显示多少条
        PageHelper.startPage(pageNum,pageSize);
        List<ArticleInfo> list = articleInfoService.listNormal();
        //model.addAttribute("list", list);
        PageInfo<ArticleInfo> pageInfo = new PageInfo<ArticleInfo>(list);
        model.addAttribute("pageInfo",pageInfo);
        return "admin/articleInfo/articleList";
    }

    @RequestMapping("/listRecycle.action")
    public String listRecycle(Model model,
                             @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
                             @RequestParam(value = "pageSize", defaultValue = "10") int pageSize) {

        //pageHelper分页插件
        //只需在查询之前调用，传入当前页码，以及每一页显示多少条
        PageHelper.startPage(pageNum,pageSize);
        List<ArticleInfo> list = articleInfoService.listRecycle();
        //model.addAttribute("list", list);
        PageInfo<ArticleInfo> pageInfo = new PageInfo<ArticleInfo>(list);
        model.addAttribute("pageInfo",pageInfo);
        return "admin/articleInfo/recycleList";
    }

    @RequestMapping("/edit.action")
    public String edit(Model model, @RequestParam(value = "id", required = false) String id) {
        //查询单个文章的信息
        if (!StringUtils.isEmpty(id)) {
            ArticleInfo articleInfo = articleInfoService.selectById(id);
            model.addAttribute("articleInfo", articleInfo);
        }

        //查询所有文章分类
        model.addAttribute("typeList", typeInfoService.list());

        model.addAttribute("id", id);
        return "admin/articleInfo/edit";
    }

    @RequestMapping("/upload.json")
    @ResponseBody
    public Result upload(MultipartFile file, HttpServletRequest request) throws IOException {
        //文件原名称
        String filename = file.getOriginalFilename();
        //重命名后的文件名称
        String newFileName = "";
        //根据日期自动创建第三级目录
        String dateFolder = "";

        //上传文件
        if (file != null && filename != null && filename.length() > 0) {
            Date date = new Date();
            dateFolder = new SimpleDateFormat("yyyy/MM/dd").format(date);
            //存储文件的物理路径
            String filePath ="D://upload/"+ dateFolder;
            System.out.println(filePath);

            //自动创建文件夹
            File f = new File(filePath);
            if (!f.exists())
                f.mkdirs();

            //新的文件名称
            newFileName = UUID.randomUUID() + filename.substring(filename.lastIndexOf("."));
            //新文件
            File newFile = new File(filePath + "\\" + newFileName);

            //将内存中的数据写入磁盘
            file.transferTo(newFile);
        }

        return Result.success().add("imgUrl", "/upload/" + dateFolder + "/" + newFileName);
    }

    /**
     * 保存文章
     *
     * @param articleInfo
     * @return
     */
    @RequestMapping("/save.json")
    @ResponseBody
    public Result save(ArticleInfo articleInfo) {
        articleInfoService.save(articleInfo);
        return Result.success();
    }

    /**
     * 回收事件
     * @param idArr
     * @return
     */
    @RequestMapping("/recycle.json")
    @ResponseBody
    public Result recycle(@RequestParam(value = "idArr")String[] idArr){
        articleInfoService.recycle(idArr);
        return Result.success();
    }

    /**
     * 彻底删除事件
     * @param idArr
     * @return
     */
    @RequestMapping("/delete.json")
    @ResponseBody
    public Result delete(@RequestParam(value = "idArr")String[] idArr){
        articleInfoService.delete(idArr);
        return Result.success();
    }

    /**
     * 恢复事件
     * @param idArr
     * @return
     */
    @RequestMapping("/resume.json")
    @ResponseBody
    public Result resume(@RequestParam(value = "idArr")String[] idArr){
        articleInfoService.resume(idArr);
        return Result.success();
    }
}
