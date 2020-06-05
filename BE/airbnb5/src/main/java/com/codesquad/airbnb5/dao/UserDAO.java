package com.codesquad.airbnb5.dao;

import com.codesquad.airbnb5.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;

@Repository
public class UserDAO {

    private final NamedParameterJdbcTemplate namedParameterJdbcTemplate;
    private JdbcTemplate jdbcTemplate;

    @Autowired
    public UserDAO(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
        namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

    public void insertOrUpdateUser(User user) {
        String sql = "INSERT INTO user (github_id, github_name, github_email) " +
                "VALUES (:github_id, :github_name, :github_email) " +
                "ON DUPLICATE KEY " +
                "UPDATE github_name = :github_name, github_email = :github_email";
        SqlParameterSource sqlParameterSource = new MapSqlParameterSource()
                .addValue("github_id", user.getGithubId())
                .addValue("github_name", user.getGithubName())
                .addValue("github_email", user.getGithubEmail());
        namedParameterJdbcTemplate.update(sql, sqlParameterSource);
    }
}
