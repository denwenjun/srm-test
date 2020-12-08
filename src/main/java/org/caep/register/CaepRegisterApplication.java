package org.caep.register;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;
import org.srm.autoconfigure.register.EnableSrmRegister;


@EnableSrmRegister
@EnableEurekaServer
@SpringBootApplication(exclude = {SecurityAutoConfiguration.class})
public class CaepRegisterApplication {
	public CaepRegisterApplication() {
	}

	public static void main(String[] args) {
		SpringApplication.run(CaepRegisterApplication.class, args);
	}
}


