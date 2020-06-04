package com.codesquad.airbnb5.service;

import com.codesquad.airbnb5.dao.UserDao;
import com.codesquad.airbnb5.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserDao userDao;

    public UserService(UserDao userDao) {
        this.userDao = userDao;
    }

    public void insertOrUpdateUser(User user) {
        userDao.insertOrUpdateUser(user);
    }

}
