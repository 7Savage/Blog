package com.savage.blog.view;

import java.util.HashMap;
import java.util.Map;

import org.springframework.util.StringUtils;

public class Result {
    private String code;//状态码，成功：000000，失败：999999
    private String message;//错误信息
    private Map<String,Object> data=new HashMap<String, Object>();//链式结构存储数据


    public static Result error(String s) {
        Result result = new Result();
        result.setMessage("999999");
        if (StringUtils.isEmpty(s)) {
            result.setMessage("操作失败");
        } else {
            result.setMessage(s);
        }
        return result;
    }

    public static Result success() {
        Result result = new Result();
        result.setCode("000000");
        result.setMessage("操作成功");
        return result;
    }

    public Result add(String key,Object value){
        this.getData().put(key,value);
        return this;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Map<String, Object> getData() {
        return data;
    }

    public void setData(Map<String, Object> data) {
        this.data = data;
    }


}
