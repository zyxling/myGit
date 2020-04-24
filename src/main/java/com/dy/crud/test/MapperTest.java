/*
package com.dy.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dy.crud.bean.Department;
import com.dy.crud.bean.Employee;
import com.dy.crud.dao.DepartmentMapper;
import com.dy.crud.dao.EmployeeMapper;

*/
/**
 * 测试dao层的工作
 * 推荐Spring的项目就可以使用Spring的单元测试，可以字段注入我们需要的组件
 * 1.导入SpringTest模块
 * 2.使用@ContextConfiguration注解指定Spring配置文件的位置
 * 3.直接autowired要使用的组件即可
 * @author dy
 *
 *//*

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    */
/**
     * 测试DepartmentMapper
     *//*

    @Test
    public void testCRUD() {
//        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//        System.out.println(mapper);
//        for (int i = 0; i < 10; i++) {
//            System.out.println("---------for in------ ");
//            String uid = UUID.randomUUID().toString().substring(0, 5)+i;
//            System.out.println("insert-------------");
//            //mapper.insertSelective(new Employee(null, uid, "M",uid+"@dy.com", 1));
//            mapper.insertSelective()
//        }
//        System.out.println("执行完成");
        DepartmentMapper departmentMapper = sqlSession.getMapper(DepartmentMapper.class);
        for(int i = 0 ; i < 10; i ++){
            new Department(null,i);
            departmentMapper.insertSelective();
        }
        System.out.println("ok");
    }
}
*/
