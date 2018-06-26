package com.cafe24.security;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	/**
	 * Security Config Class
	 */
	
	@Override
	public void configure(WebSecurity web) throws Exception {
		// 모든 페이지 비인증 설정
		//web.ignoring().antMatchers("/**");
		
		web.ignoring().antMatchers("/css/**", "/jquery/**", "/");
		
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		// resource 외의 페이지의 권한 설정
		// http.authorizeRequests().antMatchers("/admin/**").access("ROLE_ADMIN");
		
		// localhost:8080/index 는 인증된 사용자만이 접속 가능하도록 설정
		/* http.authorizeRequests().antMatchers("/index").authenticated()
		.antMatchers("/**").permitAll(); */
	}
	
	

	
	

}
