package com.dy.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import com.dy.crud.bean.Employee;
import com.dy.crud.bean.Msg;
import com.dy.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
/*
*
 * 处理员工的CRUD请求
 *
 * @author dy
 *
 */

@Controller
public class EmployeeControll{

    @Autowired
    EmployeeService employeeService;


/*    *//*
    员工单个删除
    * *//*
    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.DELETE)
    public Msg deleteEmpById(@PathVariable("id")Integer id){
        employeeService.deleteEmp(id);
        return Msg.success();
    }*/

    /*单个删除，批量删除二合一

    * */

    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids")String ids){
        if(ids.contains("-")){
            List<Integer>del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            //组装id的集合
            for(String string : str_ids){
                del_ids.add(Integer.parseInt(string));
            }
            employeeService.deleteBatch(del_ids);
        }else{
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }


    /*员工更新方法
    Tomcat一看是PUT请求，不会封装请求体中的数据为map，只有POST形式的请求才封装请求体为map
    我们要支持直接发送PUT之类的请求还要封装请求体中的数据，可以在web.xml中配置上HiddenHttpMethodFilter，
    * */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg saveEmp(Employee employee){
        System.out.println("将要更新的员工数据"+employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }


    /*根据id查询员工
    * */
    @RequestMapping(value = "emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    //@PathVariable用于声明这里的Integer id是源于上面的value = "emp/{id}"
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }


    /*
    返回jeason数据，检查用户名是否可用
    */

    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkuse(@RequestParam("empName") String empName){
        //先判断用户名是否是合法的表达式
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
        if(empName.matches(regx)){
            return Msg.fail().add("va_mag","用户名必须是6-16为的英文和数字组合，或者2-5为中文");
        }
        //数据库重复校验
        boolean b= employeeService.checkUser(empName);
        if (b == true){
            return Msg.success();
        }else{
            return Msg.fail().add("va-mag","用户名不可用");
        }
    }


    /*员工保存
    1.支持JSR303校验
    2.导入Hibernate-Validator包
    * */
    @ResponseBody
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            //校验失败，应该返回失败信息
            //将错误信息封装在map里返回给浏览器-
            Map<String,Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for(FieldError fieldError : errors){
                System.out.println("错误的字段为"+fieldError.getField());
                System.out.println("错误信息"+fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFieldError",map);
        }
        else{
            employeeService.saveEmp(employee);
            return  Msg.success();
        }
    }


/**
     * 导入jackson包
     */

    @RequestMapping("/emps")//新的处理emps请求的方法
    @ResponseBody//自动把返回的对象转为字符串
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 5);
        List<Employee> emps = employeeService.getAll();
        PageInfo page = new PageInfo(emps, 5);
        return Msg.success().add("pageInfo", page);//链式操作
    }
    /*
    * 查询员工数据（分页查询）
     */

     /*@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        // 为了方便引入PageHelper分页插件
        // 在查询之前，只需要调用下面的方法,传入页码，以及每页的大小
        PageHelper.startPage(pn, 5);
        // startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        // 使用PageInfo包装查询后的结果，只需要将PageInfo交给页面就行了
        // 其中封装了详细的分页信息，包括有我们查询出来的信息,传入连续显示的页数
        PageInfo page = new PageInfo(emps, 5);
        model.addAttribute("pageInfo", page);
        //通过model将查询的数据带回请求域
        return "list";
    }*/
}
