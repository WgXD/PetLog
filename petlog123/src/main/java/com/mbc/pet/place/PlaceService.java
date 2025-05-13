package com.mbc.pet.place;

import java.util.List;
import java.util.Map;

public interface PlaceService {
	List<PlaceDTO> getPlace(String category);
	List<PlaceDTO> getPlaceSort(Map<String, Object> params);
}
