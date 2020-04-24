package com.dy.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dy.crud.bean.Department;
import com.dy.crud.dao.DepartmentMapper;

@Service
public class DepartmentService {

	@Autowired
	private DepartmentMapper departmentMapper;
	
	public List<Department> getDepts() {
		// TODO Auto-generated method stub
		//selectByExample按照条件查询，返回所有部门，放在list里面
		List<Department> list = departmentMapper.selectByExample(null);
		return list;
	}

}
