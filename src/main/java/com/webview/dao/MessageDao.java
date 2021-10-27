package com.webview.dao;
import com.webview.to.MessageTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;


@Repository
public class MessageDao {

    @Autowired
    private SqlSession sqlSession;

    //메세지 리스트
    public ArrayList<MessageTO> messageList(MessageTO to) {

        String nick = to.getNick();

        //메세지 리스트에 나타낼 것들 가져오기 - 가장 최근 메세지, 보낸사람 profile 사진, 보낸사람 nick
        ArrayList<MessageTO> list = (ArrayList) sqlSession.selectList("ChatMapper.message_list", to);

        for (MessageTO mto : list) {
            mto.setNick(nick);
            //현재 사용자가 해당 room에서 안읽은 메세지의 갯수를 가져온다.
            int unread = sqlSession.selectOne("ChatMapper.count_unread", mto);
            //현재 사용자가 메세지를 주고받는 상대 profile을 가져온다.
            String profile = sqlSession.selectOne("ChatMapper.get_other_profile", mto);
            //안읽은 메세지 갯수를 mto에 set한다
            mto.setUnread(unread);
            //메세지 상대의 프로필사진을 mto에 set한다.
            mto.setProfile(profile);
            //메세지 상대 nick을 세팅하낟, other_nick
            if (nick.equals(mto.getSend_nick())){
                mto.setOther_nick(mto.getRecv_nick());
            }else {
                mto.setOther_nick(mto.getSend_nick());
            }
        }

        return list;
    }

    // room 별 메세지 내용을 가져온다.
    public ArrayList<MessageTO> roomContentList(MessageTO to) {


        //메세지 내역을 가져온다
        ArrayList<MessageTO> clist = (ArrayList) sqlSession.selectOne("ChatMapper.room_content_list", to);
        //해당 방의 메세지들 중 받는 사람이 현재사용자의 nick인 메세지를 모두 읽음 처리한다.
        sqlSession.update("ChatMapper.message_read_chk", to);

        return clist;
    }

    //메세지 list에서 메세지를 보낸다.
    public int messageSendInlist(MessageTO to) {

        //메세지 리스트에서 보낸건지 프로필에서 보낸건지 구분
        if (to.getRoom() == 0) {
            int exist_chat = sqlSession.selectOne("ChatMapper.exist_chat", to);
            //프로필에서 보낸것중 메세지 내역이없어서 첫 메세지가 될경우를 구분하기 위함
            if (exist_chat == 0) {
                int max_room = sqlSession.selectOne("ChatMapper.max_room", to);
                to.setRoom(max_room + 1);
            } else {
                //메세지 내역이 있다면 해당 room 번호를 가져온다.
                int room = Integer.parseInt(sqlSession.selectOne("ChatMapper.select_room", to));
                to.setRoom(room);
            }
        }

        int flag = sqlSession.insert("ChatMapper.messageSendInlist", to);
        return flag;
    }

}
