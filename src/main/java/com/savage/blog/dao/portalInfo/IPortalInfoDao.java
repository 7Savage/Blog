package com.savage.blog.dao.portalInfo;

import com.savage.blog.view.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IPortalInfoDao {
    PortalInfo checkUser(@Param("loginName") String loginName, @Param("password") String password);

    void insert(@Param("registerName") String registerName, @Param("password") String password);

    PortalInfo checkUser2(@Param("registerName")String registerName);

    Star checkStar(@Param("portalId")String portalId,@Param("articleId")String articleId);

    void insertStar(@Param("portalId")String portalId,@Param("articleId")String articleId);

    List<ArticleInfo> star(@Param("id") String id);

    void deleteStar(@Param("portalId") String portalId, @Param("articleId") String articleId);

    void insertComment(@Param("content") String content);

    List<Comment> selectComment();
}
