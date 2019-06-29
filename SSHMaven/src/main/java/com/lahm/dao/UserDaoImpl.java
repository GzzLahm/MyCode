package com.lahm.dao;


import com.lahm.entity.User;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class UserDaoImpl extends HibernateDaoSupport implements UserDao{
	@Autowired//根据类型注入spring工厂中的会话工厂对象sessionFactory
	public void setMySessionFactory(SessionFactory sessionFactory){
		super.setSessionFactory(sessionFactory);
	}
	public void insertUser(User user) {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().save(user);
	}

}
