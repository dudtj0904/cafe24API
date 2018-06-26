package com.cafe24.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

// @RestController : data return
// -> 객체를 반환하면 객체 데이터는 JSON/XML 형식의 HTTP 응답 작성
// -> @Controller + @ResponseBody
@Controller		// : view(화면) return
public class MainController {

	@RequestMapping(value= {"", "/", "/index"})
	public String main(Model model) {
		model.addAttribute("hello", "hello hello");
		
		return "index";	// /WEB-INF/views/index.jsp
	}
	
	@RequestMapping(value="/index2")
	public String main2(Model model) {
		model.addAttribute("hello", "hello hello2");
		
		return "index2";	// /WEB-INF/views/index.jsp
	}

}
