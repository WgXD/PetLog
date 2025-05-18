package com.mbc.pet.qna;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface QnAService {

	void insertqna(QnADTO dto);

	QnADTO qnadetail(Integer qnum);

	List<QnADTO> allqnalist(@Param("start") int start, @Param("end") int end);

	void updateqnswer(QnADTO dto);

	int totalByType();

	void updateQnA(QnADTO dto);

	QnADTO getQnAById(int qna_id);

	void deleteQnA(int qna_id);

}