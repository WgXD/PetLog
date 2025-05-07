package com.mbc.pet.qna;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface QnAService {

	void insertqna(QnADTO dto);

	QnADTO qnadetail(Integer qnum);

	List<QnADTO> allqnalist(@Param("start") int start, @Param("end") int end);

	void updateqnswer(QnADTO dto);

	int totalByType();

}