package com.webview.controller;

import com.webview.dao.MessageDao;
import com.webview.to.MessageTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;

@Controller
public class MessageController {

    @Autowired
    private MessageDao messageDAO;

    //메세지 목록
    @RequestMapping(value = "/message_list.do")
    public String message_list(HttpServletRequest request, HttpSession session) {

        String nick = (String) session.getAttribute("nick");

        MessageTO to = new MessageTO();
        to.setNick(nick);
        //메세지 리스트
        ArrayList<MessageTO> list = messageDAO.messageList(to);

        request.setAttribute("list", list);

        return "main/mainview";
    }

    //메세지 목록
    @RequestMapping(value = "/message_ajax_list.do")
    public String message_ajax_list(HttpServletRequest request, HttpSession session) {

        String nick = (String) session.getAttribute("nick");

        MessageTO to = new MessageTO();
        to.setNick(nick);

        //메세지 리스트
        ArrayList<MessageTO> list = messageDAO.messageList(to);

        request.setAttribute("list", list);

        return "main/ajax_list";
    }

    @RequestMapping(value = "/message_content_list.do")
    public String message_content_list(HttpServletRequest request, HttpSession session){

        int room = Integer.parseInt(request.getParameter("room"));

        MessageTO to = new MessageTO();
        to.setRoom(room);
        to.setNick((String) session.getAttribute("nick"));
        //메세지 내용을 가져온다.
        ArrayList<MessageTO> clist = messageDAO.roomContentList(to);

        request.setAttribute("click", clist);

        return "main/content_lsit";
    }

    //메세지 리스트에서 메세지 보내기
    @RequestMapping(value = "/message_send_inlist.do")
    public int message_send_inlist(@RequestParam int room, @RequestParam String other_nick,
                                   @RequestParam String content, HttpSession session) {
        MessageTO to = new MessageTO();
        to.setRoom(room);
        to.setSend_nick((String) session.getAttribute("nick"));
        to.setRecv_nick(other_nick);
        to.setContent(content);

        int flag = messageDAO.messageSendInlist(to);

        return flag;
    }

}
