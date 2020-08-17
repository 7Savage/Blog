package com.savage.blog.view;

import java.util.Date;

public class ArticleInfo {
    private String id;
    private String typeId;
    private String title;
    private String content;
    private String contentText;//文章的简介
    private String cover;//文章的封面
    private int viewCount;//浏览次数
    private String updateTime;//文章最后一次更新的时间
    private int status;//文章的状态（1.正常 0.回收站）
    private String name;//文章分类名称

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTypeId() {
        return typeId;
    }

    public void setTypeId(String typeId) {
        this.typeId = typeId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getContentText() {
        return contentText;
    }

    public void setContentText(String contentText) {
        this.contentText = contentText;
    }

    public String getCover() {
        return cover;
    }

    public void setCover(String cover) {
        this.cover = cover;
    }

    public int getViewCount() {
        return viewCount;
    }

    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }

    public String getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "ArticleInfo{" +
                "id='" + id + '\'' +
                ", typeId='" + typeId + '\'' +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", contentText='" + contentText + '\'' +
                ", cover='" + cover + '\'' +
                ", viewCount=" + viewCount +
                ", updateTime='" + updateTime + '\'' +
                ", status=" + status +
                ", name='" + name + '\'' +
                '}';
    }
}
