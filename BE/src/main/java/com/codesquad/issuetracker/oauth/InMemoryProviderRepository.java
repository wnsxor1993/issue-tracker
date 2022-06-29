package com.codesquad.issuetracker.oauth;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

public class InMemoryProviderRepository {

    private final Map<String, OauthProvider> providers = new HashMap<>();

    public InMemoryProviderRepository(Map<String, OauthProvider> providers) {
        this.providers.putAll(providers);
    }

    public Optional<OauthProvider> findByProviderName(String name) {
        OauthProvider oauthProvider = providers.get(name);

        return Optional.ofNullable(oauthProvider);
    }
}
