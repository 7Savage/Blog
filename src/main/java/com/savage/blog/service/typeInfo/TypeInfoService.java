package com.savage.blog.service.typeInfo;

import com.savage.blog.dao.typeInfo.ITypeInfoDao;
import com.savage.blog.view.TypeInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;

@Service
public class TypeInfoService {
    private ITypeInfoDao iTypeInfoDao;

    @Autowired
    public void setiTypeInfoDao(ITypeInfoDao iTypeInfoDao) {
        this.iTypeInfoDao = iTypeInfoDao;
    }

    public List<TypeInfo> list() {
        return iTypeInfoDao.list();
    }

    /**
     * 批量更新文章分类
     *
     * @param idArr
     * @param sortArr
     * @param nameArr
     */
    public void save(String[] idArr, String[] sortArr, String[] nameArr) {

        //遍历第一个数组
        for (int i = 0; i < idArr.length; i++) {
            //判断这条数据是需要更新还是插入
            if (StringUtils.isEmpty(idArr[i])) {
                //插入
                iTypeInfoDao.insert(sortArr[i], nameArr[i]);
            } else {
                //更新
                iTypeInfoDao.update(idArr[i], sortArr[i], nameArr[i]);
            }
        }
    }

    //文件批量删除
    public void delete(String[] idArr) {
        iTypeInfoDao.delete(idArr);
    }
}
