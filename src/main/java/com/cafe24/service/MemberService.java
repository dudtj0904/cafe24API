package com.cafe24.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cafe24.repository.MemberRepository;

@Service
@Transactional
public class MemberService {
	@Autowired
	MemberRepository repo;
	

}
