package com.cafe24.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cafe24.domain.Member;

public interface MemberRepository extends JpaRepository<Member, String> {

}
