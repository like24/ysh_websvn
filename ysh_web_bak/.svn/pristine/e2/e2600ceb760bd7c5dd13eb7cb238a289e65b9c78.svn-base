package com.yoga.controller.v2.websocket;

import java.io.IOException;
import java.util.Map;
import java.util.Set;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArraySet;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import org.apache.log4j.Logger;
import org.joda.time.DateTime;

import com.sun.org.apache.bcel.internal.generic.NEW;
import com.sun.org.apache.bcel.internal.util.Class2HTML;
import com.yoga.utils.Config;
import com.yoga.utils.RedisUtil;

import redis.clients.jedis.Jedis;

/**
 * 课程直播间
 * 
 * @author huzh
 *
 */
@ServerEndpoint(value = "/ws/coursechat/{roomId}/{nickName}")
public class CourseChat extends R {

	private final static Logger LOG = Logger.getLogger(CourseChat.class);

	/**
	 * 连接对象集合
	 */
	// private static final Set<Chat> connections = new
	// CopyOnWriteArraySet<Chat>();
	private static final Map<String, Set<CourseChat>> connections = new ConcurrentHashMap<>();
	private String nickName;
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
		// Map<String,Chat> room = new HashMap<>();
		// connections.add(this);
		Set<CourseChat> room = connections.get(roomId);
		if (null == room) {
			room = new CopyOnWriteArraySet<>();
		}
		room.add(this);
		connections.put(roomId, room);
		String message = "";

		// CourseChat.broadCast(roomId, message);
		message = String.format("System> %s %s", this.nickName, " has joined.");
		LOG.info(message);
	}

	/**
	 * 关闭连接
	 */
	@OnClose
	public void onClose(@PathParam("roomId") String roomId) {

		connections.get(roomId).remove(this);
		String message = String.format("System> %s, %s", this.nickName, " has disconnection.");
		CourseChat.broadCast(roomId, message);
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

		MessageContent messageContent = jsonToObject(message, MessageContent.class);

		messageContent.setKeyId(keyId);

		// jedisUtil.put(keyId, messageContent);

		Jedis jedis = null;
		String messageReturn = null;
		messageReturn = objectToJson(messageContent);

		try {
			jedis = getJedisInstance();
			jedis.auth(Config.getString("redis.password"));
			switch (messageContent.getRequestType()) { // 根据不同的请求类型处理消息分发逻辑
			case "GetMsg":
				List<String> pageList = jedis.lrange(roomId, 0, 20);
				Collections.reverse(pageList);
				List<String> historyMessage = new ArrayList<>();
				for (String key : pageList) {
					historyMessage.add(jedis.get(key));
				}
				messageReturn = objectToJson(historyMessage);
				CourseChat.broadCast(roomId, messageContent.getDisableUserId(), messageReturn);
				break;
			case "Talk":// 0:文字,1:语音,2:图片
				jedis.set(keyId, messageReturn);
				jedis.lpush(roomId, keyId);
				CourseChat.broadCast(roomId, messageReturn);
			case "Login":
				jedis.set(keyId, messageReturn);
				CourseChat.broadCast(roomId, messageContent.getDisableUserId(), messageReturn);
				break;

			case "Disable":
				jedis.set(keyId, messageReturn);
				if (null == messageContent.getDisableUserId() && messageContent.getDisableUserId().equals("")) {
					CourseChat.broadCast(roomId, messageReturn);
				} else {
					CourseChat.broadCast(roomId, messageContent.getDisableUserId(), messageReturn);
				}
				break;
			case "CloseRooms":
				jedis.set(keyId, messageReturn);
				CourseChat.broadCast(roomId, messageReturn);
				break;
			default:
				break;
			}
		} finally {
			if (jedis != null) {
				jedis.close();
			}
		}

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
			}
		}
	}

	private static void broadCastHandler(String message, CourseChat chat) {
		try {

                chat.session.getBasicRemote().sendText(message);
        } catch (IOException e) {
            connections.remove(chat);
            try {
                chat.session.close();
            } catch (IOException e1) {
            }
            // CourseChat.broadCast(roomId, String.format("System> %s %s",
            // chat.nickName, " has bean disconnection."));
        }
	}

	private static void broadCast(String roomId, String nickName, String message) {

		Set<CourseChat> room = connections.get(roomId);
		for (CourseChat chat : room) {
			if (chat.nickName.equals(nickName)) {
                synchronized (chat) {
                    broadCastHandler(message, chat);
                }
			}
		}
	}
}
