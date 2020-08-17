package com.savage.blog.service.articleInfo;

import com.savage.blog.dao.articleInfo.IArticleInfoDao;
import com.savage.blog.view.ArticleInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class ArticleInfoService {
    private IArticleInfoDao articleInfoDao;

    @Autowired
    public void setArticleInfoDao(IArticleInfoDao articleInfoDao) {
        this.articleInfoDao = articleInfoDao;
    }

    public List<ArticleInfo> listNormal(){
        return articleInfoDao.listNormal();
    }

    public ArticleInfo selectById(String id) {
        ArticleInfo articleInfo = articleInfoDao.selectById(id);
        int viewCount = articleInfo.getViewCount();
        viewCount++;
        articleInfo.setViewCount(viewCount);
        articleInfoDao.update(articleInfo);
        return articleInfoDao.selectById(id);
    }

    /**
     * 保存文章
     * @param articleInfo
     */
    public void save(ArticleInfo articleInfo) {
        Date date = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String now = format.format(date);
        //判断新增还是更新
        if (StringUtils.isEmpty(articleInfo.getId())){
            articleInfo.setUpdateTime(now);
            articleInfo.setViewCount(1);
            articleInfo.setStatus(1);
            articleInfoDao.insert(articleInfo);
        }else{
            articleInfo.setUpdateTime(now);
            articleInfoDao.update(articleInfo);
        }

    }

    public void recycle(String[] idArr) {
        articleInfoDao.recycle(idArr);
    }

    public void delete(String[] idArr) {
        articleInfoDao.delete(idArr);
    }

    public void resume(String[] idArr) {
        articleInfoDao.resume(idArr);
    }

    public List<ArticleInfo> listRecycle() {
        return articleInfoDao.listRecycle();
    }

    public int selectByTypeId(String[] idArr) {
        return articleInfoDao.selectByTypeId(idArr);
    }

    public void deleteByTypeId(String[] idArr) {
        articleInfoDao.deleteByTypeId(idArr);
    }

    public List<ArticleInfo> listByTypeId(int typeId) {
        return articleInfoDao.listByTypeId(typeId);
    }

    public List<ArticleInfo> listByKeyWord(String s) {
        return articleInfoDao.listByKeyWord(s);
    }

    public List<ArticleInfo> listRecommend() {
        return articleInfoDao.listRecommend();
    }
}
