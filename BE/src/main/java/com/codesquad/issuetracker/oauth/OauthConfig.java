package com.codesquad.issuetracker.oauth;

import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Map;

@Configuration
@EnableConfigurationProperties({OauthProperties.class})
public class OauthConfig {

    private final OauthProperties properties;

    public OauthConfig(OauthProperties properties) {
        this.properties = properties;
    }

    @Bean
    public InMemoryProviderRepository inMemoryProviderRepository() {
        Map<String, OauthProvider> providers = OauthAdapter.convertToProviders(properties);
        return new InMemoryProviderRepository(providers);
    }
}
