<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- web路径
1.不以/开始的相对路径，找资源是以当前资源的路径为基准，经常容易出问题
推荐以“/”开始的相对路径，找资源，以服务器的路径为标准（http://localhost:3306），需要加上项目名

 -->
<!-- 引入Jquery -->
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-3.4.1.min.js"></script>
<!-- 引入样式 -->
<link
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>


        <!-- 员工修改的模态框 -->
                	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                	  <div class="modal-dialog" role="document">
                	    <div class="modal-content">
                	      <div class="modal-header">
                	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                	        <h4 class="modal-title" >员工修改</h4>
                	      </div>
                	      <div class="modal-body">
                	        <!--//内联表单-->
                			<form class="form-horizontal">
                			  <div class="form-group">
                			    <label class="col-sm-2 control-label">empName</label>
                			    <div class="col-sm-10">
                			        //placeholder意思是表单填充的内容
                			    <p class="form-control-static" id="empName_update_static"></p>
                			    </div>
                			  </div>
                			  <div class="form-group">
                			    <label class="col-sm-2 control-label">email</label>
                			    <div class="col-sm-10">
                			      <input type="email" name="email" class="form-control" id="email_update_input" placeholder="email@dy.com">
                			      <span class="help-block"></span>
                			    </div>
                			  </div>
                			  /**
                			  为了springMVC封装方便，提交的数据会自动提供给封装的employee对象，要求表单项的name和Employee.java中的属性名一样
                			  */
                			  <div class="form-group">
                			  <!--内联单选-->
                			    <label class="col-sm-2 control-label">gender</label>
                			    <div class="col-sm-10">
                			      	<label class="radio-inline">
                						<input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                					</label>
                					<label class="radio-inline">
                						<input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                					</label>
                			    </div>
                			   </div>
                			   //部门信息是通过下拉列表来选定的，部门信息应该从数据库中查询
                			  <div class="form-group">
                			    <label class="col-sm-2 control-label">deptName</label>
                			    <div class="col-sm-4">
                			    	<!-- 部门项提交部门id即可 -->
                			      	<select class="form-control" name="dId" ></select>
                			    </div>
                			  </div>
                			</form>

                	      </div>
                	      <div class="modal-footer">
                	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                	        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
                	      </div>
                	    </div>
                	  </div>
                	</div>

    	<!-- 员工添加的模态框 -->
        	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        	  <div class="modal-dialog" role="document">
        	    <div class="modal-content">
        	      <div class="modal-header">
        	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        	        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
        	      </div>
        	      <div class="modal-body">
        	        <!--//内联表单-->
        			<form class="form-horizontal">
        			  <div class="form-group">
        			    <label class="col-sm-2 control-label">empName</label>
        			    <div class="col-sm-10">
        			       <!--placeholder意思是表单填充的内容-->
        			      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
        			      <span class="help-block"></span>
        			    </div>
        			  </div>
        			  <div class="form-group">
        			    <label class="col-sm-2 control-label">email</label>
        			    <div class="col-sm-10">
        			      <input type="email" name="email" class="form-control" id="email_add_input" placeholder="email@dy.com">
        			      <span class="help-block"></span>
        			    </div>
        			  </div>

        			  <!--为了springMVC封装方便，提交的数据会自动提供给封装的employee对象，要求表单项的name和Employee.java中的属性名一样-->

        			  <div class="form-group">
        			  <!--内联单选-->
        			    <label class="col-sm-2 control-label">gender</label>
        			    <div class="col-sm-10">
        			      	<label class="radio-inline">
        						<input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
        					</label>
        					<label class="radio-inline">
        						<input type="radio" name="gender" id="gender2_add_input" value="F"> 女
        					</label>
        			    </div>
        			   </div>
        			   <!--部门信息是通过下拉列表来选定的，部门信息应该从数据库中查询-->
        			  <div class="form-group">
        			    <label class="col-sm-2 control-label">deptName</label>
        			    <div class="col-sm-4">
        			    	<!-- 部门项提交部门id即可 -->
        			      	<select class="form-control" name="dId" id="dept_add_select"></select>
        			    </div>
        			  </div>
        			</form>

        	      </div>
        	      <div class="modal-footer">
        	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        	        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
        	      </div>
        	    </div>
        	  </div>
        	</div>
	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题行 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button type="button" class="btn btn-primary" id = "emp_add_modal_btn">新增</button>
				<button type="button" class="btn btn-danger" id = "emp_delete_all_btn">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id = "ems_table">
				    <thead>
                        <tr>
                            <th>
                                <input type="checkbox" id = "check_all"/>
                            <th>
                            <th>#</th>
                            <th>empName</th>
                            <th>gender</th>
                            <th>email</th>
                            <th>deptName</th>
                            <th>操作</th>
                        </tr>
					</thead>
					<tbody>

					</tbody>
                </table>
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id = "page_info_area">当前页,总页,总条记录
			</div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id = "page_nav_area">

			</div>
		</div>
	</div>
	<script type="text/javascript">

	var totalRecord,currentpage;
	//页面加载完成以后，直接发送一个ajax请求，要到分页数据
	//参考jquery文档
        $(function(){
            //刚进来的时候进第一页
            to_page(1);

        });


	function to_page(pn){
	    $.ajax({
        	        url:"${APP_PATH}/emps",
        	        data:"pn=" + pn,
        	        type:"GET",
        	        success:function(result){
        	        //请求成功的回调函数,result是服务器回应给浏览器的数据
        	            console.log(result);
        	            //1.解析并显示员工数据
        	            build_emps_table(result);
        	            //2.解析并显示分页信息
        	            build_page_info(result);
        	            //3.解析显示分页条的数据
        	            build_page_nav(result);
        	        }
        });
	}

	/**
	注意在每一次构建页面时要将上一次的清空，不然会连着出现之前出现过的页面
	*/

	//构建员工信息
	function build_emps_table(result){
	    //先清空table表
	    $("#emps_table tbody").empty();
	    var emps = extend.pageInfo.list;
	    //第一个是要遍历的元素，第二个是遍历后的回调函数
	    $.each(emps,function(index,item){
            //回调函数的参数：第一个是索引，第二个是当前的对象
            //alter(item.empName);测试数能否正常显示
            //构建要显示每个单元格要显示的数据
            var checkBoxTd = $("<td><input type ='checkbox' class = 'check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == 'M' ?'男':'女');
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd =  $("<td></td>").append(item.department.deptName);
            /**
            *<button type="button" class="btn btn-primary btn-sm">
            *		<span class="glyphicon glyphicon-paperclip" aria-hidden="true"></span>
            *					编辑
            *</button>
            */
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                            .append($("<span></span>").addClass("glyphicon glyphicon-paperclip")).append("编辑");
                            //attr 可以为变量添加属性值
                //这里是为编辑按钮添加一个自定义的属性，来表示当前员工的id
                editBtn.attr("edit-id",item.empId);
             /**
             *<button type="button" class="btn btn-danger btn-sm">
             *		<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
             *			删除
             *</button>
             */
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                            .append($("<span></span>").addClass("glyphicon glyphicon-remove")).append("删除");
                             delBtn.attr("del-id",item.empId);
            //将两个按钮放在同一个单元格中
             var btnTd = $("<td></td>").append(editBtn).append(" p").append(delBtn);
            //之所以可以做链式操作，是因为append方法执行完成后还是返回原来的元素
            $("<tr></tr>").append(checkBoxTd)
            .append(empIdTd)
            .append(empNameTd)
            .append(genderTd)
            .append(emailTd)
            .append(deptNameTd)
            .append(btnTd)
            //声明数据存放位置
            .appendTo("#emps_table tbody");
	    });
	}
	//解析显示分页信息，且要能够跳转页面
	function build_page_info(result){
	    $("#emps_info_area").empty();
	    $("page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页",
	    "总"+result.extend.pageInfo.pages+"页",
	    "总"+result.extend.pageInfo.total+"条记录")
	    var totalRecord = result.extend.pageInfo.total;
        var currentpage= result.extend.pageInfo.pageNum;
	}
	//解析显示分页条
	function build_page_nav(result){
         $("#page_nav_area").empty();
         //page_nav_area
	     var ul = $("<ul></ul>").addClass("pagination");
         var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
         var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));

        //逻辑关系：有上一页和首页才能翻页
        if(result.extend.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }
        else{
            //为第一页和前一页添加翻页事件
            firstPageLi.click(function(){
                to_page(1);
            });
            prePageLi.click(function(){
                 to_page(result.extend.pageInfo.pageNum - 1);
            });

        }


	    var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
	    var lastpageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));

        //逻辑关系：有下一页和末页才能翻页
        if(result.extend.pageInfo.hasNextviousPage == true){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }
        else{
            //为下一页和最后一页添加翻页事件
            lastPageLi.click(function(){
                  to_page(result.extend.pageInfo.pages);
            });
            nextPageLi.click(function(){
                  to_page(result.extend.pageInfo.pageNum + 1);
            });

        }




	    //添加首页和前一页
	    ul.append(firstPageLi).append(prePageLi)
	    //遍历给ul中添加页码号
	    $.each(result.extend.pageInfo.navigatepageNums,function(index,item){
	        var numLi = $("<li></li>").append($("<a></a>").append(item));
	        if(result.pageInfo.pageNum == item){
	            numLi.addClass("active");
	        }
	        //绑定单击事件，点击页码后，发送一个ajax请求，去当前点击的页码
	        numLi.click(function(){
	            to_page(item);
	        });
	        ul.append(numLi);
	    });
	    //添加末页和下一页
	    ul.append(nextPageLi).append(lastpageLi);

	    //把ul加入到nav元素中
	    var navEle = $("<nav></nav>").append(ul);
	    navEle.appendTo("#page_nav_area");
	}

	function reset_form(ele){
	//1.清空表单内容
	    $(ele)[0].reset();
	//2.清空表单样式
	    $(ele).find("*").removeClass("has-error has-success");
	    $(ele).find(".help-block").text("");
	}

	//点击新增按钮弹出模态框
	$("#emp_add_modal_btn").click(function(){
    	    //清除表单数据(表单重置),jequry没有重置方法，取出dom对象把表单重置
    	    //表单重置应该包括表单的数据和表单的完整样式
    	   // console.log("gook")
    	    reset_form("#empAddModal form");

    	    //发送一个ajax请求，查出部门信息，显示在下拉列表中
            getDepts("#empAddModal select");

    	    //弹出模态框
    	    //模态框的id是empAddModal
    	    $("#empAddModal").modal({
    	    //点击背景不删除模态框
    	        backdrop:"static"
    	    });
    	    //console.log("happy")
    	});
    //查出所有的部门信息
	function getDepts(ele){
	//清空之前下拉列表的值
	$(ele).empty();
	    $.ajax({
	        //获取所有的部门信息
	        url:"${APP_PATH}/depts",
	        type:"GET",
	        success:function(result){
	            //result里都是部门信息
	            //在浏览器的控制打印
	            //console.log(result);
	            //$("#empAddModal select").append("")
	            $.each(result.extend.depts,function(){
	                //attr添加的是option提交时的value值,this代表当前遍历的元素，value值就是当前遍历元素的id
	                var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
	                optionEle.appendTo(ele);
	            });
	        }
	    });
	}

	//校验表单数据

	//显示校验结果的提示信息
	function show_validate_msg(ele,status,msg){
	    //清除当前元素状态
	     $(ele).parent().removeClass("has-success has-error");
	     $(ele).next("span").text("");
	    if(status == "success"){
	         $(ele).parent().addClass("has-success");
             $(ele).next("span").text(msg);
	    }else if(status == "error"){
	         $(ele).parent().addClass("has-error");
             $(ele).next("span").text(msg);
	    }
	}

	$("empName_add_input").change(function(){
	    //发送ajax请求检验用户名是否可用
	    var empName = this.value;
	    $.ajax({
	        url:"{APP_PATH}/checkuser",
	        data:"empName=" + empName,
	        type:"POST",
	        success:function(result){
	            if(result.code == 100){
	                show_validate_msg("empName_add_input","success","用户名可用");

	            }
	            else{
	                show_validate_msg("empName_add_input","error",result.extend.va-mag);
	                $("#emp_save_btn").attr("ajax-va","error");
	            }
	        }
	    });
	});

    //点击保存，保存员工
	$("emp_save_btn").click(function(){
	    //1.模态框中输入的数据提交给服务器进行保存
	    //1.先要对提交给服务器的数据进行校验
	    if(!validate_add_form()){
	        return false;
	    };
	    //1.判断之前的Ajax用户名校验是否成功，如果成功，则保存。
	    if($(this).attr("ajax-va") == "error"){
	        return false;
	    }
	    //2.发送ajax请求保存员工
	    //alter是显示数据的作用
	    alter($("#empAddModel form").serialize());
	    $.ajax({
	        url:"${APP_PATH}/emp",
	        type:"POST",
	        data:$("#empAddModel form").serialize(),
	        success:function(result){
	            if(result.code == 100){
	                //alter(result.Msg);
                   	//员工保存成功：1.关闭模态框
                   	$("#empAddModal").modal("hide");
                   	//2.来到最后一页，显示刚才保存的数据,发送Ajax请求来到最后一页
                   	to_page(totalRecord);
	            }else{
	                //显示失败信息
	                //console.log(result);
	                //有哪个字段的错误信息就显示哪个字段的
	                if(undefined != result.extend.errorFields.email){
	                    //显示邮箱错误信息
	                    show_validate_msg("#email_add_input","error",result.extend.errorFields.email)
	                }
	                if(undefined != result.extend.errorFields.empName){
	                    //显用户名的错误信息
	                    show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName)
	                }
	            }


	        }
	    });
	});


    $(document).on("click","edit_btn",function(){


        //1.查出部门信息，并显示部门列表
        getDepts("#empUpdateModal select");
        //2.查出员工信息，调用函数，显示员工信息
        getEmp($(this).attr("edit-id"));
        //3.把员工的id传给更新按钮
        $("emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
        //弹出模态框
        $("#empUpdateModal").modal({
        	    //点击背景不删除模态框
        	        backdrop:"static"
        	    });

    });
    //查出员工信息，显示员工信息的函数
    function getEmp(id){
        $.ajax({
            url:"{APP_PATH}/emp"+id,
            type:"GET",
            success:function(result){
                var empDate = result.extend.emp;
                $("empName_update_static").text(empDate.empName);
                //val方法是用于给input框赋值
                $("email_update_input").val(empDate.email);
                $("#empUpdateModal input[name=gender]").val([empDate.gender]);
                $("#empUpdateModal select").val([empDate.dId]);
            }
        });
    }

    //为更新按钮添加点击事件，点击更新，更新员工数据
    $("emp_update_btn").click(function(){
        //验证邮箱是否合法
        var email = $("email_add_input").val();//获取邮箱的值
        	    var regemail =  /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        	    if(!regemail.test(email)){
        	        //alter("邮箱格式错误");
        	        show_validate_msg("#email_update_input","error","邮箱格式错误");
        	        return false;
        	    }
        	    else{
        	        show_validate_msg("#email_update_input","success","");
        	    }
        //发送ajax请求，保存更新的员工数据
        $.ajax({
            url:"${APP_PATH}/emp"+$(this).attr("edit-id"),
            //方法一：
            //会进入web.xml中，使用过滤器，将POST请求 转换成PUT请求
            //type:"POST",
            //data:$("empUpdateModal form").serialize()+"&method=PUT",
            //方法二：
            type:"PUT",
            data:$("empUpdateModal form").serialize(),
            success:function(result){
                //alter(result.msg);
                //1.关闭对话框，
                $("#empUpdateModal").modal("hide");
                //2.回到本页面
                to_page(currentpage);
            }
        });
    });


    //为单个删除绑定点击事件
    $(document).on("click","delete_btn",function(){
        //1.弹出是否确认删除对话框
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("del-id");
        if(confirm("确认删除【"+empName+"】吗？")){
            //确认，发送ajax请求删除即可
            $.ajax({
                url:"{APP_PATH}/emp/"+empId,
                type:"DELETE",
                success:function(result){
                    alter(result.msg);
                    to_page(currentpage);
                }
            });
        }
    });

    //完成全选或全不选的功能
    $("check_all").click(function(){
       //attr获取checked是undefined；
       //我们这些dom原生的属性，使用prop获取，attr用于获取自定义属性的值
       //让所有框的值都与当前框相同，实现全选或全不选
       $(".check_item").prop("checked",$(this).prop("checked"));
    });

    $(document).on("click","check_item",function(){

        //判断当前选中的元素是否选满
         var flag = $(".check_item:checked").length == $(".check_item").length();
         $("check_all").prop("checked",flag);

         });

         //点击全部删除，就批量删除
         var empNames = "";
         var del_idstr = "";
         $("#emp_delete_all_btn").click(function(){
            $.each($(".check_item:checked"),function(){
                empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
                del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
            });
            //去除empNames多余的","
            empNames = empNames.substring(0,empNames.length-1);
            //去除del_idstr多余的"-"
            del_idstr = del_idstr.substring(0,del_idstr.length-1);
            if(confirm("确认删除【"+empNames+"】吗？")){
                //发送ajax请求删除
                $.ajax({
                    url:"${APP_PATH}/emp/"+del_idstr,
                    type:"DELETE",
                    success:function(result){
                        alter(result.msg);
                        to_page(currentpage);
                    }
                });
            }
         });

	</script>

</body>
</html>