package com.mbc.pet.qna;

import java.util.List;

public interface QnAService {

	void insertqna(QnADTO dto);

	QnADTO qnadetail(Integer qnum);

	List<QnADTO> allqnalist();

	void updateqnswer(QnADTO dto);
}