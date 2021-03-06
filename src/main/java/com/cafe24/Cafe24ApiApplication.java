package com.cafe24;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

//@SpringBootApplication
@EnableAutoConfiguration
@ComponentScan
@Configuration
public class Cafe24ApiApplication extends SpringBootServletInitializer {

	public static void main(String[] args) {
		SpringApplication.run(Cafe24ApiApplication.class, args);
		
		/*EntityManagerFactory emf = Persistence.createEntityManagerFactory("jpa_ex");*/
	}
	
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(Cafe24ApiApplication.class);
	}
}
