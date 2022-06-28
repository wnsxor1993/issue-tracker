package com.codesquad.issuetracker.domain;

import lombok.*;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@ToString
public class Member {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "member_id")
    private Long id;

    private String resourceServerId;
    private String resourceServerLoginId;
    private String name;
    private String imageUrl;

    @Builder
    public Member(String resourceServerId, String resourceServerLoginId, String name, String imageUrl) {
        this.resourceServerId = resourceServerId;
        this.resourceServerLoginId = resourceServerLoginId;
        this.name = name;
        this.imageUrl = imageUrl;
    }

    public void updateMember(String resourceServerId, String resourceServerLoginId, String name, String imageUrl) {
        this.resourceServerId = resourceServerId;
        this.resourceServerLoginId = resourceServerLoginId;
        this.name = name;
        this.imageUrl = imageUrl;
    }
}
