package com.savage.blog.service.portalInfo;

import com.savage.blog.dao.portalInfo.IPortalInfoDao;
import com.savage.blog.view.ArticleInfo;
import com.savage.blog.view.Comment;
import com.savage.blog.view.PortalInfo;
import com.savage.blog.view.Star;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PortalInfoService {
    @Autowired
    private IPortalInfoDao portalInfoDao;

    public PortalInfo checkUser(String loginName, String password) {
        return portalInfoDao.checkUser(loginName,password);
    }

    public void insert(String registerName, String password) {
        portalInfoDao.insert(registerName,password);
    }

    public PortalInfo checkUser(String registerName) {
        return portalInfoDao.checkUser2(registerName);
    }

    public Star checkStar(String portalId, String articleId) {
        return portalInfoDao.checkStar(portalId,articleId);
    }

    public void insertStar(String portalId, String articleId) {
        portalInfoDao.insertStar(portalId,articleId);
    }


    public List<ArticleInfo> star(String id) {
        return portalInfoDao.star(id);
    }

    public void deleteStar(String portalId, String articleId) {
        portalInfoDao.deleteStar(portalId,articleId);
    }

    public void insertComment(String content) {
        portalInfoDao.insertComment(content);
    }

    public List<Comment> selectComment() {
        return portalInfoDao.selectComment();
    }
}
