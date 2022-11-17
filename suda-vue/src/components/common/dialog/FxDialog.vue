<!-- @format -->

<template>
  <div class="dialog">
    <!-- 点击编辑用户信息dialog开始 -->
    <!-- 点击编辑用户信息diaplog结束 -->
    <el-dialog :title="title" :visible.sync="dialogVisible" width="50%">
      <el-form :mode="userForm">
        <el-form-item
          v-for="(item, index) in userLabel"
          :key="index"
          :label="item.label"
          :label-width="formLabelWidth"
        >
          <!-- 普通文本框 -->
          <el-input
            v-if="item.type === 'input'"
            v-model="userForm[item.value]"
            autocomplete="off"
            :disabled="item.isEdit"
            :type="item.type"
          ></el-input>
          <!-- 密码框 -->
          <el-input
            v-else-if="item.type === 'password'"
            v-model="userForm[item.value]"
            autocomplete="off"
            :disabled="item.isEdit"
            type="password"
          ></el-input>
          <!-- 单选框 -->
          <el-radio-group
            v-else-if="item.type === 'radio'"
            v-model="userForm[item.value]"
          >
            <el-radio
              v-for="(it, i) in item.child"
              :key="i"
              :label="it.label"
            ></el-radio>
          </el-radio-group>
          <!-- 多选框 -->

          <!-- 下拉菜单 -->
          <el-select
            v-else-if="item.type === 'select'"
            v-model="userForm[item.value]"
          >
            <el-option
              v-for="(it, i) in item.child"
              :key="i"
              :label="it.label"
              :value="it.value"
            ></el-option>
          </el-select>
          <span v-else>{{ userForm[item.value] }}</span>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="onCancel">取 消</el-button>
        <el-button type="primary" @click="onUpdateUserInfo(userForm)"
          >确 定</el-button
        >
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "FxDialog",
  props: {
    dialogVisible: {
      type: Boolean,
    },
    formLabelWidth: {
      type: String,
    },
    userForm: {
      tyle: Object,
    },
    title: {
      type: String,
    },
    userLabel: {
      type: Array,
    },
  },
  data() {
    return {
      // dialogVisible: false,
    };
  },
  methods: {
    onCancel() {
      const addDialogVisible = false;
      this.$emit("cancelDialog", addDialogVisible);
    },
    onUpdateUserInfo(userForm) {
      this.$emit("updateUserInfo", userForm);
    },
  },
  mounted() {},
};
</script>

<style></style>
