package com.codesquad.issuetracker.oauth;

import lombok.Getter;
import org.springframework.boot.context.properties.ConfigurationProperties;

import java.util.HashMap;
import java.util.Map;

@Getter
@ConfigurationProperties(prefix = "oauth2")
public class OauthProperties {

    private final Map<String, User> user = new HashMap<>();

    private final Map<String, Provider> provider = new HashMap<>();

    @Getter
    public static class User {
        private final String clientId;
        private final String clientSecret;
        private final String redirectUri;

        public User(String clientId, String clientSecret, String redirectUri) {
            this.clientId = clientId;
            this.clientSecret = clientSecret;
            this.redirectUri = redirectUri;
        }
    }

    @Getter
    public static class Provider {
        private final String tokenUri;
        private final String userInfoUri;
        private final String userNameAttribute;

        public Provider(String tokenUri, String userInfoUri, String userNameAttribute) {
            this.tokenUri = tokenUri;
            this.userInfoUri = userInfoUri;
            this.userNameAttribute = userNameAttribute;
        }
    }
}
