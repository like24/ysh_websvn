package com.yoga.controller.v2.websocket;

import com.yoga.utils.Config;
import com.yoga.utils.RedisUtil;
import org.apache.log4j.Logger;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import redis.clients.jedis.Jedis;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArraySet;

/**
 * 课程直播间
 *
 * @author huzh
 */
@ServerEndpoint(value = "/ws/coursechat/{roomId}/{nickName}")
public class CourseChat extends R {

    private final static Logger LOG = Logger.getLogger(CourseChat.class);

    @Override
    public String toString() {
        return super.toString();
    }

    /**
     * 连接对象集合
     */
    // private static final Set<Chat> connections = new
    // CopyOnWriteArraySet<Chat>();
    private static final Map<String, Set<CourseChat>> connections = new ConcurrentHashMap<>();
    private String nickName;
    private String userKeyId;
    private String roomId;
    private String roomIdDisable;
    private String roomIdDisableMember;
    private static final RedisUtil<MessageContent> jedisUtil = new RedisUtil<>(Config.getString("redis.host"),
            Config.getString("redis.port").equals("") ? 6379 : Integer.valueOf(Config.getString("redis.port")));

    /**
     * WebSocket Session
     */
    private Session session;


    public CourseChat() {
    }

    @SuppressWarnings("unused")
    private String getKeyId(String roomId, String nickName) {
        DateTime dateTime = new DateTime();
        return new StringBuffer(roomId).append(":").append(nickName).append(":").append(dateTime.getMillis())
                .toString();
    }

    /**
     * 打开连接
     *
     * @param session
     * @param nickName
     */
    @OnOpen
    public void onOpen(Session session, @PathParam(value = "nickName") String nickName,
                       @PathParam("roomId") String roomId) {

        this.session = session;
        this.nickName = nickName;
        this.userKeyId = getUserKeyId(roomId, nickName);
        this.roomId = getRoomsId(roomId);
        this.roomIdDisable = getDisableKeyId(roomId);

        Jedis jedis = null;
        String roomsId = getRoomsId(roomId);

        try {
            Set<CourseChat> courseChats = connections.get(this.roomId);
            if (null == courseChats) {
                courseChats = new CopyOnWriteArraySet<CourseChat>();
            }
            courseChats.add(this);
            connections.put(this.roomId, courseChats);


            //广播消息，通知某人加入,

            MessageContent messageContent = new MessageContent();
            messageContent.setUserId(nickName);
            //如果当前直播间是全员禁言状态，对当前用户发送禁言的消息
            jedis = getJedisInstance();
            jedis.auth(Config.getString("redis.password"));


            String userCount = jedis.get(roomsId+":userCount");
            if (null == userCount||userCount.equals("")){
                userCount = "1";
            }else {
                userCount = String.valueOf(Integer.valueOf(userCount)+1);
            }

            jedis.set(roomsId+":userCount",userCount);

            //广播用户数量
            messageContent.setRequestType("UserCount");
            messageContent.setUserCount(Integer.valueOf(userCount));
            broadCast(roomsId, objectToJson(messageContent));

            messageContent.setRequestType("MessageCount");
            messageContent.setMessageCount(jedis.llen(getRoomsId(roomId) + ":all"));

            broadCast(roomsId, objectToJson(messageContent));


            if (null != jedis.get(getDisableKeyId(roomsId))&&jedis.get(getDisableKeyId(roomsId)).equals("0")){
                messageContent.setRequestType("Disable");
                broadCast(roomsId,userKeyId, objectToJson(messageContent));
            }else if (jedis.get(userKeyId+":disable")!=null && !jedis.get(userKeyId+":disable").equals("")){
                messageContent.setRequestType("Disable");
                broadCast(roomsId,userKeyId, objectToJson(messageContent));
            }else {
                messageContent.setRequestType("Login");
            }



            broadCast(roomsId, objectToJson(messageContent));

        } catch (Exception e) {
            e.printStackTrace();
            LOG.error(e.getMessage(), e.fillInStackTrace());
        } finally {
            if (null != jedis) {
                jedis.close();
            }
        }


    }


    private void removeMembers(String roomsId, String memberId) {

        Set<CourseChat> courseChats = connections.get(roomsId);
        for (CourseChat chat : courseChats){
            if (chat.userKeyId.equals(memberId)){
                connections.get(roomsId).remove(chat);
            }
        }

    }


    private Set<String> getAllMembers(Jedis jedis, String roomsId) {

        return jedis.smembers(roomsId);
    }

    /**
     * 关闭连接
     */
    @OnClose
    public void onClose(@PathParam("roomId") String roomId, @PathParam(value = "nickName") String nickName) {


        try {
            String roomsId = getRoomsId(roomId);
            String userKeyId = getUserKeyId(roomId, nickName);
            connections.get(roomsId).remove(this);
            LOG.info("KeepYoGa RoomsId:" + roomsId + ",remove member is " + userKeyId);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e.fillInStackTrace());
        }

    }

    private String getUserKeyId(String roomId, String nickName) {
        return "KeepYoGa:" + roomId + ":" + nickName;
    }

    private String getRoomsId(String roomId) {
        return "keepyoga:room:" + roomId;
    }

    /**
     * 接收信息
     *
     * @param message
     * @param nickName
     */
    @OnMessage
    public void onMessage(String message, @PathParam(value = "nickName") String nickName,
                          @PathParam("roomId") String roomId) {
        // 生成KeyId，用于Redis存储
        String keyId = getKeyId(roomId, nickName);
        String userKeyId = getUserKeyId(roomId, nickName);
        String mainTalk = getRoomsId(roomId) + ":main";//主交流区
        String allTalk = getRoomsId(roomId) + ":all";//所有消息区
        String askTalk = getRoomsId(roomId) + ":ask";//提问消息
        MessageContent messageContent = jsonToObject(message, MessageContent.class);


        if (null == messageContent.getAskId() || messageContent.getAskId().equals("")) {
            messageContent.setKeyId(keyId);
        }
        if (null == messageContent.getMessageCreateTime() || messageContent.getMessageCreateTime().equals("")){
            messageContent.setMessageCreateTime(new DateTime().toString("yyyy-MM-dd HH:mm:ss"));
        }
        String roomsId = getRoomsId(roomId);

        Jedis jedis = null;
        String messageReturn = objectToJson(messageContent);
        try {
            jedis = getJedisInstance();
            jedis.auth(Config.getString("redis.password"));
            switch (messageContent.getRequestType()) { // 根据不同的请求类型处理消息分发逻辑
                case "GetMsg":
                    List<String> pageList = null;
                    if (messageContent.getDataType() == 0) { //主交流区域
//                        if (messageContent.getRoomStatus() == 2) {
//                            pageList = jedis.lrange(mainTalkHis, messageContent.getStart(), messageContent.getEnd());
//                        } else {
                            pageList = jedis.lrange(mainTalk, messageContent.getStart(), messageContent.getEnd());
//                        }
                    } else if (messageContent.getDataType() == 1) {//
//                        if (messageContent.getRoomStatus() != 2) {
//                            pageList = jedis.lrange(allTalkHis, messageContent.getStart(), messageContent.getEnd());
//                        } else {
                            pageList = jedis.lrange(allTalk, messageContent.getStart(), messageContent.getEnd());
//                        }
                    } else if (messageContent.getDataType() == 2) {
                        pageList = jedis.lrange(askTalk, messageContent.getStart(), messageContent.getEnd());
                    }

                    Collections.reverse(pageList);
                    List<String> historyMessage = new ArrayList<>();
                    HashMap<String,Object> map = new HashMap<>();
                    for (String key : pageList) {
                        historyMessage.add(jedis.get(key));
//                        System.out.println(jedis.get(key));
                    }
                    map.put("requestType","GetMsg");
                    map.put("dataType",messageContent.getDataType());
                    map.put("roomStatus",messageContent.getRoomStatus());
                    map.put("data",historyMessage);
                    messageReturn = objectToJson(map);//1495534660546  1495505275296
                    CourseChat.broadCast(roomsId, userKeyId, messageReturn);
                    break;
                case "Talk":// 0:文字,1:语音,2:图片
                    jedis.set(keyId, messageReturn);//所有的说话都进行记录

                    //当收到回答的消息时
                    if (messageContent.getAskId() != null && !messageContent.getAskId().equals("")) {
                        jedis.set(messageContent.getAskId(),messageReturn);
                        if (messageContent.getAnswerObj().size() == 1){
                            jedis.lpush(mainTalk, messageContent.getAskId());
//                            jedis.rpush(mainTalkHis, messageContent.getAskId());
                        }
                    }else {

                        //提问消息，

                            if (messageContent.getStatus().equals("0")) {//学员消息
                                if (messageContent.getIsAsk() == 1) {
                                    jedis.lpush(askTalk, keyId);
                                    jedis.lpush(allTalk, keyId);
                                }else {
                                    jedis.lpush(allTalk, keyId);
                                }
//                                jedis.rpush(allTalkHis, keyId);
                            }else {//老师和主持人
                                jedis.lpush(mainTalk, keyId);
//                                jedis.lpush(allTalk,keyId);
//                            jedis.rpush(mainTalkHis, keyId);
                            }
                    }
                    messageContent.setMessageCount(jedis.llen(allTalk));
                    CourseChat.broadCast(roomsId, messageReturn);
                    break;
                case "Login":
                    jedis.set(keyId, messageReturn);
                    CourseChat.broadCast(roomsId, messageReturn);
                    break;

                case "Disable":

                    jedis.set(keyId, messageReturn);
                    if (messageContent.getDisableUserId() == null || messageContent.getDisableUserId().equals("")){
                        jedis.set(getDisableKeyId(roomsId),"0");
                    }else{
                        jedis.set(getUserKeyId(roomsId,messageContent.getDisableUserId())+":disable",getUserKeyId(roomsId,messageContent.getDisableUserId()));
                    }
                    if (null == messageContent.getDisableUserId() || messageContent.getDisableUserId().equals("")) {
                        CourseChat.broadCast(roomsId, messageReturn);
                    } else {
                        CourseChat.broadCast(roomsId, userKeyId, messageReturn);
                    }
                    break;
                case "UnDisable":
                    jedis.set(keyId, messageReturn);
                    if (null == messageContent.getDisableUserId() || messageContent.getDisableUserId().equals("")){
                        jedis.set(getDisableKeyId(roomsId),"1");
                        CourseChat.broadCast(roomsId, messageReturn);
                    }else{
                        jedis.del(getUserKeyId(roomsId,messageContent.getDisableUserId())+":disable",getUserKeyId(roomsId,messageContent.getDisableUserId()));
                        CourseChat.broadCast(roomsId,getUserKeyId(roomsId,messageContent.getDisableUserId()), messageReturn);
                    }
                    break;
                case "CloseRooms":
                        messageContent.setRoomStatus(2);
                    messageReturn = objectToJson(messageContent);
                    jedis.set(keyId, messageReturn);
                    jedis.set(roomsId+":status", "0");
                    CourseChat.broadCast(roomsId, messageReturn);
                    break;
                case "QuitRooms":
                    //退出房间
                    jedis.set(keyId, messageReturn);
                    CourseChat.broadCast(roomsId, messageReturn);
                    break;
                default:
                    break;
            }

            messageContent.setRequestType("MessageCount");
            messageContent.setMessageCount(jedis.llen(allTalk));

            broadCast(roomsId, objectToJson(messageContent));
        } catch (Exception e) {
            LOG.error(e.getMessage(), e.fillInStackTrace());
        } finally {
            if (jedis != null) {
                jedis.close();
            }
        }

    }

    private String getDisableKeyId(String roomsId) {
        return getRoomsId(roomsId)+":disable";
    }

    /**
     * 错误信息响应
     *
     * @param throwable
     */
    @OnError
    public void onError(Throwable throwable) {
        System.out.println(throwable.getMessage());
    }

    /**
     * 发送或广播信息
     *
     * @param roomId
     * @param message
     */
    private static void broadCast(String roomId, String message) {
        Set<CourseChat> room = connections.get(roomId);
        for (CourseChat chat : room) {
            synchronized (chat) {
                broadCastHandler(message, chat);
                System.out.println(message);
            }
        }
    }

    private static void broadCastHandler(String message, CourseChat chat) {
        try {
            chat.session.getBasicRemote().sendText(message);
        } catch (IOException e) {
            try {
                chat.session.close();
            } catch (IOException e1) {
            }
            // CourseChat.broadCast(roomId, String.format("System> %s %s",
            // chat.nickName, " has bean disconnection."));
        }
    }

    private static void broadCast(String roomId, String userKeyId, String message) {

        Set<CourseChat> room = connections.get(roomId);
        for (CourseChat chat : room) {
            if (chat.userKeyId.equals(userKeyId)) {
                synchronized (chat) {
                    broadCastHandler(message, chat);
                    System.out.println(message);
                }
            }
        }

    }

}
