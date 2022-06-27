package com.codesquad.issuetracker.oauth;

import java.util.HashMap;
import java.util.Map;

public class OauthAdapter {

    private OauthAdapter() {}

    public static Map<String, OauthProvider> convertToProviders(OauthProperties properties) {
        Map<String, OauthProvider> oauthProvider = new HashMap<>();

        properties.getUserProperties().forEach((key, value) -> oauthProvider.put(key,
                new OauthProvider(value, properties.getProviderProperties().get(key))));
        return oauthProvider;
    }
}
