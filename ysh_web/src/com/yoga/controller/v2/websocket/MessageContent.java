package com.yoga.controller.v2.websocket;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import java.util.Date;
import java.util.List;

@JsonIgnoreProperties(ignoreUnknown = true)
public class MessageContent implements java.io.Serializable {

    private String keyId; //消息唯一标识
    private String requestType;//请求类型,GetMsg\Talk\Login\Disable\CloseRooms
    private String roomId;//直播间ID
    private String userId;//用户ID
    private String talkType;//谈话类型，
    private String userHeaderImg;//头像
    private String askId;//提问ID
    private String userNickName;//用户昵称
    private String status;//身份标识,0:学员，1：主持人，2：老师
    private String content;//消息内容
    private Integer readStatus;//已读标识
    private Integer undoStatus;//撤销标识
    private String parentId;//父节点ID
    private int isAsk;//是否是提问，0：未提问，1：提问
    private String disableUserId = "";//被禁言的人ID
    private int time;
    private int setAudioBtnW;
    private int start;//消息开始位置
    private int end;//消息结束位置
    private int dataType;//请求获取历史消息的类型，0：主交流区域，1：all消息，2：提问消息
    private int roomStatus;//房间的状态,0:未开始，1：直播中，2：已结束

    private List<MessageContent> answerObj;

    private int userCount;
    private Long messageCount;
    private String contentType;
    private String messageCreateTime;

    public String getMessageCreateTime() {
        return messageCreateTime;
    }

    public void setMessageCreateTime(String messageCreateTime) {
        this.messageCreateTime = messageCreateTime;
    }

    public String getContentType() {
        return contentType;
    }

    public void setContentType(String contentType) {
        this.contentType = contentType;
    }

    public int getTime() {
        return time;
    }

    public void setTime(int time) {
        this.time = time;
    }

    public int getSetAudioBtnW() {
        return setAudioBtnW;
    }

    public void setSetAudioBtnW(int setAudioBtnW) {
        this.setAudioBtnW = setAudioBtnW;
    }

    public Long getMessageCount() {
        return messageCount;
    }

    public void setMessageCount(Long messageCount) {
        this.messageCount = messageCount;
    }

    public int getUserCount() {
        return userCount;
    }

    public void setUserCount(int userCount) {
        this.userCount = userCount;
    }

    public List<MessageContent> getAnswerObj() {
        return answerObj;
    }

    public void setAnswerObj(List<MessageContent> answerObj) {
        this.answerObj = answerObj;
    }

    public int getStart() {
        return start;
    }

    public void setStart(int start) {
        this.start = start;
    }

    public int getEnd() {
        return end;
    }

    public void setEnd(int end) {
        this.end = end;
    }

    public int getDataType() {
        return dataType;
    }

    public void setDataType(int dataType) {
        this.dataType = dataType;
    }

    public int getRoomStatus() {
        return roomStatus;
    }

    public void setRoomStatus(int roomStatus) {
        this.roomStatus = roomStatus;
    }

    public String getDisableUserId() {
        return disableUserId;
    }

    public void setDisableUserId(String disableUserId) {
        this.disableUserId = disableUserId;
    }

    public int getIsAsk() {
        return isAsk;
    }

    public void setIsAsk(int isAsk) {
        this.isAsk = isAsk;
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getKeyId() {
        return keyId;
    }

    public void setKeyId(String keyId) {
        this.keyId = keyId;
    }

    public String getRequestType() {
        return requestType;
    }

    public void setRequestType(String requestType) {
        this.requestType = requestType;
    }

    public String getRoomId() {
        return roomId;
    }

    public void setRoomId(String roomId) {
        this.roomId = roomId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getTalkType() {
        return talkType;
    }

    public void setTalkType(String talkType) {
        this.talkType = talkType;
    }

    public String getUserHeaderImg() {
        return userHeaderImg;
    }

    public void setUserHeaderImg(String userHeaderImg) {
        this.userHeaderImg = userHeaderImg;
    }

    public String getAskId() {
        return askId;
    }

    public void setAskId(String askId) {
        this.askId = askId;
    }

    public String getUserNickName() {
        return userNickName;
    }

    public void setUserNickName(String userNickName) {
        this.userNickName = userNickName;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getReadStatus() {
        return readStatus;
    }

    public void setReadStatus(Integer readStatus) {
        this.readStatus = readStatus;
    }

    public Integer getUndoStatus() {
        return undoStatus;
    }

    public void setUndoStatus(Integer undoStatus) {
        this.undoStatus = undoStatus;
    }


}
