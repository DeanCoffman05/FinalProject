package com.skilldistillery.flavorscapeapp.security;
import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
@Configuration
public class SecurityConfig {
    @Autowired
    private DataSource dataSource;
    @Autowired
    private PasswordEncoder encoder;
	
    @Bean
    public SecurityFilterChain createFilterChain(HttpSecurity http) throws Exception {
        http
        .csrf().disable()
        .authorizeRequests()
        .antMatchers(HttpMethod.OPTIONS, "/api/**").permitAll() // For CORS, the preflight request
        .antMatchers(HttpMethod.OPTIONS, "/**").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/api/restaurants").permitAll()  // Allow fetching all restaurants without authentication
        .antMatchers(HttpMethod.GET, "/api/restaurants/city/{city}").permitAll()  // Allow fetching all restaurants without authentication
        .antMatchers(HttpMethod.GET, "/api/restaurants/state/{state}").permitAll()  // Allow fetching all restaurants without authentication
        .antMatchers("/api/**").authenticated() // Other requests to our REST API must be authorized.
        .anyRequest().permitAll()               // All other requests are allowed without authentication.
        .and()
        .httpBasic();                           // Use HTTP Basic Authentication
        http
        .sessionManagement()
        .sessionCreationPolicy(SessionCreationPolicy.STATELESS);
        return http.build();
    }
    @Autowired
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        String userQuery = "SELECT username, password, enabled FROM user WHERE username=?";
        String
 authQuery = "SELECT username, role FROM user WHERE username=?";
        auth
        .jdbcAuthentication()
        .dataSource(dataSource)
        .usersByUsernameQuery(userQuery)
        .authoritiesByUsernameQuery(authQuery)
        .passwordEncoder(encoder);
    }
    
}