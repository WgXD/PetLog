package com.mbc.pet.point;

import org.apache.ibatis.annotations.Param;

public interface PointService {
	
	void insert_point(PointDTO point);

	boolean grant_grapes(@Param("user_id") int user_id1, @Param("grape_amount") int grape_amount); //관리자용 포도알 관리

}
