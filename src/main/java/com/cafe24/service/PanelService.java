package com.cafe24.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.cafe24.domain.Panel;
import com.cafe24.repository.PanelRepository;

@Service
@Transactional
public class PanelService {
	
	@Autowired
	PanelRepository repo;
	
	public List<Panel> getPanelList() {
		return repo.findAll();
	}
	public Panel getPanelById(Long id) {
		return repo.findOne(id);
	}
	public void removePanel(Long id) {
		repo.deleteById(id);
	}
	
}
