package com.dy.crud.test;

import com.dy.crud.bean.Department;
import com.dy.crud.dao.DepartmentMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class TestCrud {


    @Autowired
    SqlSession sqlSession;

    @Autowired
    DepartmentMapper departmentMapper;

    @Test
    public void testMapper(){
        departmentMapper = sqlSession.getMapper(DepartmentMapper.class);
        departmentMapper.insertSelective(new Department(null,"qwe"));
    }
}
