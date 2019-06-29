package com.lahm.action;

import com.lahm.entity.User;
import com.lahm.service.UserService;
import com.opensymphony.xwork2.ActionSupport;
import org.springframework.beans.factory.annotation.Autowired;

public class UserAddAction extends ActionSupport {
    /**
     *
     */
    private static final long serialVersionUID = -1L;
    @Autowired
    private UserService userService;
    private User user;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        userService.addUser(user);
        return SUCCESS;
    }

}
