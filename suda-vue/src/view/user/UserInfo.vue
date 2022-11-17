<!-- @format -->

<template>
  <div class="user">
    <!-- 编辑用户信息dialog开始 -->
    <fx-dialog
      :dialogVisible="dialogEditVisible"
      :userForm="userForm"
      @updateUserInfo="onUpdateUserInfo"
      :formLabelWidth="formLabelWidth"
      @cancelDialog="onCancelEdit"
      :title="editDialogTitle"
      :userLabel="userLabel"
    ></fx-dialog>
    <!-- 编辑用户信息dialog结束 -->
    <!-- 新增用户dialog开始 -->
    <fx-dialog
      :dialogVisible="dialogAddVisible"
      :userForm="userForm"
      @updateUserInfo="addUser"
      :formLabelWidth="formLabelWidth"
      @cancelDialog="onCancelEdit"
      :title="addDialogTitle"
      :userLabel="addUserLabel"
    ></fx-dialog>
    <!-- 新增用户dialog结束 -->
    <el-card>
      <!-- 头部搜索表单开始 -->
      <el-form
        :inline="true"
        :model="formInline"
        class="demo-form-inline"
        height="100%"
      >
        <el-form-item label="查询">
          <el-input
            v-model="formInline.username"
            placeholder="请输入用户名"
          ></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="onSearchReset">重置</el-button>
          <el-button type="primary" @click="onSearchUser(formInline.username)"
            >查询</el-button
          >
        </el-form-item>
        <br />
        <el-form-item label="新增">
          <el-button type="primary" @click="dialogAddVisible = true"
            >新增用户</el-button
          >
        </el-form-item>
      </el-form>
      <!-- 头部搜索表单结束 -->
      <!-- 用户信息表格开始 -->
      <fx-table
        :tableList="currentUserList"
        @editUser="onEditUser"
        @delUser="onDelUser"
        :emptyText="emptyText"
        :userLabel="userLabel"
      ></fx-table>
      <!-- 用户信息表格结束 -->
      <!-- 分页功能开始 -->
      <el-pagination
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page="currentPage"
        :page-sizes="[5, 10, 20, 50]"
        :page-size="pageSize"
        layout="total, sizes, prev, pager, next, jumper"
        :total="total"
      >
      </el-pagination>
      <!-- 分页功能结束 -->
    </el-card>
  </div>
</template>

<script>
import FxTable from "@/components/common/table/FxTable.vue";
import FxDialog from "@/components/common/dialog/FxDialog.vue";
import {
  getAllUser,
  getUserByUsername,
  updateUserInfo,
  deleteUser,
  insertUser,
} from "../../api/user.js";

export default {
  name: "User",
  components: {
    FxTable,
    FxDialog,
  },
  data() {
    return {
      userList: [], // 所有用户数据
      currentPage: 1, // 当前页
      pageSize: 5, // 每页显示数据条数
      total: 0, // 数据总条数
      dialogEditVisible: false, // 控制编辑用户信息dialog的显隐
      formInline: {
        username: "",
      },
      emptyText: "", // 查询为空时的提示信息
      dialogAddVisible: false, // 控制新增用户dialog的显隐
      formLabelWidth: "120px", // 编辑信息dialog表单label宽度
      editDialogTitle: "编辑用户", // 编辑用户dialog的title
      addDialogTitle: "新增用户", // 新增用户dialog的title
      // 新增用户
      newUser: {
        u_id: "",
        u_username: "",
        u_password: "",
        u_nickname: "",
        u_gender: "",
        u_age: "",
        u_address: "",
        r_id: "",
        u_avatar: "",
      },
      // 新增用户的label信息
      addUserLabel: [
        {
          label: "用户名",
          value: "u_username",
          width: 120,
          isEdit: false,
          type: "input",
        },
        {
          label: "密码",
          value: "u_password",
          width: 120,
          isEdit: false,
          type: "password",
        },
        {
          label: "昵称",
          value: "u_nickname",
          width: 120,
          isEdit: false,
          type: "input",
        },
        {
          label: "性别",
          value: "u_gender",
          width: 120,
          isEdit: false,
          type: "radio",
          child: [
            {
              label: "男",
            },
            {
              label: "女",
            },
          ],
        },
        {
          label: "年龄",
          value: "u_age",
          width: 120,
          isEdit: false,
          type: "input",
        },
        {
          label: "地址",
          value: "u_address",
          width: 150,
          isEdit: false,
          type: "input",
        },
        {
          label: "角色",
          value: "r_id",
          width: 150,
          isEdit: false,
          type: "select",
          child: [
            {
              label: "普通用户",
              value: 1,
            },
            {
              label: "管理员",
              value: 2,
            },
          ],
        },
        {
          label: "头像",
          value: "u_avatar",
          width: 120,
          isEdit: false,
          type: "input",
        },
      ],
      // 当前用户信息
      userForm: {
        u_id: "",
        u_username: "",
        u_nickname: "",
        u_gender: "",
        u_age: "",
        u_address: "",
        r_id: "",
        u_avatar: "",
      },
      // 用户的label信息
      userLabel: [
        {
          label: "用户ID",
          value: "u_id",
          width: 80,
          isEdit: true,
          type: "input",
        },
        {
          label: "用户名",
          value: "u_username",
          width: 120,
          isEdit: true,
          type: "input",
        },
        {
          label: "昵称",
          value: "u_nickname",
          width: 120,
          isEdit: false,
          type: "input",
        },
        {
          label: "性别",
          value: "u_gender",
          width: 120,
          isEdit: false,
          type: "radio",
          child: [
            {
              label: "男",
            },
            {
              label: "女",
            },
          ],
        },
        {
          label: "年龄",
          value: "u_age",
          width: 120,
          isEdit: false,
          type: "input",
        },
        {
          label: "地址",
          value: "u_address",
          width: 150,
          isEdit: false,
          type: "input",
        },
        {
          label: "角色",
          value: "r_id",
          width: 150,
          isEdit: true,
          type: "input",
        },
        {
          label: "头像",
          value: "u_avatar",
          width: 120,
          isEdit: false,
          type: "input",
        },
      ],
      // 新增用户角色选项,
      optionsRole: [
        {
          label: "普通用户",
          value: 1,
        },
        {
          label: "管理员",
          value: 2,
        },
      ],
    };
  },
  methods: {
    // 改变每页的数据条数
    handleSizeChange(val) {
      // console.log(`每页 ${val} 条`);
      this.pageSize = val;
    },
    // 改变当前页数
    handleCurrentChange(val) {
      // console.log(`当前页: ${val}`);
      this.currentPage = val;
    },
    // 根据用户名查询用户
    async onSearchUser(username) {
      // 如果没有输入用户，则不需要调用接口
      if (username === "") {
        return;
      }
      const params = {
        u_username: username,
      };
      const { data } = await getUserByUsername(params);
      // console.log("data=", data);
      // 如果未查到该用户
      if (data.user.length === 0) {
        this.emptyText = data.message;
      }
      // 查询之后，当前页改为第一页
      this.currentPage = 1;
      // 更新数据总数
      this.total = data.count;
      this.userList = data.user;
    },
    // 重置查询用户名信息
    async onSearchReset() {
      this.userList = [];
      // 清空搜索框内容
      this.formInline.username = "";
      const { data } = await getAllUser();
      this.userList.push(...data.data.user);
      this.userList = this.userList.filter(
        (item) => (item.r_id = item.r_id === 1 ? "普通用户" : "管理员")
      );
      this.total = this.userList.length;
    },
    // 编辑用户
    onEditUser(userInfo) {
      this.userForm = userInfo;
      this.dialogEditVisible = true;
    },
    // 删除用户
    async onDelUser(index, row) {
      // console.log("index=", index)
      // console.log("row=", row);
      const { data } = await deleteUser(row.u_id);
      // console.log("data=", data);
      if (data.status === 0) {
        let ind = 0;
        this.userList.forEach((item, i) => {
          if (item.u_id === row.u_id) {
            return (ind = i);
          }
        });
        // console.log(ind)
        this.userList.splice(ind, 1);
        this.$message({
          type: "success",
          message: data.message,
        });
      } else {
        this.$message({
          type: "error",
          message: "删除失败",
        });
      }
      this.total = this.userList.length;
    },
    // 添加用户
    async addUser(user) {
      const { data } = await insertUser(user);
      // console.log("data=", data);
      if (data.status === 1)
        return this.$message({
          type: "warning",
          message: data.message,
        });
      this.$message({
        type: "success",
        message: data.message,
      });
      data.data.r_id = data.data.r_id === 1 ? "普通用户" : "管理员";
      this.dialogAddVisible = false;
      this.userList.push(data.data);
    },
    // 更新用户信息
    async onUpdateUserInfo(user) {
      // 改变后台数据
      typeof(user.r_id) == "string" ? user.r_id = (user.r_id === "普通用户" ? 1 : 2) : ""
      const { data } = await updateUserInfo(user);
      if (data.status === 0) {
        this.$message({
          type: "success",
          message: data.message,
        });
        let ind = 0;
        this.userList.forEach((item, index) => {
          if (item.u_id == user.u_id) {
            return (ind = this.userList.indexOf(item));
          }
        });
        // 改变前台数据
        this.userList[ind].u_nickname = user.u_nickname;
        this.userList[ind].u_gender = user.u_gender;
        this.userList[ind].u_age = user.u_age;
        this.userList[ind].u_address = user.u_address;
        this.userList[ind].u_avatar = user.u_avatar;
        this.dialogEditVisible = false;
      }
    },
    // 取消编辑用户信息
    onCancelEdit(visible) {
      this.dialogEditVisible = visible;
      this.dialogAddVisible = visible;
    },
  },
  computed: {
    currentUserList() {
      return this.userList.slice(
        (this.currentPage - 1) * this.pageSize,
        this.currentPage * this.pageSize
      );
    },
  },
  async mounted() {
    const { data } = await getAllUser();
    this.userList.push(...data.data.user);
    this.userList = this.userList.filter(
      (item) => (item.r_id = item.r_id === 1 ? "普通用户" : "管理员")
    );
    this.total = this.userList.length;
  },
};
</script>

<style lang="less">
.user .el-table th,
.user .el-table tr {
  background-color: rgba(@primaryTableColor, 1);
}
.el-card .el-table {
  margin-bottom: 20px;
}
</style>
