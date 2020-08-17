package com.savage.blog.action.typeInfo;

import com.savage.blog.service.articleInfo.ArticleInfoService;
import com.savage.blog.service.typeInfo.TypeInfoService;
import com.savage.blog.view.ArticleInfo;
import com.savage.blog.view.Result;
import com.savage.blog.view.TypeInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;


@Controller
@RequestMapping("/type")
public class TypeInfoAction {
    private TypeInfoService typeInfoService;
    private ArticleInfoService articleInfoService;


    @Autowired
    public void setTypeInfoService(TypeInfoService typeInfoService) {
        this.typeInfoService = typeInfoService;
    }

    @Autowired
    public void setArticleInfoService(ArticleInfoService articleInfoService) {
        this.articleInfoService = articleInfoService;
    }

    @RequestMapping("/list.action")
    public String list(Model model) {
        List<TypeInfo> list = typeInfoService.list();
        model.addAttribute("list", list);
        return "admin/typeInfo/list";
    }

    @RequestMapping("/save.json")
    @ResponseBody
    public Result save(
            @RequestParam(value = "idArr") String[] idArr,
            @RequestParam(value = "sortArr") String[] sortArr,
            @RequestParam(value = "nameArr") String[] nameArr
    ) {
        typeInfoService.save(idArr, sortArr, nameArr);
        return Result.success();
    }

    @RequestMapping("/delete.json")
    @ResponseBody
    public Result delete(@RequestParam(value = "idArr") String[] idArr) {

        //查询是否有该typeId的文章，若有，则不能删除
        int count = articleInfoService.selectByTypeId(idArr);
        if (count > 0)
            return Result.error("不能删除该类");

        //删除回收站的文章
        articleInfoService.deleteByTypeId(idArr);

        //删除分类
        typeInfoService.delete(idArr);
        return Result.success();
    }
}
