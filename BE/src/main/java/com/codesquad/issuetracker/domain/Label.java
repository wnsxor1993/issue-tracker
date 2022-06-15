package com.codesquad.issuetracker.domain;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Label {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "label_id")
    private Long id;

    private String name;

    private String description;

    @Embedded
    private LabelColor labelColor;

    public Label(String name, String description, LabelColor labelColor) {
        this.name = name;
        this.description = description;
        this.labelColor = labelColor;
    }
}
