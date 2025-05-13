package com.mbc.pet.place;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class PlaceController {

	@Autowired
	SqlSession sqlSession;


	@RequestMapping(value = "/place",method = RequestMethod.GET)
	public String listPlaces(@RequestParam("category") String category, HttpServletRequest request , Model model) {	 
		PlaceService placeService = sqlSession.getMapper(PlaceService.class);
	    List<PlaceDTO> placelist = placeService.getPlace(category);
		model.addAttribute("place", placelist);
		model.addAttribute("category", category);

		return "place";
	}
	
	@RequestMapping(value = "/place/sort",method = RequestMethod.GET)
	public String listPlaces(@RequestParam("category") String category, @RequestParam("sort") String sort,HttpServletRequest request , Model model) {	 
		PlaceService placeService = sqlSession.getMapper(PlaceService.class);
		Map<String, Object> params = new HashMap<>();
		params.put("category", category);
		params.put("sort", sort);
		List<PlaceDTO> placeList = placeService.getPlaceSort(params);
		model.addAttribute("place", placeList);
		model.addAttribute("category", category);

		return "place";
	}
	
}