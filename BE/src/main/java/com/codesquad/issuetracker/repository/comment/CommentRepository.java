package com.codesquad.issuetracker.repository.comment;

import com.codesquad.issuetracker.domain.Comment;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CommentRepository extends JpaRepository<Comment, Long>, CommentCustomRepository {

}
