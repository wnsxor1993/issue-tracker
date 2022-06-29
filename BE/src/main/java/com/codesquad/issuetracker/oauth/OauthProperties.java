package com.codesquad.issuetracker.oauth;

import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.ConstructorBinding;

import java.util.HashMap;
import java.util.Map;

@Getter
@Slf4j
@ConfigurationProperties(prefix = "oauth2")
@ConstructorBinding
public class OauthProperties {

    private final Map<String, User> user = new HashMap<>();

    private final Map<String, Provider> provider = new HashMap<>();

    @Getter
    public static class User {
        private final String clientId;
        private final String clientSecret;
        private final String redirectUrl;
        private final String loginUrl;

        public User(String clientId, String clientSecret, String redirectUrl, String loginUrl) {
            this.clientId = clientId;
            this.clientSecret = clientSecret;
            this.redirectUrl = redirectUrl;
            this.loginUrl = loginUrl;
        }
    }

    @Getter
    public static class Provider {
        private final String tokenUrl;
        private final String userUrl;

        public Provider(String tokenUrl, String userUrl) {
            this.tokenUrl = tokenUrl;
            this.userUrl = userUrl;
        }
    }
}
