package com.cafe24.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.cafe24.domain.Script;

public interface ScriptRepository extends JpaRepository<Script, Long> {
	
	@Modifying
	@Query("update Script s set s.isApply = :state where s.panelId = :id")
	public int updateIsApplyByPanelId(@Param("state") boolean state, @Param("id") Long id);
	
	@Modifying
	@Query("update Script s set s.isApply = false where s.panelId != :id and s.isApply = true")
	public int updateIsApplyByExceptPanelId(@Param("id") Long id);

	@Query("select s from Script s where s.panelId != :id and s.isApply = true")
	public Script findByExceptId(@Param("id") Long id);
}
