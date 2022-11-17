<!-- @format -->
<!-- 表格组件封装 -->

<template>
  <div class="table">
    <!-- 表格组件开始 -->
    <el-table :data="tableList" :empty-text="emptyText">
      <el-table-column
        v-for="(item, index) in userLabel"
        :key="index"
        :prop="item.value"
        :label="item.label"
        :width="item.width"
      >
      </el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <slot name="operation"></slot>
          <el-button size="mini" @click="onEditUser(scope.$index, scope.row)"
            >编辑</el-button
          >
          <el-popconfirm
            confirm-button-text="是"
            cancel-button-text="否"
            icon="el-icon-info"
            icon-color="red"
            confirm-button-type="danger"
            title="删除该用户？"
            @confirm="onDelUser(scope.$index, scope.row)"
          >
            <el-button size="mini" type="danger" slot="reference"
              >删除</el-button
            >
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>
    <!-- 表格组件结束 -->
  </div>
</template>

<script>
export default {
  name: "FxTable",
  props: {
    // 表格数据
    tableList: {
      type: Array,
    },
    // 列表为空时的提示信息
    emptyText: {
      type: String,
    },
    userForm: {
      type: Object,
    },
    userLabel: {
      type: Array,
    },
  },
  data() {
    return {
      dialogEditVisible: false, // 控制编辑用户信息dialog的显隐
    };
  },
  methods: {
    // 编辑用户
    onEditUser(index, row) {
      const userForm = {...row};
      this.$emit("editUser", userForm);
    },
    // 删除用户
    onDelUser(index, row) {
      this.$emit("delUser", index, row);
    },
  },
  computed: {},
  mounted() {},
};
</script>

<style></style>
