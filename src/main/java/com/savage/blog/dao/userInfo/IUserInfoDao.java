package com.savage.blog.dao.userInfo;

import com.savage.blog.view.Link;
import com.savage.blog.view.Me;
import com.savage.blog.view.UserInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.security.core.parameters.P;

import java.util.List;


public interface IUserInfoDao {
    UserInfo checkUser(@Param("loginName") String loginName, @Param("password") String password);

    Me aboutMe();

    List<Link> link();

    void insert(@Param("name") String name, @Param("address") String address);

    void update(@Param("id") String id,@Param("name") String name, @Param("address") String address);

    void delete(@Param("idArr") String[] idArr);

    void deleteComment(@Param("idArr")String[] idArr);
}
