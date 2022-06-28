package com.codesquad.issuetracker.oauth;

import com.codesquad.issuetracker.excption.OauthProviderNotFoundException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import java.nio.charset.StandardCharsets;
import java.util.Collections;

@Slf4j
@Service
public class OauthService {
    private final InMemoryProviderRepository inMemoryProviderRepository;

    public OauthService(InMemoryProviderRepository inMemoryProviderRepository) {
        this.inMemoryProviderRepository = inMemoryProviderRepository;
    }

    public RedirectView requestCode(String providerName, RedirectAttributes redirectAttributes) {
        OauthProvider oauthProvider = findProvider(providerName);
        redirectAttributes.addAttribute("client_id", oauthProvider.getClientId());
        redirectAttributes.addAttribute("redirect_url", oauthProvider.getRedirectUrl());

        return new RedirectView(oauthProvider.getLoginUrl());
    }

    private OauthProvider findProvider(String providerName) {
        return inMemoryProviderRepository.findByProviderName(providerName)
                .orElseThrow(() -> new OauthProviderNotFoundException("요청에 대응하는 OauthProvider가 존재하지 않습니다."));
    }

    public LoginResponse login(String providerName, String code) {
        // 프론트에서 넘어온 provider 이름을 통해 InMemoryProviderRepository에서 OauthProvider 가져오기
        OauthProvider provider = findProvider(providerName);

        // access token 가져오기
        OauthTokenDto tokenDto = getToken(code, provider);

        log.info("access token : {}", tokenDto);


        // TODO 유저 정보 가져오기
        // TODO 유저 DB에 저장
        return null;
    }

    private OauthTokenDto getToken(String code, OauthProvider provider) {
        return WebClient.create()
                .post()
                .uri(provider.getTokenUrl())
                .headers(header -> {
                    header.setBasicAuth(provider.getClientId(), provider.getClientSecret());
                    header.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
                    header.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
                    header.setAcceptCharset(Collections.singletonList(StandardCharsets.UTF_8));
                })
                .bodyValue(tokenRequest(code, provider))
                .retrieve()
                .bodyToMono(OauthTokenDto.class)
                .block();
    }

    private MultiValueMap<String, String> tokenRequest(String code, OauthProvider provider) {
        MultiValueMap<String, String> formData = new LinkedMultiValueMap<>();
        formData.add("code", code);
        formData.add("grant_type", "authorization_code");
        formData.add("redirect_uri", provider.getRedirectUrl());
        return formData;
    }
}
