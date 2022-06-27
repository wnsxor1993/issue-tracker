package com.codesquad.issuetracker.oauth;

import java.util.HashMap;
import java.util.Map;

public class InMemoryProviderRepository {

    private final Map<String, OauthProvider> providers = new HashMap<>();

    public InMemoryProviderRepository(Map<String, OauthProvider> providers) {
        this.providers.putAll(providers);
    }

    public OauthProvider findByProviderName(String name) {
        return providers.get(name);
    }
}
