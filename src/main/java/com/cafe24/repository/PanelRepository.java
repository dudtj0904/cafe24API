package com.cafe24.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.cafe24.domain.Panel;

public interface PanelRepository extends JpaRepository<Panel, Long> {
	
	@Query("select p from Panel p where p.id= :id")
	public Panel findOne(@Param("id") Long id);
	
}
