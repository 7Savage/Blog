package com.savage.blog.service.userInfo;

import com.savage.blog.dao.userInfo.IUserInfoDao;
import com.savage.blog.view.Link;
import com.savage.blog.view.Me;
import com.savage.blog.view.UserInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;

@Service
public class UserInfoService {
    private IUserInfoDao iUserInfoDao;

    @Autowired
    public void setiUserInfoDao(IUserInfoDao iUserInfoDao) {
        this.iUserInfoDao = iUserInfoDao;
    }

    public UserInfo checkUser(String loginName, String password){
        return iUserInfoDao.checkUser(loginName,password);
    }

    public Me aboutMe() {
        return iUserInfoDao.aboutMe();
    }

    public List<Link> link() {
        return iUserInfoDao.link();
    }


    public void saveLink(String[] idArr, String[] nameArr, String[] addressArr) {
        //遍历第一个数组
        for (int i = 0; i < idArr.length; i++) {
            //判断这条数据是需要更新还是插入
            if (StringUtils.isEmpty(idArr[i])) {
                //插入
                iUserInfoDao.insert(nameArr[i], addressArr[i]);
            } else {
                //更新
                iUserInfoDao.update(idArr[i], nameArr[i], addressArr[i]);
            }
        }
    }

    //文件批量删除
    public void delete(String[] idArr) {
        iUserInfoDao.delete(idArr);
    }

    public void deleteComment(String[] idArr) {
        iUserInfoDao.deleteComment(idArr);
    }
}
