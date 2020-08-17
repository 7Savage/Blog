package com.savage.blog.dao.articleInfo;

import com.savage.blog.view.ArticleInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IArticleInfoDao {
    //查询所有文章
    List<ArticleInfo> listNormal();

    //根据id查询文章
    ArticleInfo selectById(String id);

    int insert(ArticleInfo articleInfo);

    void update(ArticleInfo articleInfo);

    void recycle(@Param("idArr") String[] idArr);

    void delete(@Param("idArr") String[] idArr);

    void resume(@Param("idArr")String[] idArr);

    //查询所有回收站文章
    List<ArticleInfo> listRecycle();

    //根据typeId查询所有文章个数
    int selectByTypeId(@Param("idArr")String[] idArr);

    //根据typeId彻底删除文章
    void deleteByTypeId(@Param("idArr")String[] idArr);

    //根据typeId查询文章
    List<ArticleInfo> listByTypeId(int typeId);

    //根据关键字查询文章
    List<ArticleInfo> listByKeyWord(@Param("keyWord") String keyWord);

    List<ArticleInfo> listRecommend();
}
