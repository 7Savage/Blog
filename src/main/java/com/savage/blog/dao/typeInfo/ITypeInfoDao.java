package com.savage.blog.dao.typeInfo;

import com.savage.blog.view.TypeInfo;
import com.savage.blog.view.UserInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.security.core.parameters.P;

import java.util.List;


public interface ITypeInfoDao {
    List<TypeInfo> list();

    /**
     * 插入一条新的数据
     * @return
     */
    int insert(@Param("sort") String sort,@Param("name") String name);

    /**
     * 更新一条数据
     */
    int update(@Param("id")String id,@Param("sort") String sort, @Param("name") String name);

    void delete(@Param("idArr") String[] idArr);
}
