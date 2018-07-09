package com.cafe24.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cafe24.dto.SettingTab;

@Controller
@RequestMapping(value="/{mid}/create")
public class SettingController {
	
	@RequestMapping(value= {"", "/"})
	public String create(Model model, @PathVariable("mid") String mid) {
		SettingTab tabs = new SettingTab();
		
		model.addAttribute("mid", mid);
		model.addAttribute("center", "create_tab");
		model.addAttribute("tabs", tabs);
		return "index";
	}
	
	@RequestMapping(value="/preview")
	public String preview(Model model, @PathVariable("mid") String mid) {
		
		model.addAttribute("mid", mid);
		model.addAttribute("center", "preview");
		return "index";
	}

}
