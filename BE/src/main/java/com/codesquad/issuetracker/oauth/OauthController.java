package com.codesquad.issuetracker.oauth;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import javax.validation.Valid;

@Slf4j
@RestController
@RequiredArgsConstructor
public class OauthController {

    private final OauthService oauthService;

    @GetMapping("/login/code/{provider}")
    public RedirectView getCode(@PathVariable String provider, RedirectAttributes redirectAttributes) {
        return oauthService.requestCode(provider, redirectAttributes);
    }

    @PostMapping("/login/oauth/{provider}")
    public ResponseEntity<LoginResponse> login(@PathVariable String provider, @RequestBody @Valid LoginRequest loginRequest) {
        LoginResponse loginResponse = oauthService.login(provider, loginRequest.getCode());
        return ResponseEntity.ok().body(loginResponse);
    }

}
