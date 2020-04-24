package com.dy.crud.bean;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Email;

public class Employee {
	private Integer empId;

	//Pattern表示自定义规则
	@Pattern(regexp = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})", message = "用户名必须是2-5位的中文或者6-16位的英文数字组合")
	private String empName;

	private String gender;

	/*Email注解可以快捷校验邮箱格式正确性
	 @Email
	注意：在正则表达式中 \. 指下一个点是一个真正的点
	Java中 \ 是转义字符，所以真正的斜杠需要双斜杠*/

	@Pattern(regexp = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$",
			message = "邮箱格式不正确")
	private String email;

	private Integer dId;

	// 希望查询员工信息的同时,部门信息也一并查询
	private Department department;

	public Employee() {
		super();
	}

	public Employee(Integer empId, String empName, String gender, String email, Integer dId) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.gender = gender;
		this.email = email;
		this.dId = dId;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public Integer getEmpId() {
		return empId;
	}

	public void setEmpId(Integer empId) {
		this.empId = empId;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName == null ? null : empName.trim();
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender == null ? null : gender.trim();
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email == null ? null : email.trim();
	}

	public Integer getdId() {
		return dId;
	}

	public void setdId(Integer dId) {
		this.dId = dId;
	}
}
